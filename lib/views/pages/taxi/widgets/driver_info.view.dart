import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/models/driver.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class TaxiDriverInfoView extends StatelessWidget {
  const TaxiDriverInfoView(this.driver, {required this.order, Key? key})
    : super(key: key);
  final Order order;
  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return VStack([
      // basic info
      VStack([
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: ("${driver.vehicle?.reg_no}").split("").map((digit) {
            return Container(
              margin: const EdgeInsets.all(1.5),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(digit, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
        ),
      ], crossAlignment: CrossAxisAlignment.end),
      SizedBox(height: 10),
      HStack([
        //
        CustomImage(
          imageUrl: driver.photo,
          width: 50,
          height: 50,
        ).box.roundedFull.clip(Clip.antiAlias).make(),
        //driver info
        VStack([
          // "${driver.name}".text.sm.xl.make(),
          Text(
            "${driver.name}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          //rating
          // SizedBox(height: 5),
          Text(
            "${driver.vehicle?.vehicleInfo}",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),

        ]).px12().expand(),

        //vehicle info
      ]),

      //handling driver status
      "${driverTripStatus(order)}".text.xl
          // .color(Utils.textColorByColor(AppColors.getStausColor(order.status)))
          .color(Colors.white)
          .makeCentered()
          .p(5)
          .p4()
          .box
          .withRounded(value: 8)
          .border(color: AppColors.getStausColor(order.status).withOpacity(0.6))
          .color(Theme.of(context).primaryColor)
          .make()
          .pOnly(top: 20),
    ]);
  }

  String driverTripStatus(Order order) {
    //if order is not null, convert status to human readable representation of driver status
    //status: 'pending','preparing','ready','enroute','delivered','failed','cancelled'
    switch (order.status) {
      case "pending":
        return "Searching for driver".tr();
      case "preparing":
        return "Driver on the way to you".tr();
      case "ready":
        return "Driver has arrived your pickup location".tr();
      case "enroute":
        return "Driver enroute to dropoff location".tr();
      case "delivered":
        return "Driver has dropped you".tr();
      case "completed":
        return "Trip completed".tr();
      case "failed":
        return "Trip failed".tr();
      default:
        return "Driver is on the way".tr();
    }
  }
}
