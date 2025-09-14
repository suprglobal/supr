import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/global_variables.dart';

class CustomRow extends StatelessWidget {
  final String discount;
  final VoidCallback onTap;
  const CustomRow({super.key, required this.discount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3))),
          child: SvgPicture.asset(AppIcon.offer, height: 20, width: 20),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Offer",
                        style: textTheme(context).labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: AppColors.carmineRed),
                      ),
                      Text(
                        "50% off up  to AED 30",
                        style: textTheme(context).labelMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const Icon(Icons.info_outline, size: 25)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
