import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/order_details.vm.dart';
import 'package:superapp/views/pages/order/widgets/basic_taxi_trip_info.view.dart';
import 'package:superapp/views/pages/order/widgets/order_payment_info.view.dart';
import 'package:superapp/views/pages/order/widgets/order_driver_info.view.dart';
import 'package:superapp/views/pages/order/widgets/taxi_order_trip_verification.view.dart';
import 'package:superapp/views/pages/taxi/widgets/amount_tile.dart';
import 'package:superapp/widgets/base.page.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:superapp/widgets/cards/order_summary.dart';
import 'package:velocity_x/velocity_x.dart';

import 'widgets/taxi_trip_map.preview.dart';

class TaxiOrderDetailPage extends StatefulWidget {
  const TaxiOrderDetailPage({
    required this.order,
    Key? key,
  }) : super(key: key);

  //
  final Order order;

  @override
  _TaxiOrderDetailPageState createState() => _TaxiOrderDetailPageState();
}

class _TaxiOrderDetailPageState extends State<TaxiOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    //
    return ViewModelBuilder<OrderDetailsViewModel>.reactive(
      viewModelBuilder: () => OrderDetailsViewModel(context, widget.order),
      onViewModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        //
        String currencySymbol = vm.order.taxiOrder!.currencySymbol;

        //
        return BasePage(
          title: "Trip Details".tr(),
          elevation: 0,
          showAppBar: true,
          showLeadingAction: true,
          isLoading: vm.isBusy,
          body: VStack(
            [
              //taxi trip map preview
              TaxiTripMapPreview(vm.order),
              //basic info
              BasicTaxiTripInfoView(vm.order),
              UiSpacer.vSpace(),

              //payment status
              OrderPaymentInfoView(vm)
                  .wFull(context)
                  .box
                  .shadowXs
                  .color(context.theme.colorScheme.surface)
                  .make(),
              //driver
              OrderDriverInfoView(
                vm.order,
                rateDriverAction: vm.rateDriver,
              ),
              //trip codes
              TaxiOrderTripVerificationView(vm.order),

              //order summary
              OrderSummary(
                subTotal: vm.order.subTotal!,
                discount: vm.order.discount ?? 0,
                driverTip: vm.order.tip ?? 0,
                tax: vm.order.tax,
                total: vm.order.total!,
                mCurrencySymbol:
                    "${vm.order.taxiOrder!.currency != null ? vm.order.taxiOrder!.currency!.symbol : AppStrings.currencySymbol}",
                //
                customWidget: VStack(
                  [
                    AmountTile(
                      "Base Fare".tr(),
                      "${currencySymbol} ${vm.order.taxiOrder!.base_fare ?? 0}"
                          .currencyFormat(currencySymbol),
                    ).py2(),
                    AmountTile(
                      ("Trip Distance".tr() + " (Km)"),
                      "${vm.order.taxiOrder!.trip_distance ?? 0}  (${vm.order.taxiOrder!.distance_fare ?? 0}/Km)",
                    ).py2(),
                    AmountTile(
                      "Trip Duration".tr(),
                      "${vm.order.taxiOrder!.trip_time ?? 0}  (${vm.order.taxiOrder!.time_fare ?? 0}/${'Minute'.tr()})",
                    ).py2(),
                    DottedLine(
                      dashColor: context.textTheme.bodyLarge!.color!,
                    ).py8(),
                  ],
                ),
              )
                  .px20()
                  .py12()
                  .box
                  .shadowXs
                  .color(context.theme.colorScheme.surface)
                  .make()
                  .pSymmetric(v: 20),
              (context.percentHeight * 20).heightBox,
            ],
          ).scrollVertical(),
          bottomSheet: vm.order.isScheduled
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CustomButton(
                    loading: vm.busy(vm.order),
                    color: AppColors.closeColor,
                    title: "Cancel Order".tr(),
                    onPressed: vm.cancelOrder,
                  ),
                )
              : null,
        );
      },
    );
  }
}
