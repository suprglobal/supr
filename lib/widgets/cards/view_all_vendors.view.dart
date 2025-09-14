import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_routes.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/constants/sizes.dart';
import 'package:superapp/models/search.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/widgets/cards/custom.visibility.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewAllVendorsView extends StatelessWidget {
  const ViewAllVendorsView({
    Key? key,
    required this.vendorType,
  }) : super(key: key);
  final VendorType vendorType;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        CustomVisibilty(
          visible: !AppStrings.enableSingleVendor,
          child: HStack(
            [
              UiSpacer.horizontalSpace(),
              "View all vendors"
                  .tr()
                  .text
                  .center
                  .color(Utils.textColorByPrimaryColor())
                  .size(Sizes.fontSizeDefault)
                  .make()
                  .expand(),
              Icon(
                FlutterIcons.arrow_right_evi,
                color: Utils.textColorByPrimaryColor(),
              )
            ],
          )
              .p8()
              .onInkTap(
                () {
                  //open search with vendor type
                  Navigator.pushNamed(
                    context,
                    AppRoutes.search,
                    arguments: Search(
                      vendorType: vendorType,
                      byLocation: false,
                      showProductsTag: false,
                      showVendorsTag: !vendorType.isService,
                      showServicesTag: false,
                      showProvidesTag: vendorType.isService,
                      type: "vendor",
                      // showType: vendorType.isService ? 5 : 4,
                    ),
                  );
                },
              )
              .box
              .withRounded(value: Sizes.radiusSmall)
              .color(AppColors.primaryColor)
              .make()
              .p12(),
        ),
        CustomVisibilty(
          visible: AppStrings.enableSingleVendor,
          child: HStack(
            [
              UiSpacer.horizontalSpace(),
              (!vendorType.isService
                      ? "View all products".tr()
                      : "View all services".tr())
                  .text
                  .center
                  .color(Utils.textColorByPrimaryColor())
                  .size(Sizes.fontSizeDefault)
                  .make()
                  .expand(),
              Icon(
                Utils.isArabic
                    ? FlutterIcons.arrow_left_evi
                    : FlutterIcons.arrow_right_evi,
                color: Utils.textColorByPrimaryColor(),
              )
            ],
          )
              .p8()
              .onInkTap(
                () {
                  //open search with vendor type
                  Navigator.pushNamed(
                    context,
                    AppRoutes.search,
                    arguments: Search(
                      vendorType: vendorType,
                      byLocation: false,
                      showProductsTag: !vendorType.isService,
                      showVendorsTag: !vendorType.isService,
                      showProvidesTag: vendorType.isService,
                      showServicesTag: vendorType.isService,
                      // showType: vendorType.isService ? 3 : 2,
                    ),
                  );
                },
              )
              .box
              .withRounded(value: Sizes.radiusSmall)
              .color(AppColors.primaryColor)
              .make()
              .p12(),
        )
      ],
    );
  }
}
