import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';
import 'package:superapp/views/pages/dine_out/pages/offer_page.dart';
import 'package:superapp/views/pages/home/widgets/top_sheet.dart';
import 'package:superapp/views/pages/supr_pay/pages/supr_pay.dart';
// import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_icon_button.dart' show CustomIconButton;
// import 'package:suprapp/app/core/constants/app_colors.dart';
// import 'package:suprapp/app/core/constants/global_variables.dart';
// import 'package:suprapp/app/features/auth/pages/biometric_setup_page.dart';
// import 'package:suprapp/app/features/home/widgets/custom_icon_button.dart';
// import 'package:suprapp/app/features/home/widgets/home_app_bar_section.dart';
// import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
// import 'package:suprapp/app/routes/go_router.dart';
// import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
// import '../../../core/constants/app_images.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
        gradient: LinearGradient(
          colors: [
            // Colors.white,
            // colorScheme(context).secondary.withOpacity(0.7),
            Color(0xFFFFF3D9),
            Color(0xFFD0F4C4),
          ],
          stops: const [0.2, 1.4],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  AppImages.appLogoWithName,
                  height: 19,
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CustomElevatedButton(
                    borderRadius: 30,
                    buttonColor: AppColors.accentColor,
                    padding: const EdgeInsets.all(0),
                    width: 70,
                    height: 30,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuprPayPage()));

                    },
                    text: 'Pay',
                    textStyle: textTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).onSurface,
                        ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius:
                        BorderRadius.circular(30), // Match button radius
                  ),
                  child: CustomIconButton(
                    height: 30,
                    width: 30,
                    iconSize: 18,
                    borderRadius: 30,
                    icon: Icons.menu,
                    iconColor: colorScheme(context).onSurface,
                    buttonColor: AppColors.accentColor,
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'TopSheet',
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                        transitionBuilder: (_, animation, __, ___) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, -1),
                              end: Offset.zero,
                            ).animate(animation),
                            child: const Align(
                              alignment: Alignment.topCenter,
                              child: TopSheetWidget(),
                            ),
                          );
                        },
                      );
                    },
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'The Everything App',
              style: textTheme(context).displayLarge?.copyWith(
                  color: Color(0xFF008C15),
                  fontWeight: FontWeight.bold,
                  fontSize: 28.5),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: TextField(
                controller: searchController,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: const Color(0xff000000)),
                decoration: InputDecoration(
                  hintText: 'Search what you need',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 13, color: const Color(0xff000000)),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              // spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SuprPayPage()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Supr Pay balance',
                          style: textTheme(context).bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).onSurface,
                              )),
                      Text('245 INR',
                          style: textTheme(context).bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme(context).onSurface,
                              )),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: colorScheme(context).onSurface,
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OfferScreen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Offers for you',
                          style: textTheme(context).bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).onSurface,
                              )),
                      Text('233',
                          style: textTheme(context).bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme(context).onSurface,
                              )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcon.locationIcon),
                const SizedBox(
                  width: 5,
                ),
                Text('Deliver to aDelhi Ncr,1100',
                    style: textTheme(context).bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme(context).onSurface,
                        )),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
