import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';

class OfferBottomSheet extends StatelessWidget {
  const OfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:  EdgeInsets.fromLTRB(Dimensions.homePagePadding, 8, Dimensions.homePagePadding, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 55,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: Colors.black
                  )
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppIcon.offer,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 8),
              Text("Offer",
                  style: textTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.carmineRed)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300)),
                  child:  Icon(
                    Icons.close,
                    color:Colors.grey.shade500,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text("Offer",
              style: textTheme(context)
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Crazy Deals: 50% off",
              style: textTheme(context).labelMedium?.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Apply code during checkout",
                    style: textTheme(context)
                        .labelLarge
                        ?.copyWith(
                          fontSize: 12,
                        fontWeight: FontWeight.bold)),
                Text("EPIK50",
                    style: textTheme(context)
                        .labelLarge
                        ?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _offerDetailTile("Min spend", "AED 0", context),
                Container(width: 1, height: 37, color: Colors.grey.shade200),
                _offerDetailTile("Max Discount", "Unlimited", context),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            spacing: 4,
            children: [
              Icon(Icons.brightness_1_rounded,size:5,
              color: AppColors.darkGrey),
              Text("Valid until orders above ",
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: AppColors.darkGrey,
                  fontWeight: FontWeight.bold,
                    fontSize: 12
                  )),
            ],
          ),
          Row(
            spacing: 4,
            children: [
              Icon(Icons.brightness_1_rounded,size:5,
              color: AppColors.darkGrey),
              Text("Valid until 2025-05-18",
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: AppColors.darkGrey,
                  fontWeight: FontWeight.bold,
                    fontSize: 12
                  )),
            ],
          ),
          Row(
            spacing: 4,
            children: [
              Icon(Icons.brightness_1_rounded,size:5,
              color: AppColors.darkGrey),
              Text("Maximum discount is AED 30",
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: AppColors.darkGrey,
                  fontWeight: FontWeight.bold,
                    fontSize: 12
                  )),
            ],
          ),
          SizedBox(height: 15),

          CustomElevatedButton(
              text: "Got it",
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  Widget _offerDetailTile(String title, String value, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Text(
              title,
              style: textTheme(context).bodySmall?.copyWith(
                  color: AppColors.darkGrey, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(value,
                style: textTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface))
          ],
        ),
      ),
    );
  }
}
