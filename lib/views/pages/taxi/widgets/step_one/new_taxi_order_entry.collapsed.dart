import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
 import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/view_models/taxi_new_order_location_entry.vm.dart';
import 'package:superapp/widgets/busy_indicator.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:superapp/widgets/cards/custom.visibility.dart';
import 'package:superapp/widgets/custom_list_view.dart';
import 'package:superapp/widgets/list_items/taxi_order_location_history.list_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';

class NewTaxiOrderEntryCollapsed extends StatelessWidget {
  const NewTaxiOrderEntryCollapsed(this.taxiNewOrderViewModel, {Key? key})
      : super(key: key);

  final NewTaxiOrderLocationEntryViewModel taxiNewOrderViewModel;

  @override
  Widget build(BuildContext context) {
    final TaxiViewModel vm = taxiNewOrderViewModel.taxiViewModel;
    //
    return MeasureSize(
      onChange: (size) {
        vm.updateGoogleMapPadding(
            height: taxiNewOrderViewModel.customViewHeight + 30);
      },
      child: VxBox(
        child: vm.isBusy
            ? BusyIndicator().centered().p20()
            : VStack(
                [
                  // UiSpacer.swipeIndicator(),
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
                  Text("Where to?",style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600
                   )),
                  UiSpacer.vSpace(10),
                  TextFormField(
                    enabled: false,

                    decoration: InputDecoration(
                      hintText: "Enter your destination".tr(),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black26
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),

                      filled: true,
                      fillColor: Colors.grey.shade100,
                      prefixIcon: Icon(FlutterIcons.search1_ant),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:
                        BorderSide.none, // default no border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 1,
                  ) .onTap(
                    taxiNewOrderViewModel.onDestinationPressed,
                  ),

                  SizedBox(height: 5),
                  Padding(
                    padding: (taxiNewOrderViewModel
                            .shortPreviousAddressesList.isEmpty)
                        ? EdgeInsets.all(5)
                        : EdgeInsets.symmetric(vertical: 5),
                    child: CustomListView(
                      isLoading: taxiNewOrderViewModel.busy(
                        taxiNewOrderViewModel.previousAddresses,
                      ),
                      dataSet: taxiNewOrderViewModel.shortPreviousAddressesList,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        final orderAddressHistory = taxiNewOrderViewModel
                            .shortPreviousAddressesList[index];
                        return TaxiOrderHistoryListItem(
                          orderAddressHistory,
                          onPressed:
                              taxiNewOrderViewModel.onDestinationSelected,
                        );
                      },
                      separatorBuilder: (ctx, index) => SizedBox(height: 5),
                    ),
                  ),
                  // SizedBox(height: 34,)
                ],
              ),
      )
          .p20
          .color(context.theme.colorScheme.background)
          .topRounded(value: 25)
          .outerShadow2Xl
          .make(),
    );
  }
}


class NewTaxiOrderEntryCollapsedWidget extends StatelessWidget {
  const NewTaxiOrderEntryCollapsedWidget(this.taxiNewOrderViewModel, {Key? key, required this.type})
      : super(key: key);

  final NewTaxiOrderLocationEntryViewModel taxiNewOrderViewModel;
  final String type;

  @override
  Widget build(BuildContext context) {
    final TaxiViewModel vm = taxiNewOrderViewModel.taxiViewModel;

    log("pick up locationsss : ${vm.pickupLocation?.name} ${vm.pickupLocation?.address}");
    //
    return MeasureSize(
      onChange: (size) {
        vm.updateGoogleMapPadding(
            height: taxiNewOrderViewModel.customViewHeight + 30);
      },
      child: VxBox(
        child:   VStack(
          [
            // UiSpacer.swipeIndicator(),
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
            Text("Pickup details",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
            )),
            // SizedBox(height: 4),
            HStack(
              [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    FlutterIcons.location_pin_sli,
                    size: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                VStack(
                  [
                    "${vm.pickupLocation?.name ?? ""}"
                        .text
                        .semiBold
                        .lg
                        .maxLines(1)
                        .ellipsis
                        .make(),
                    UiSpacer.vSpace(3),
                    "${vm.pickupLocation?.address ?? ""}"
                        .text
                        .maxLines(1)
                        .ellipsis
                        .sm
                        .make(),
                  ],
                ).px12().expand(),
                Icon(
                  Utils.isArabic
                      ? FlutterIcons.chevron_left_ent
                      : FlutterIcons.chevron_right_ent,
                  size: 18,
                  color: Colors.grey.shade300,
                ),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).py8().onInkTap(
                  () {
                // onPressed(taxiOrderLocationHistory);
              },
            ).material(color: context.theme.colorScheme.surface),
            SizedBox(height: 5),
            CustomButton(
              title: "Confirm pickup".tr(),
              titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary
              ),
              shapeRadius: 10,
              onPressed: () {
                print(
                  "pickup location  sss  :  ${vm.pickupLocationTEC.text} ",
                );
                print(
                  "drop off Location sss :  ${vm.dropoffLocationTEC.text} ",
                );

                taxiNewOrderViewModel.moveToNextStep(type);
              },
            ).safeArea(top: false),
          ],
        ),
      )
          .padding(EdgeInsets.symmetric(horizontal:20 ))
          .color(context.theme.colorScheme.background)
          .topRounded(value: 25)
          .outerShadow2Xl
          .make(),
    );
  }
}
