import 'package:flutter/material.dart';
import 'package:measure_size/measure_size.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/view_models/taxi_new_order_summary.vm.dart';
import 'package:superapp/views/pages/taxi/widgets/order_taxi.button.dart';
import 'package:superapp/views/pages/taxi/widgets/step_two/new_taxi_order_vehicle_type.list_view.dart';
import 'package:velocity_x/velocity_x.dart';

class NewTaxiOrderSummaryPanel extends StatelessWidget {
  const NewTaxiOrderSummaryPanel(
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
      child: VStack(
        [
          VStack(
            [



              InkWell(
                onTap: () {
                  newTaxiOrderSummaryViewModel.closePanel();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: AppColors.appGrey),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(
                    Icons.arrow_downward_rounded,
                    color: AppColors.darkGrey,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              //vehicle types
              TaxiVehicleTypeListView(vm: vm, min: false,isCab: isCab).expand(),
              UiSpacer.vSpace(),
            ],
          ).safeArea().p20().expand(),

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
              .safeArea(top: false)
              .pSymmetric(h: 20, v: 12)
              .box
              .shadow2xl
              .color(context.theme.colorScheme.background)
              .make(),
        ],
      )
          .box
          .color(context.theme.colorScheme.background)
          .topRounded(value: 5)
          .make(),
    );
  }
}
