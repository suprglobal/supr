import 'package:flutter/material.dart';
import 'package:superapp/constants/app_images.dart';

class TopSheetWidget extends StatelessWidget {
  const TopSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16,55,16,20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerRight,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogoWithName,
                      height: 22,
                    ),
                  ],
                ),
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMenuItem(
                  context,
                  Icons.home_outlined,
                  'Home',
                  () {
                    // context.pushNamed(AppRoute.homePage);
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.headset_mic_outlined,
                  'Help',
                  () {
                    // context.pushNamed(AppRoute.helpCenterPage);
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.credit_card_outlined,
                  'Supr Pay',
                  () {
                    // context.pushNamed(AppRoute.suprPayPage);
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.person_outline,
                  'Profile',
                  () {
                    // context.pushNamed(AppRoute.profilePage);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
