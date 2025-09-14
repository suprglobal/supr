import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/views/pages/taxi/widgets/amount_tile.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderTaxiButton extends StatelessWidget {
  const OrderTaxiButton(this.vm, {Key? key}) : super(key: key);

  final TaxiViewModel vm;

  @override
  Widget build(BuildContext context) {
    //
    final currencySymbol = (vm.selectedVehicleType?.currency != null
        ? vm.selectedVehicleType?.currency?.symbol
        : AppStrings.currencySymbol);
    final textColor = Theme.of(context).colorScheme.secondary;
    //
    return Visibility(
      visible: vm.selectedVehicleType != null,
      child: VStack(
        [
          5.heightBox,
          //possible driver eta
          if (vm.possibleDriverETA != null)
            AmountTile(
              "Avg. Driver ETA".tr(),
              "~ ${vm.possibleDriverETA}" + "min(s)".tr() + "",
              amountStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ).px(12),

          //surge rate
          if (vm.selectedVehicleType != null &&
              vm.selectedVehicleType!.hasSurge)
            //show surge rate
            AmountTile(
              "Surge".tr(),
              "x${vm.selectedVehicleType!.surgeRate}",
              amountStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
            ).px(12),

          //
          5.heightBox,
          CustomButton(
            loading: vm.isBusy,
            shapeRadius: 10,
            isFixedHeight: false,
            height: context.percentHeight * 6,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child:  "Book".tr().text.medium.color(textColor).xl.center.bold.make(),
              ),
            ),
            onPressed:
                vm.selectedVehicleType != null ? vm.processNewOrder : null,
          ).wFull(context),
        ],
        spacing: 5,
      ),
    );
  }
}
