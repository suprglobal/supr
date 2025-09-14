import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_ui_settings.dart';
import 'package:superapp/constants/sizes.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/views/pages/order/widgets/taxi_order_trip_verification.view.dart';
import 'package:superapp/views/pages/taxi/widgets/driver_info.view.dart';
import 'package:superapp/views/pages/taxi/widgets/safety.view.dart';
import 'package:superapp/widgets/buttons/call.button.dart';
import 'package:superapp/widgets/buttons/custom_text_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:measure_size/measure_size.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:velocity_x/velocity_x.dart';

class TaxiTripReadyView extends StatelessWidget {
  const TaxiTripReadyView(this.vm, {Key? key}) : super(key: key);
  final TaxiViewModel vm;
  @override
  Widget build(BuildContext context) {
    if (vm.onGoingOrderTrip != null && vm.onGoingOrderTrip?.driver != null) {
      return SlidingUpPanel(
      backdropColor: Colors.transparent,
      minHeight: 300,
      maxHeight: context.percentHeight * 70,

      panelBuilder: (sc) {
        return MeasureSize(
          onChange: (size) {
            vm.updateGoogleMapPadding(height: 320);
          },
          child: VStack(
            [
              UiSpacer.swipeIndicator(),
              20.heightBox,
              //driver info
              if(vm.onGoingOrderTrip != null && vm.onGoingOrderTrip?.driver != null)
              TaxiDriverInfoView(
                vm.onGoingOrderTrip!.driver!,
                order: vm.onGoingOrderTrip!,
              ),
              //contact info
              HStack(
                [

                  //call button
                  if (AppUISettings.canCallDriver)
                    CallButton(
                      null,
                      phone: vm.onGoingOrderTrip?.driver!.phone,
                    ),
                ],
                crossAlignment: CrossAxisAlignment.center,
                alignment: MainAxisAlignment.center,
                spacing: 20,
              ).wFull(context).py16(),

              UiSpacer.divider().py12(),
              //trip location details
              "Pickup Location".tr().text.xl.bold.make(),
              "${vm.onGoingOrderTrip?.taxiOrder?.pickupAddress}"
                  .text
                  .lg
                  .medium
                  .make(),
              UiSpacer.verticalSpace(),
              "Dropoff Location".tr().text.xl.bold.make(),
              "${vm.onGoingOrderTrip?.taxiOrder?.dropoffAddress}"
                  .text
                  .lg
                  .medium
                  .make(),
              UiSpacer.divider().py12(),
              //trip codes
              TaxiOrderTripVerificationView(vm.onGoingOrderTrip!),
              //emergency
              SafetyView(),
              // UiSpacer.verticalSpace(),
              UiSpacer.divider().py12(),
              //cancel order button
              //only show if driver is yet to be assigned
              Visibility(
                visible: vm.onGoingOrderTrip?.canCancelTaxi ?? false,
                child:
                InkWell(
                  onTap: ()=> vm.cancelTrip(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,

                    child:   vm.busy(vm.onGoingOrderTrip) ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),

                    ) : Text("Cancel Booking".tr(),
                      style: TextStyle(
                          color: AppColors.getStausColor("failed"),
                          fontWeight: FontWeight.bold

                      ),
                    ),
                  ).centered(),
                ),
              ),
            ],
          )
              .p20()
              .scrollVertical(controller: sc)
              .box
              .color(context.theme.colorScheme.surface)
              .topRounded(value: Sizes.radiusSmall)
              .shadow5xl
              .make(),
        );
      },
    );
    }
    return UiSpacer.emptySpace();
  }
}
