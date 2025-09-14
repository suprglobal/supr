import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/views/pages/food/controller/filter_food_controller.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/views/pages/food/controller/filter_food_controller.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';

class SortBottomSheet extends StatelessWidget {
  SortBottomSheet({super.key});

  // Keep using Get.put() here
  final controller = Get.put(FilterFoodController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Sort by",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          // Give a fixed height instead of Expanded
          SizedBox(
            height: 350, // adjust as needed
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.sortOptions.length,
              separatorBuilder: (_, __) => Divider(color: AppColors.appGrey),
              itemBuilder: (context, index) {
                final option = controller.sortOptions[index];
                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                  trailing: Obx(
                          () {
                        return Radio<String>(
                          value: option,
                          groupValue: controller.selectedSort.value,
                          activeColor: Theme.of(context).colorScheme.primary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                          onChanged: (value) {
                            if (value != null) controller.setSort(value);
                          },
                        );
                      }
                  ),
                  onTap: () => controller.setSort(option),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              text: 'Close',
              iconColor: Colors.white,
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}


// class FilterBottomSheet extends StatefulWidget {
//   const FilterBottomSheet({super.key});
//
//   @override
//   State<FilterBottomSheet> createState() => _FilterBottomSheetState();
// }
//
// class _FilterBottomSheetState extends State<FilterBottomSheet>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   bool offers = false;
//   bool topRated = false;
//   bool freeDelivery = false;
//
//   int selectedPriceIndex = -1;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40,
//             height: 5,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: 130),
//               Center(
//                 child: Text(
//                   "Personalize",
//                   style: textTheme(context).bodyLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: colorScheme(context).onSurface),
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     "Clear all",
//                     style: textTheme(context).bodyLarge?.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: colorScheme(context).primary),
//                   )),
//             ],
//           ),
//           TabBar(
//             controller: _tabController,
//             padding: EdgeInsets.zero,
//             isScrollable:
//                 false, // Important: tabs will fill the width without spacing
//             labelPadding:
//                 EdgeInsets.symmetric(horizontal: 0), // Remove label spacing
//             dividerColor: AppColors.appGrey,
//             indicatorSize: TabBarIndicatorSize.label,
//
//             indicatorColor: colorScheme(context).primary,
//             labelColor: colorScheme(context).onSurface,
//             unselectedLabelColor:
//                 colorScheme(context).onSurface.withOpacity(0.6),
//             tabs: const [
//               Tab(
//                 text: "Filters",
//               ),
//               Tab(text: "Sort by"),
//             ],
//           ),
//           SizedBox(
//             height: 400, // adjust as needed
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildFiltersTab(),
//                 _buildSortTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFiltersTab() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ListView(
//         children: [
//           const SizedBox(height: 10),
//           const Text("Quick Access Filters",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           CheckboxListTile(
//             title: const Text("Offers"),
//             value: offers,
//             onChanged: (val) => setState(() => offers = val!),
//           ),
//           CheckboxListTile(
//             title: const Text("Top Rated"),
//             value: topRated,
//             onChanged: (val) => setState(() => topRated = val!),
//           ),
//           CheckboxListTile(
//             title: const Text("Free Delivery"),
//             value: freeDelivery,
//             onChanged: (val) => setState(() => freeDelivery = val!),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             "Price range",
//             style: textTheme(context)
//                 .titleLarge
//                 ?.copyWith(fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(3, (index) {
//               final symbols = ["\$", "\$\$", "\$\$\$"];
//               return ChoiceChip(
//                 selectedColor: colorScheme(context).primary,
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//                 label: Text(symbols[index]),
//                 selected: selectedPriceIndex == index,
//                 onSelected: (_) => setState(() => selectedPriceIndex = index),
//               );
//             }),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             "Cuisines",
//             style: textTheme(context)
//                 .titleLarge
//                 ?.copyWith(fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 80), // Placeholder space
//           CustomElevatedButton(
//             text: 'Apply filters',
//             onPressed: () {},
//           ),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSortTab() {
//     final List<String> sortOptions = [
//       "Recommended",
//       "Top Rated",
//       "Delivery Time",
//       "Cost: low to high",
//       "Cost: high to low",
//       "Most Popular",
//     ];
//
//     String? selectedSortOption;
//
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               const Text(
//                 "Sort by",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: ListView(
//                   children: sortOptions.map((option) {
//                     return Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             setState(() => selectedSortOption = option);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     option,
//                                     style: textTheme(context)
//                                         .titleSmall
//                                         ?.copyWith(
//                                             fontWeight: FontWeight.w500,
//                                             color:
//                                                 colorScheme(context).onSurface),
//                                   ),
//                                 ),
//                                 Radio<String>(
//                                   value: option,
//                                   groupValue: selectedSortOption,
//                                   activeColor: colorScheme(context).primary,
//                                   onChanged: (value) {
//                                     setState(() => selectedSortOption = value);
//                                   },
//                                 ),
//                                 SizedBox(width: 8),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           height: 1,
//                           color: AppColors.appGrey,
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//               CustomElevatedButton(
//                 text: 'Apply filters',
//                 onPressed: () {
//                   Navigator.pop(context, selectedSortOption);
//                 },
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
