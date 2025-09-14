import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/extensions/dynamic.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/view_models/profile.vm.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class ReferralBottomsheet extends StatelessWidget {
  const ReferralBottomsheet(
    this.profileViewModel, {
    Key? key,
  }) : super(key: key);

  //
  final ProfileViewModel profileViewModel;

  //
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //image
        Image.asset(
          AppImages.refer,
          width: context.percentWidth * 60,
          height: context.percentWidth * 60,
        ).centered(),
        //title
        "Refer & Earn".tr().text.semiBold.xl.makeCentered().py4(),
        "Share this code with your family and friends and you could earn %s when they completed their first order"
            .tr()
            .fill([
              "${AppStrings.currencySymbol} ${AppStrings.referAmount}"
                  .currencyFormat(),
            ])
            .text
            .center
            .makeCentered(),
        UiSpacer.verticalSpace(),
        UiSpacer.verticalSpace(),
        //referral code
        HStack(
          [
            //code
            "${profileViewModel.currentUser?.code}"
                .text
                .semiBold
                .make()
                .px32()
                .py12()
                .box
                .color(Vx.gray200)
                .make(),
            //share button
            "Share"
                .tr()
                .text
                .color(Utils.isDark(AppColors.primaryColor)
                    ? Colors.white
                    : Colors.black)
                .make()
                .box
                .p12
                .color(AppColors.primaryColor)
                .make()
                .material()
                .onInkTap(profileViewModel.shareReferralCode),
          ],
        ).box.roundedSM.clip(Clip.antiAlias).make().centered(),
      ],
    )
        .p20()
        .scrollVertical()
        .hThreeForth(context)
        .box
        .color(context.theme.colorScheme.surface)
        .topRounded()
        .make();
  }
}
