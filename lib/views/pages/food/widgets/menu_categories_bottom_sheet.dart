import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/food/controller/restaurant_detail_controller.dart';

class MenuCategoriesBottomSheet extends StatelessWidget {
   MenuCategoriesBottomSheet({super.key});


  final restaurantsDetailController = Get.put(RestaurantsDetailController());

  @override
  Widget build(BuildContext context) {


    if(restaurantsDetailController.isLoading.value || restaurantsDetailController.restaurantDetailRecord == null ||restaurantsDetailController.restaurantDetailRecord!.value?.categories == null){
      return SizedBox.shrink();
    }
    final categories = restaurantsDetailController.restaurantDetailRecord.value?.categories;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      padding:  EdgeInsets.fromLTRB(Dimensions.homePagePadding, 8, Dimensions.homePagePadding, 0),
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
          SizedBox(height: 15),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300)),
                  child:  Icon(
                    Icons.close,
                    color:Colors.grey.shade500,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text("Menu Categories",
                  style: textTheme(context).titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(height: 10),

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: categories?.length ?? 0,
              padding: EdgeInsets.symmetric(vertical: 10),
              separatorBuilder: (context, index) =>  Divider(
                color: Theme.of(context).hintColor.withValues(alpha: 0.05),
              ),
              itemBuilder: (context, index) {
                final category = categories?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category?.name ?? "",
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color:Colors.black.withValues(alpha: 0.6)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withValues(alpha: 0.15),
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                          alignment: Alignment.center,
                          child: Text(
                           ( category?.productCount ?? 0).toString(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        )

                      ],
                    ),
                  ),
                );
              },
            ),
          ),

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
