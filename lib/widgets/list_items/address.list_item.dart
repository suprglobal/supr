import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/models/address.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressListItem extends StatelessWidget {
  const AddressListItem(
    this.address, {
    required this.onAddressSelected,
    Key? key,
  }) : super(key: key);

  final Address address;
  final Function(Address) onAddressSelected;
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
        UiSpacer.hSpace(10),
        //
        VStack(
          [
            "${address.featureName}"
                .text
                .maxLines(1)
                .ellipsis
                .minFontSize(13)
                .maxFontSize(13)
                .semiBold
                .lg
                .make(),
            //address line
            if (address.addressLine != address.featureName) 3.heightBox,
            //address
            if (address.addressLine != address.featureName)
              "${address.addressLine}"
                  .text
                  .maxLines(1)
                  .ellipsis
                  .thin
                  .light
                  .sm
                  .color(
                      context.isDarkMode ? Colors.white : Colors.grey.shade700)
                  .make(),
          ],
        ).expand(),
      ],
      crossAlignment: CrossAxisAlignment.center,
      alignment: MainAxisAlignment.center,
    ).pLTRB(16, 8, 16, 8).onInkTap(
      () {
        onAddressSelected(address);
      },
    ).material(color: Colors.transparent);
  }
}
