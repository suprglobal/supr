import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
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

class HorizontalVehicleTypeListItem extends StatelessWidget {
  const HorizontalVehicleTypeListItem(
    this.vm,
    this.vehicleType, {
    Key? key, this.isCab = false,
  }) : super(key: key);
  final VehicleType vehicleType;
  final TaxiViewModel vm;
  final bool isCab;
  @override
  Widget build(BuildContext context) {
    //
    final selected = vm.selectedVehicleType?.id == vehicleType.id;
    final currencySymbol = vehicleType.currency != null
        ? vehicleType.currency?.symbol
        : AppStrings.currencySymbol;
    //
    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow:  selected ? [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ] : null
      ),
      child: InkWell(
        onTap: () {
          vm.changeSelectedVehicleType(vehicleType);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Image.asset(
             isCab ? AppImages.rides : AppImages.bikeRide,
              width: 55,
              height: 50,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  "${vehicleType.name}".text.bold.maxLines(1).ellipsis.make(),
                  Row(
                    spacing: 3,
                    children: [
                      Icon(Icons.person,size: 14,                             color: Colors.black26,
                      ),
                      Expanded(
                        child: Text("${vehicleType.seater.split('-').first}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 12
                          ),
                        ),
                      )
                    ],
                  ),
                  Text("${vehicleType.seater.split('-').last}",
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 11,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CurrencyHStack([
                  " $currencySymbol ".text.extraBold.make(),
                  " ${vehicleType.total}"
                      .currencyValueFormat()
                      .text
                      .extraBold
                      .make(),
                ]),
                Text("1 min",style: TextStyle(
                    fontSize: 11,
                    color: Colors.black26,
                    fontWeight: FontWeight.w600

                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
