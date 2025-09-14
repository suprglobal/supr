import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/extensions/dynamic.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/service.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/widgets/cards/vendor_info.view.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:superapp/widgets/custom_network_image.dart';
import 'package:superapp/widgets/states/alternative.view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ServiceGridViewItem extends StatelessWidget {
  const ServiceGridViewItem({
    required this.service,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Function(Service) onPressed;
  final Service service;

  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(service),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(

        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [


                ClipRRect(
                  borderRadius: BorderRadius.circular(7),

                  child: CustomNetworkImage(
                    imageUrl: service.photos  != null && service.photos!.isNotEmpty  ? (service.photos?.first ?? "") : "",
                    width: double.infinity,
                    height: 110,
                  ),
                ),

              ],
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, ),
              // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
