import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_finance_settings.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/constants/app_ui_settings.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/profile.vm.dart';
import 'package:superapp/widgets/busy_indicator.dart';
import 'package:superapp/widgets/cards/custom.visibility.dart';
import 'package:superapp/widgets/menu_item.dart';
import 'package:superapp/widgets/states/empty.state.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.model, {Key? key}) : super(key: key);

  final ProfileViewModel model;

  @override
  Widget build(BuildContext context) {
    final iconColor = AppColors.secondaryColor;

    return model.authenticated
        ? Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0.5,
      shadowColor: AppColors.secondaryColor,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [AppConstants.boxShadow]),
              child: VStack([
                //profile card
                HStack([
                      //
                      CachedNetworkImage(
                            imageUrl: model.currentUser?.photo ?? "",
                            progressIndicatorBuilder:
                                (context, imageUrl, progress) {
                                  return BusyIndicator();
                                },
                            errorWidget: (context, imageUrl, progress) {
                              return Image.asset(AppImages.user);
                            },
                          )
                          .wh(Vx.dp64, Vx.dp64)
                          .box
                          .roundedFull.border(
                        color: AppColors.secondaryColor,
                        width: 2
                      )
                          .clip(Clip.antiAlias)
                          .make(),

                      //
                      VStack([
                        //name
                        model.currentUser!.name.text.xl.semiBold.make(),
                        //email
                        model.currentUser!.email.text.light.make(),
                        //share invation code
                        AppStrings.enableReferSystem
                            ? "Share referral code"
                                  .tr()
                                  .text
                                  .sm
                                  .color(context.textTheme.bodyLarge!.color)
                                  .make()
                                  .box
                                  .px4
                                  .roundedSM
                                  .border(color: Colors.grey)
                                  .make()
                                  .onInkTap(model.shareReferralCode)
                                  .py4()
                            : UiSpacer.emptySpace(),
                      ]).px20().expand(),

                      //
                    ])
                    .p12()
                    .wFull(context)
                    .box
                    .make(),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey.shade100,
                ),


                VStack([
                  MenuItem(
                    title: "Edit Profile".tr(),
                    onPressed: model.openEditProfile,
                    prefix: Icon(HugeIcons.strokeRoundedUserEdit01,
                        color: iconColor),
                  ),
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.grey.shade100,
                  ),
                  //change password
                  MenuItem(
                    title: "Change Password".tr(),
                    onPressed: model.openChangePassword,
                    prefix: Icon(HugeIcons.strokeRoundedResetPassword,
                        color: iconColor),
                  ),
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.grey.shade100,
                  ),

                  MenuItem(
                    title: "Delivery Addresses".tr(),
                    onPressed: model.openDeliveryAddresses,
                    prefix: Icon(HugeIcons.strokeRoundedPinLocation01,color: iconColor),
                  ),

                  UiSpacer.vSpace(5),
                ]),
              ]),
            ),
        )
        : EmptyState(
            auth: true,
            showAction: true,
            actionPressed: model.openLogin,
          ).py12();
  }
}
