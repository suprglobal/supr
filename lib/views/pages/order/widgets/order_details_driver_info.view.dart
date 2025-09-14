import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_ui_settings.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/order_details.vm.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetailsDriverInfoView extends StatelessWidget {
  const OrderDetailsDriverInfoView(this.vm, {Key? key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return vm.order.driver != null
        ? VStack(
            [
              vm.order.driver != null
                  ? HStack(
                      [
                        //
                        VStack(
                          [
                            "Driver".tr().text.gray500.medium.make(),
                            "${vm.order.driver?.name}"
                                .text
                                .medium
                                .xl
                                .make()
                                .pOnly(bottom: Vx.dp20),
                          ],
                        ).expand(),
                        //call
                        Visibility(
                          visible: vm.order.canChatDriver &&
                              AppUISettings.canCallDriver,
                          child: CustomButton(
                            icon: FlutterIcons.phone_call_fea,
                            iconColor: Colors.white,
                            color: AppColors.primaryColor,
                            shapeRadius: Vx.dp48,
                            onPressed: vm.callDriver,
                          ).wh(Vx.dp64, Vx.dp40).p12(),
                        ),
                      ],
                    )
                  : UiSpacer.emptySpace(),
              if (vm.order.canChatDriver && AppUISettings.canDriverChat)
                CustomButton(
                  icon: FlutterIcons.chat_ent,
                  iconColor: Colors.white,
                  title: "Chat with driver".tr(),
                  color: AppColors.primaryColor,
                  // onPressed: vm.chatDriver,
                ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20),

              //rate driver
              vm.order.canRateDriver
                  ? CustomButton(
                      icon: FlutterIcons.rate_review_mdi,
                      iconColor: Colors.white,
                      title: "Rate The Driver".tr(),
                      color: AppColors.primaryColor,
                      onPressed: vm.rateDriver,
                    ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
                  : UiSpacer.emptySpace(),
            ],
          ).px(20)
        : UiSpacer.emptySpace();
  }
}
