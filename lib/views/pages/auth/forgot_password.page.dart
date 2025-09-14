import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/services/validator.service.dart';
import 'package:superapp/utils/ui_spacer.dart';

import 'package:superapp/view_models/forgot_password.view_model.dart';
import 'package:superapp/widgets/base.page.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:superapp/widgets/custom_text_form_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(context),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          body: SafeArea(
            top: true,
            bottom: false,
            child: VStack(
              [
                Image.asset(
                  AppImages.forgotPasswordImage,
                ).hOneForth(context).centered(),
                //
                VStack(
                  [
                    //
                    "Forgot Password".tr().text.xl2.semiBold.make(),

                    //form
                    Form(
                      key: model.formKey,
                      child: VStack(
                        [
                          //
                          CustomTextFormField(
                            prefixIcon: HStack(
                              [
                                //icon/flag
                                Flag.fromString(
                                  model.selectedCountry?.countryCode ?? "us",
                                  width: 20,
                                  height: 20,
                                ),
                                UiSpacer.horizontalSpace(space: 5),
                                //text
                                ("+" +
                                        (model.selectedCountry?.phoneCode ??
                                            "1"))
                                    .text
                                    .make(),
                              ],
                            ).px8().onInkTap(model.showCountryDialPicker),
                            labelText: "Phone Number".tr(),
                            hintText: "",
                            keyboardType: TextInputType.phone,
                            textEditingController: model.phoneTEC,
                            validator: FormValidator.validatePhone,
                          ).py12(),
                          //
                          CustomButton(
                            title: "Send OTP".tr(),
                            loading: model.isBusy ||
                                model.busy(model.firebaseVerificationId),
                            onPressed: model.processForgotPassword,
                          ).h(Vx.dp48).centered().py12(),
                        ],
                        crossAlignment: CrossAxisAlignment.end,
                      ),
                    ).py20(),
                  ],
                ).wFull(context).p20(),

                //
              ],
            ).scrollVertical(),
          ),
        );
      },
    );
  }
}
