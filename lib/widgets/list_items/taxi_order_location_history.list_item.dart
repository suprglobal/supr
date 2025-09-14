import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/models/tax_order_location.history.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class TaxiOrderHistoryListItem extends StatelessWidget {
  const TaxiOrderHistoryListItem(
    this.taxiOrderLocationHistory, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final TaxiOrderLocationHistory taxiOrderLocationHistory;
  final Function(TaxiOrderLocationHistory) onPressed;
  @override
  Widget build(BuildContext context) {
    return HStack(
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
            "${taxiOrderLocationHistory.name}"
                .text
                .semiBold
                .lg
                .maxLines(1)
                .ellipsis
                .make(),
            UiSpacer.vSpace(3),
            "${taxiOrderLocationHistory.address}"
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
        onPressed(taxiOrderLocationHistory);
      },
    ).material(color: context.theme.colorScheme.surface);
  }
}
