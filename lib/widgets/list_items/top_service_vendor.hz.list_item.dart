import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/models/vendor.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';


class TopServiceVendorHorizontalListItem extends StatelessWidget {
  const TopServiceVendorHorizontalListItem({
    required this.vendor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Vendor vendor;
  final Function(Vendor) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(vendor),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow:  [
            AppConstants.boxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Row with logo + info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomImage(
                    imageUrl: vendor.logo,
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(width: 6),

                // Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vendor name
                      Text(
                        vendor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Rating + reviews
                      Row(
                        children: [
                          // You need to replace VxRating with your own rating widget
                          VxRating(
                      maxRating: 5.0,
                            value: double.parse(vendor.rating.toString()),
                            isSelectable: false,
                            onRatingUpdate: (value) {},
                            selectionColor: AppColors.ratingColor,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${vendor.reviews_count} ${"Reviews".tr()}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              vendor.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //
            // const SizedBox(height: 8),
            //
            // // Description (1 line)
            // Text(
            //   vendor.description,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: const TextStyle(fontSize: 13),
            // ),
          ],
        ),
      ),
    );
  }
}

