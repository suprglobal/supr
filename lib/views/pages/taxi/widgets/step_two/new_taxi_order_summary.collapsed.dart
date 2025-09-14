import 'package:flutter/material.dart';
import 'package:measure_size/measure_size.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/view_models/taxi_new_order_summary.vm.dart';
import 'package:superapp/views/pages/taxi/widgets/order_taxi.button.dart';
import 'package:superapp/views/pages/taxi/widgets/step_two/new_taxi_order_vehicle_type.list_view.dart';
import 'package:velocity_x/velocity_x.dart';

class NewTaxiOrderSummaryCollapsed extends StatelessWidget {
  const NewTaxiOrderSummaryCollapsed(
    this.newTaxiOrderSummaryViewModel, {
    Key? key, required this.isCab,
  }) : super(key: key);

  final NewTaxiOrderSummaryViewModel newTaxiOrderSummaryViewModel;
  final bool isCab;

  @override
  Widget build(BuildContext context) {
    final TaxiViewModel vm = newTaxiOrderSummaryViewModel.taxiViewModel;
    return MeasureSize(
      onChange: (size) {
        vm.updateGoogleMapPadding(height: size.height + Vx.dp40);
      },
      child: Stack(
        children: [
          VStack(
            [

              Center(
                child: Container(
                  width: 75,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                ),
              ),
              UiSpacer.vSpace(10),
              Text("Ride details",style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              )),
              UiSpacer.vSpace(10),

              //vehicle types
              TaxiVehicleTypeListView(vm: vm,isCab: isCab),
            ],
          ).p20(),
          //action group
          VStack(
            [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Image.asset(AppImages.cash,width: 24,height: 24),
                            Text("Cash",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14

                            )),

                          ],
                        ),
                        Icon(Icons.keyboard_arrow_down,size: 25,color: Colors.grey)
                      ],
                    ),
                  ),
                ],
              ),
              UiSpacer.vSpace(10),
              OrderTaxiButton(vm),
            ],
          )
              .p16()
              .box
          .topRounded()
              .color(context.theme.colorScheme.background)
              .shadow5xl
              .make()
              .positioned(
                bottom: 0,
                left: 0,
                right: 0,
              ),
        ],
      )
          .box
          .color(context.theme.colorScheme.background)
          .topRounded(value: 20)
          .outerShadowXl
          .make(),
    );
  }
}
