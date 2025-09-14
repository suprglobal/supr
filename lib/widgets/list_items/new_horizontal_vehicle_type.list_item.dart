import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/vehicle_type.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/widgets/currency_hstack.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHorizontalVehicleTypeListItem extends StatelessWidget {
  const NewHorizontalVehicleTypeListItem(
    this.vm,
    this.vehicleType, {
    Key? key,
  }) : super(key: key);
  final VehicleType vehicleType;
  final TaxiViewModel vm;
  @override
  Widget build(BuildContext context) {
    //
    final selected = vm.selectedVehicleType?.id == vehicleType.id;
    final currencySymbol = vehicleType.currency != null
        ? vehicleType.currency?.symbol
        : AppStrings.currencySymbol;
    //
    return HStack(
      [
        //
        CustomImage(
          imageUrl: vehicleType.photo,
          width: context.percentWidth * 12,
          height: context.percentWidth * 12,
          boxFit: BoxFit.contain,
        ),

        VStack(
          [
            "${vehicleType.name}".text.bold.maxLines(1).ellipsis.make(),
            UiSpacer.vSpace(3),
            HStack(
              [
                CurrencyHStack(
                  [
                    "min".tr(),
                    " ",
                    "$currencySymbol",
                    vehicleType.minFare.currencyValueFormat()
                  ],
                  textSize: 12,
                  textColor: Colors.grey.shade600,
                ),
                DotIndicator(size: 5, color: Colors.grey.shade600).px8(),
                CurrencyHStack(
                  [
                    "base".tr(),
                    " ",
                    "$currencySymbol",
                    vehicleType.baseFare.currencyValueFormat()
                  ],
                  textSize: 12,
                  textColor: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ).px8().expand(),
        //prices
        VStack(
          [
            CurrencyHStack(
              [
                " $currencySymbol ".text.lg.bold.make(),
                " ${vehicleType.total} "
                    .currencyValueFormat()
                    .text
                    .lg
                    .bold
                    .make(),
              ],
            ),

            // surge rate
            if (vehicleType.hasSurge)
              HStack(
                [
                  Icon(
                    Icons.trending_up_outlined,
                    color: Colors.red.shade300,
                    size: 12,
                  ),
                  " ${vehicleType.surgeRate}x ".text.sm.red500.bold.make(),
                ],
              ),
          ],
        ),
      ],
      alignment: MainAxisAlignment.center,
      // crossAlignment: CrossAxisAlignment.center,
    )
        .box
        .p12
        .border(
          color: selected ? AppColors.primaryColor : Colors.grey.shade200,
          width: 1,
        )
        .color(selected
            ? AppColors.primaryColor.withOpacity(0.20)
            : AppColors.primaryColor.withOpacity(0.05))
        .roundedSM
        .make()
        .onTap(
          () => vm.changeSelectedVehicleType(vehicleType),
        )
        .wFull(context);
  }
}
