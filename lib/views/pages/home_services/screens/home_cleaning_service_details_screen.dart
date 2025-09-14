import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/home/widgets/top_sheet.dart';
import 'package:superapp/widgets/custom_network_image.dart';

class HomeCleaningServiceDetailsScreen extends StatefulWidget {
  const HomeCleaningServiceDetailsScreen({super.key});

  @override
  State<HomeCleaningServiceDetailsScreen> createState() =>
      _HomeServicesScreenState();
}

class _HomeServicesScreenState extends State<HomeCleaningServiceDetailsScreen> {
  final List<String> images = [
    AppImages.homeCleaning,
    AppImages.acCleaning,
    AppImages.furnitureCleaning,
    AppImages.kitchenCleaning,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: Dimensions.homePagePadding,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appGrey),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.darkGrey,
                size: 20,
              ),
            ),
          ),
        ),
        titleSpacing: 10,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 3),
            Text(
              "HomeCleaning",
              style: textTheme(context).bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Dimensions.homePagePadding,
              top: 8,
              bottom: 8,
            ),
            child: InkWell(
              onTap: () {
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
              child: Container(
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                  color: colorScheme(context).primary,
                  border: Border.all(color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.menu,
                  color: Color.fromARGB(255, 20, 188, 96),
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.homePagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      spacing: 3,
                      children: [
                        Text(
                          "Noida",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, size: 24)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Service Details",
                      style: TextStyle(
                          fontSize: 21,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme
                          .of(context)
                          .colorScheme
                          .secondary),
                      minHeight: 4,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      "Next step: Popular add-ons",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                      ),
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            "Exclusive offer for you!",
                            style: TextStyle(
                                fontSize: 14.5,
                                height: 1.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "How many hours do you need your professional to stay?",
                            style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                              return Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor
                                  )
                                ),
                              );

                            }, separatorBuilder: (context, index) =>
                                SizedBox(width: 8), itemCount: 9),
                          ),

                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade100, // border color
                      width: 2.0, // border thickness
                    ),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.homePagePadding, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 3,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 17,
                                height: 1.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹78.00",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_up, size: 26)
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      child: Text("Next", style: TextStyle(
                          fontSize: 16,
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
