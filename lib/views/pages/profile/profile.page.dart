import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/profile.vm.dart';
import 'package:superapp/widgets/base.page.dart';
import 'package:superapp/widgets/cards/profile.card.dart';
import 'package:superapp/widgets/menu_item.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {


  final iconColor = AppColors.secondaryColor;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(context),
      onViewModelReady: (model) => model.initialise(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          child: BasePage(
             customAppbar: AppBar(
               backgroundColor: Theme.of(context).primaryColor,
               iconTheme: const IconThemeData(color: Colors.white),
               automaticallyImplyLeading: false,
               title: Column(
                 children: [
                   "Settings".tr().text.xl2.semiBold.color(Colors.white).make(),
                   // "Profile & App Settings".tr().text.lg.color(Colors.white).light.make(),
                 ],
               )
             ),
            body: VStack(
              [
                //

                "Profile & App Settings".tr().text.lg.light.make(),
                SizedBox(height: 5),

                //profile card

                ProfileCard(model).py12(),

                //menu
                Card(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(25),
                   ),
                  shadowColor: AppColors.secondaryColor,
                  elevation: 0.5,

                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [AppConstants.boxShadow]),
                    child: VStack(
                      [

                        MenuItem(
                          title: "Notifications".tr(),
                          prefix: Icon(HugeIcons.strokeRoundedNotification01,color: iconColor),
                          onPressed: model.openNotification,
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),

                        MenuItem(
                          title: "Faqs".tr(),
                          onPressed: model.openFaqs,
                          prefix: Icon(HugeIcons.strokeRoundedQuestion,color: iconColor),
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),
                        //
                        MenuItem(
                          title: "Privacy Policy".tr(),
                          onPressed: model.openPrivacyPolicy,
                          prefix: Icon(HugeIcons.strokeRoundedBook02,color: iconColor),
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),
                        //
                        MenuItem(
                          title: "Terms & Conditions".tr(),
                          onPressed: model.openTerms,
                          prefix: Icon(HugeIcons.strokeRoundedShield01,color: iconColor),
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),
                        //START NEW LINKS
                        MenuItem(
                          title: "Refund Policy".tr(),
                          onPressed: model.openRefundPolicy,
                          prefix: Icon(HugeIcons.strokeRoundedReturnRequest,color: iconColor),
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),
                        MenuItem(
                          title: "Cancellation Policy".tr(),
                          onPressed: model.openCancellationPolicy,
                          prefix: Icon(HugeIcons.strokeRoundedCancel01,color: iconColor),
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),
                        MenuItem(
                          title: "Delivery/Shipping Policy".tr(),
                          onPressed: model.openShippingPolicy,
                          prefix: Icon(HugeIcons.strokeRoundedShoppingBag01,color: iconColor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadowColor: AppColors.secondaryColor,
                  elevation: 0.5,

                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [AppConstants.boxShadow]),
                    child: VStack(
                      [
                        MenuItem(
                          title: "Logout".tr(),
                          onPressed: model.logoutPressed,
                          suffix: Icon(HugeIcons.strokeRoundedLogout01, size: 20,color: iconColor),
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.grey.shade100,
                        ),
                        MenuItem(
                          child: "Delete Account".tr().text.red500.make(),
                          onPressed: model.deleteAccount,
                          suffix: Icon(
                            HugeIcons.strokeRoundedDelete01,
                            size: 20,
                            color: Vx.red400,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                model.appVersionInfo.text.sm.medium.gray400.makeCentered().py20(),
                //
                UiSpacer.verticalSpace(space: context.percentHeight * 10),
              ],
            ).p20().scrollVertical(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}



