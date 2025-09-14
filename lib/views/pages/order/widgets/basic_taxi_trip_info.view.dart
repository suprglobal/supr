import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/widgets/currency_hstack.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class BasicTaxiTripInfoView extends StatelessWidget {
  BasicTaxiTripInfoView(this.order, {Key? key}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: VStack(
        [
          //date, code, amount
          HStack(
            [
              VStack(
                [
                  "${DateFormat("dd MMM y 'at' H:m a").format(order.createdAt)}"
                      .text
                      .medium
                      .lg
                      .make(),
                  order.Taxistatus.tr()
                      .text
                      .color(AppColors.getStausColor(order.status))
                      .medium
                      .xl
                      .make(),
                ],
              ).expand(),
              //total amount
              VStack(
                [
                  "#${order.code}".text.light.make(),
                  CurrencyHStack(
                    [
                      "${order.taxiOrder!.currency != null ? order.taxiOrder!.currency!.symbol : AppStrings.currencySymbol}"
                          .text
                          .semiBold
                          .xl
                          .make(),
                      "${(order.total ?? 0.00).currencyValueFormat()}"
                          .text
                          .semiBold
                          .xl2
                          .make()
                    ],
                  ),
                ],
                crossAlignment: CrossAxisAlignment.end,
                alignment: MainAxisAlignment.end,
              ),
            ],
            crossAlignment: CrossAxisAlignment.start,
          ),
          //pickup/dropoff
          Timeline.tileBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            builder: TimelineTileBuilder.connected(
              itemCount: 2,
              contentsAlign: ContentsAlign.basic,
              nodePositionBuilder: (context, index) => 0.00,
              indicatorBuilder: (context, index) {
                return DotIndicator(
                  color: AppColors.primaryColor,
                  size: 28,
                  child: Icon(
                    index == 0
                        ? FlutterIcons.my_location_mdi
                        : FlutterIcons.location_pin_ent,
                    size: 20,
                    color: Utils.textColorByTheme(),
                  ).p4(),
                );
              },
              connectorBuilder: (context, index, connectorType) {
                return DashedLineConnector(
                  color: Colors.grey.shade600,
                  gap: 5,
                  space: 5,
                  indent: 5,
                );
              },
              contentsBuilder: (context, index) {
                return VStack(
                  [
                    //if created at is not null
                    Text(
                      index == 0
                          ? "Pickup Location".tr()
                          : "Drop Off Location".tr(),
                      style: context.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      index == 0
                          ? order.taxiOrder!.pickupAddress
                          : order.taxiOrder!.dropoffAddress,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).p(Vx.dp20);
              },
            ),
          ),
        ],
      ).px20().py12(),
    ).shadowXs.color(context.theme.colorScheme.surface).make();
  }
}
