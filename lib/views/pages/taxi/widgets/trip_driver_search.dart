import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/widgets/busy_indicator.dart';
import 'package:superapp/widgets/buttons/custom_text_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';

class TripDriverSearch extends StatelessWidget {
  const TripDriverSearch(this.vm, {Key? key}) : super(key: key);
  final TaxiViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // bottom: Vx.dp20,
      // left: Vx.dp20,
      // right: Vx.dp20,
      bottom: 0,
      child: MeasureSize(
        onChange: (size) {
          vm.updateGoogleMapPadding(height: size.height);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular()
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                ),
              ),
              SizedBox(height: 10),

              Text(
                "Ride Requested",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "Finding drivers nearby",
                style: TextStyle(
                  fontSize: 16,
                  height: 0.1,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(height: 30),
              LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200, width: 2),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ride details",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).hintColor.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            "Meet at the pickup point for\n${vm.pickupLocation?.address}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.shade200,
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   padding: EdgeInsets.all(6),
                    //   child: Icon(Icons.more_horiz_outlined),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
          ),
        ),

      ),
    );
  }
}
