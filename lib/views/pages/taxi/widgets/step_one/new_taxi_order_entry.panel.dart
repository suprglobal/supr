import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/view_models/taxi_new_order_location_entry.vm.dart';
import 'package:superapp/widgets/busy_indicator.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:superapp/widgets/custom_list_view.dart';
import 'package:superapp/widgets/list_items/address.list_item.dart';
import 'package:velocity_x/velocity_x.dart';

class NewTaxiOrderEntryPanel extends StatelessWidget {
  const NewTaxiOrderEntryPanel(
    this.taxiNewOrderViewModel, {
    Key? key,
    required this.type,
    required this.pickup,
  }) : super(key: key);

  final NewTaxiOrderLocationEntryViewModel taxiNewOrderViewModel;
  final String type;
  final String pickup;

  @override
  Widget build(BuildContext context) {
    final TaxiViewModel vm = taxiNewOrderViewModel.taxiViewModel;
    return VxBox(
          child:
              vm.isBusy
                  ? BusyIndicator().centered().p20()
                  : VStack([
                    VStack([

                          InkWell(
                            onTap: () {
                              taxiNewOrderViewModel.closePanel();
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

                          // UiSpacer.verticalSpace(),
                          SizedBox(height: 15),

                          // schedule order
                          // NewTaxiOrderScheduleView(taxiNewOrderViewModel),
                          // entry
                           // HStack(
                          //   [
                          //     //
                          //     CustomTimelineConnector(height: 50),
                          //     UiSpacer.hSpace(10),
                          //     //
                          //     VStack(
                          //       [
                          //         TaxiCustomTextFormField(
                          //           hintText: "Pickup Location".tr(),
                          //           controller: vm.pickupLocationTEC,
                          //           focusNode: vm.pickupLocationFocusNode,
                          //           onChanged: taxiNewOrderViewModel.searchPlace,
                          //           clear: true,
                          //
                          //         ),
                          //         // UiSpacer.vSpace(5),
                          //         // TaxiCustomTextFormField(
                          //         //   hintText: "Drop-off Location".tr(),
                          //         //   controller: vm.dropoffLocationTEC,
                          //         //   focusNode: vm.dropoffLocationFocusNode,
                          //         //   onChanged: taxiNewOrderViewModel.searchPlace,
                          //         //   clear: true,
                          //         // ),
                          //       ],
                          //     ).expand(),
                          //   ],
                          // ):


                          TextFormField(
                            controller: vm.dropoffLocationTEC,
                            focusNode: vm.dropoffLocationFocusNode,
                            onChanged: taxiNewOrderViewModel.searchPlace,
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
                              suffixIcon: Icon(
                                FlutterIcons.close_ant,
                              ).onInkTap(() {
                                vm.dropoffLocationTEC.clear();
                              }),
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
                          ),
                        ])
                        .p20()
                        .safeArea()
                        .box
                        // .shadowSm
                        .color(context.theme.colorScheme.surface)
                        .make(),
                    //list of search result,
                    CustomListView(
                      padding: EdgeInsets.zero,
                      isLoading: taxiNewOrderViewModel.busy(
                        taxiNewOrderViewModel.places,
                      ),
                      dataSet:
                          taxiNewOrderViewModel.places != null
                              ? taxiNewOrderViewModel.places!
                              : [],
                      itemBuilder: (contex, index) {
                        final place = taxiNewOrderViewModel.places![index];
                        return GestureDetector(
                          child: AddressListItem(
                            place,
                            onAddressSelected:
                                taxiNewOrderViewModel.onAddressSelected,
                          ),
                          onTap: (){
                            print("Test tap at index $index"); // extra debug print

                          },
                        );
                      },
                      separatorBuilder: (ctx, index) => SizedBox(height: 5),
                    ).expand(),
                    //select on map
                    // NewTaxiPickOnMapButton(
                    //   taxiNewOrderViewModel: taxiNewOrderViewModel,
                    // ),
                    Visibility(
                      visible:
                          !vm.pickupLocationFocusNode.hasFocus &&
                          !vm.dropoffLocationFocusNode.hasFocus,
                      child: CustomButton(
                        title: "Next".tr(),
                        titleStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary
                        ),
                        shapeRadius: 10,
                        onPressed: () {
                          print(
                            "pickup location  :  ${vm.pickupLocationTEC.text} ",
                          );
                          print(
                            "drop off Location  :  ${vm.dropoffLocationTEC.text} ",
                          );

                          taxiNewOrderViewModel.destinationChange(true);

                            // taxiNewOrderViewModel.moveToNextStep(type);
                        },
                      ).p8().safeArea(top: false),
                    ),

                    // HorizontalVehicleTypeListItem(taxiNewOrderViewModel: taxiNewOrderViewModel,),
                    // HorizontalVehicleTypeListItem(vm,),
                  ]),

          // VStack(
          //         [
          //           VStack(
          //             [
          //               //
          //               HStack(
          //                 [
          //                   Icon(
          //                     FlutterIcons.close_ant,
          //                   ).onTap(taxiNewOrderViewModel.closePanel),
          //                   "Your routes".tr().text.bold.xl.make().px12().expand(),
          //                 ],
          //               ),
          //
          //               UiSpacer.verticalSpace(),
          //               //schedule order
          //               // NewTaxiOrderScheduleView(taxiNewOrderViewModel),
          //               //entry
          //               HStack(
          //                 [
          //                   //
          //                   CustomTimelineConnector(height: 50),
          //                   UiSpacer.hSpace(10),
          //                   //
          //                   VStack(
          //                     [
          //                       TaxiCustomTextFormField(
          //                         hintText: "Pickup Location".tr(),
          //                         controller: vm.pickupLocationTEC,
          //                         focusNode: vm.pickupLocationFocusNode,
          //                         onChanged: taxiNewOrderViewModel.searchPlace,
          //                         clear: true,
          //                       ),
          //                       UiSpacer.vSpace(5),
          //                       TaxiCustomTextFormField(
          //                         hintText: "Drop-off Location".tr(),
          //                         controller: vm.dropoffLocationTEC,
          //                         focusNode: vm.dropoffLocationFocusNode,
          //                         onChanged: taxiNewOrderViewModel.searchPlace,
          //                         clear: true,
          //                       ),
          //                     ],
          //                   ).expand(),
          //                 ],
          //               ),
          //             ],
          //           )
          //               .p20()
          //               .safeArea()
          //               .box
          //               .shadowSm
          //               .color(context.theme.colorScheme.surface)
          //               .make(),
          //           //list of search result,
          //           CustomListView(
          //             padding: EdgeInsets.zero,
          //             isLoading:
          //                 taxiNewOrderViewModel.busy(taxiNewOrderViewModel.places),
          //             dataSet: taxiNewOrderViewModel.places != null
          //                 ? taxiNewOrderViewModel.places!
          //                 : [],
          //             itemBuilder: (contex, index) {
          //               final place = taxiNewOrderViewModel.places![index];
          //               return AddressListItem(
          //                 place,
          //                 onAddressSelected:
          //                     taxiNewOrderViewModel.onAddressSelected,
          //               );
          //             },
          //             separatorBuilder: (ctx, index) => UiSpacer.divider(),
          //           ).expand(),
          //           //select on map
          //           NewTaxiPickOnMapButton(
          //             taxiNewOrderViewModel: taxiNewOrderViewModel,
          //           ),
          //           Visibility(
          //             visible: !vm.pickupLocationFocusNode.hasFocus &&
          //                 !vm.dropoffLocationFocusNode.hasFocus,
          //             child: CustomButton(
          //               title: "Next".tr(),
          //               onPressed: ()=>taxiNewOrderViewModel.moveToNextStep(type),
          //             ).p8().safeArea(top: false),
          //           ),
          //
          //           // HorizontalVehicleTypeListItem(taxiNewOrderViewModel: taxiNewOrderViewModel,),
          //           // HorizontalVehicleTypeListItem(vm,),
          //
          //           ],
          //       ),
        )
        .color(
          vm.isBusy
              ? context.theme.colorScheme.surface.withOpacity(0.5)
              : context.theme.colorScheme.surface,
        ).topRounded(value: 20)
        .make()
        .pOnly(bottom: context.mq.viewInsets.bottom);
  }
}
class NewTaxiOrderEntryPanelWidget extends StatefulWidget {
  const NewTaxiOrderEntryPanelWidget(
      this.taxiNewOrderViewModel, {
        Key? key,
        required this.type,
      }) : super(key: key);

  final NewTaxiOrderLocationEntryViewModel taxiNewOrderViewModel;
  final String type;

  @override
  State<NewTaxiOrderEntryPanelWidget> createState() =>
      _NewTaxiOrderEntryPanelWidgetState();
}

class _NewTaxiOrderEntryPanelWidgetState
    extends State<NewTaxiOrderEntryPanelWidget> {
  late TaxiViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = widget.taxiNewOrderViewModel.taxiViewModel;

    // Ensure focus + controllers
    vm.pickupLocationFocusNode ??= FocusNode();
    vm.dropoffLocationFocusNode ??= FocusNode();
    vm.pickupLocationTEC ??= TextEditingController();
    vm.dropoffLocationTEC ??= TextEditingController();
  }

  @override
  void dispose() {
    vm.pickupLocationFocusNode.dispose();
    vm.dropoffLocationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: VStack([
        VStack([

          SizedBox(height: 100,),
          // Close button
          InkWell(
            onTap: () {
              widget.taxiNewOrderViewModel.closePanel();
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

          const SizedBox(height: 15),

          // 👇 Pickup TextField (drag disabled here)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragDown: (_) {

            }, // disable drag on this area
            child: TextFormField(
              controller: vm.pickupLocationTEC,
              focusNode: vm.pickupLocationFocusNode,
              readOnly: false,
              onChanged: widget.taxiNewOrderViewModel.searchPlace,
              decoration: InputDecoration(
                hintText: "Enter your pickup".tr(),
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black26,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: const Icon(FlutterIcons.search1_ant),
                suffixIcon: Icon(
                  FlutterIcons.close_ant,
                ).onInkTap(() {
                  vm.pickupLocationTEC.clear();
                }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 1,
            ),
          ),

          const SizedBox(height: 15),

          // 👇 Dropoff TextField (drag disabled here)
         ])
            .p20()
            .safeArea()
            .box
            .color(context.theme.colorScheme.surface)
            .make(),

        // Search results
        CustomListView(
          padding: EdgeInsets.zero,
          isLoading: widget.taxiNewOrderViewModel.busy(
            widget.taxiNewOrderViewModel.places,
          ),
          dataSet: widget.taxiNewOrderViewModel.places ?? [],
          itemBuilder: (contex, index) {
            final place = widget.taxiNewOrderViewModel.places![index];
            return AddressListItem(
              place,
              onAddressSelected:
              widget.taxiNewOrderViewModel.onAddressSelected1,
            );
          },
          separatorBuilder: (ctx, index) => const SizedBox(height: 5),
        ).expand(),

        // Next button
        CustomButton(
          title: "Next".tr(),
          titleStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary
          ),
          shapeRadius: 10,
          onPressed: () {
            print("pickup: ${vm.pickupLocationTEC.text}");
            print("dropoff: ${vm.dropoffLocationTEC.text}");
            widget.taxiNewOrderViewModel.destinationChange(true);
            widget.taxiNewOrderViewModel.moveToNextStep(widget.type);
          },
        ).p8().safeArea(top: false),
      ]),
    )
        .color(
      vm.isBusy
          ? context.theme.colorScheme.surface.withOpacity(0.5)
          : context.theme.colorScheme.surface,
    )
        .topRounded(value: 20)
        .make()
        .pOnly(bottom: context.mq.viewInsets.bottom);
  }
}






