import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/extensions/context.dart';
import 'package:superapp/services/validator.service.dart';
import 'package:superapp/view_models/forgot_password.view_model.dart';
import 'package:superapp/widgets/base.page.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:superapp/widgets/buttons/custom_leading.dart';
import 'package:superapp/widgets/custom_text_form_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class NewPasswordEntry extends StatefulWidget {
  const NewPasswordEntry({
    required this.onSubmit,
    required this.vm,
    Key? key,
  }) : super(key: key);

  final Function(String) onSubmit;
  final ForgotPasswordViewModel vm;

  @override
  _NewPasswordEntryState createState() => _NewPasswordEntryState();
}

class _NewPasswordEntryState extends State<NewPasswordEntry> {
  final resetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //

    return BasePage(
      showAppBar: true,
      showLeadingAction: true,
      appBarColor: AppColors.primaryColor,
      title: "New Password".tr(),
      elevation: 0,
      leading: CustomLeading().onInkTap(() {
        context.pop();
      }),
      body: Form(
        key: resetFormKey,
        child: VStack(
          [
            //
            // "New Password".tr().text.bold.xl2.makeCentered(),
            "Please enter account new password".tr().text.makeCentered(),
            //pin code
            CustomTextFormField(
              labelText: "New Password".tr(),
              textEditingController: widget.vm.passwordTEC,
              validator: FormValidator.validatePassword,
              obscureText: true,
            ).py12(),

            //submit
            CustomButton(
              title: "Reset Password".tr(),
              onPressed: () {
                if (resetFormKey.currentState!.validate()) {
                  widget.onSubmit(widget.vm.passwordTEC.text);
                }
              },
            ).h(Vx.dp48),
          ],
        ).p20(),
      ),
    );
  }
}
