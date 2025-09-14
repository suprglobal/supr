import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.appGrey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

List<String> mylist = [
  "Push Notifications",
  "Notifications Sound",
  "Wallet Updates",
  "Promotion"
];
List<String> imageList = [
  AppImages.lorem1,
  AppImages.lorem2,
  AppImages.lorem3,
];
