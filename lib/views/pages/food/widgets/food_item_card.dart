import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';
import 'package:superapp/views/pages/food/controller/product_detail_controller.dart';
import 'package:superapp/views/pages/food/widgets/special_req-field.dart';
import 'package:superapp/widgets/custom_network_image.dart';

import '../model/restaurant_detail_model.dart';

class FoodItemCardWidget extends StatefulWidget {
  final Product? product;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final int discount;

  const FoodItemCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.discount,
    this.product,
  });

  @override
  State<FoodItemCardWidget> createState() => _FoodItemCardWidgetState();
}

class _FoodItemCardWidgetState extends State<FoodItemCardWidget> {


  void showProductDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {

        return FoodProductDetailSheetWidget(
          id: (widget.product?.id ?? "").toString(),
        );

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: Dimensions.homePagePadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: textTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: textTheme(context).bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "₹${widget.price.toStringAsFixed(2)}",
                      style: textTheme(
                        context,
                      ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "₹${widget.oldPrice.toStringAsFixed(0)}",
                      style: textTheme(context).labelMedium?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.carmineRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Save ${widget.discount}%",
                        style: textTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImage(
                  imageUrl: widget.product?.imageUrl ?? "",
                  height: 90,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.product == null || widget.product?.id == null)
                    return;

                  showProductDetailBottomSheet(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 72, left: 16, right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                  ),
                  child: Text(
                    "Add",
                    style: textTheme(context).titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FoodProductDetailSheetWidget extends StatefulWidget {
  final String id;
   FoodProductDetailSheetWidget({
    super.key,
     required this.id,
  });

  @override
  State<FoodProductDetailSheetWidget> createState() => _FoodProductDetailSheetWidgetState();
}

class _FoodProductDetailSheetWidgetState extends State<FoodProductDetailSheetWidget> {
  final productDetailController = Get.put(ProductDetailController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productDetailController.fetchProductDetail(
      "${widget.id}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Obx(() {
          final product =
              productDetailController.productDetailRecord.value;

          if (productDetailController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (product == null && product == false) {
            return const Center(child: Text("No detail found"));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: CustomNetworkImage(
                              // widget.imageUrl,
                              defaultImage:
                              "assets/image/promotion.png",
                              imageUrl: product?.imageUrl ?? "",
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: colorScheme(context).surface,
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).hintColor.withValues(alpha: 0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade500,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?.name ?? "",
                              style: textTheme(context).titleLarge
                                  ?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product?.description ?? "",
                              style: textTheme(context).bodyLarge
                                  ?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "₹${product?.price}",
                              style: textTheme(context).bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(
                                  context,
                                ).onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.09),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if((product?.modifierGroups?.length ?? 0) != 0)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Select your own choices:",
                                  style: textTheme(context).titleMedium
                                      ?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15),
                              itemCount:



                              product?.modifierGroups?.length ?? 0,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final modifierGroup = product?.modifierGroups?[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  modifierGroup?.name ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textTheme(context)
                                                      .titleSmall
                                                      ?.copyWith(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "Select any 1 option",
                                                  // modifierGroup?.requiredCount ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(modifierGroup?.selectionType  ?? "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13
                                                )),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 15),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemCount: modifierGroup?.modifiers?.length ?? 0,
                                        separatorBuilder: (_, __) =>
                                            Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                              ),
                                              child: Divider(
                                                color: Colors
                                                    .grey
                                                    .shade300,
                                              ),
                                            ),
                                        itemBuilder: (context, index) {
                                          final modifier = modifierGroup?.modifiers?[index];
                                          return GestureDetector(
                                            onTap: () {
                                              productDetailController.selectCombo(
                                                index,
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    modifier?.name ??"",
                                                    style: textTheme(context)
                                                        .bodyLarge
                                                        ?.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      color: Colors
                                                          .black87,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                // Radio Button
                                                Radio<int>(
                                                  visualDensity:
                                                  VisualDensity(
                                                    vertical: -4,
                                                  ),
                                                  materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                                  value: index,
                                                  groupValue: productDetailController
                                                      .selectedIndex.value,
                                                  onChanged: (val) =>
                                                      productDetailController
                                                          .selectCombo(
                                                        index,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },

                            ),
                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.edit_note_outlined,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 6),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                "Special requests",
                                                style:
                                                textTheme(context)
                                                    .bodyLarge
                                                    ?.copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 15,
                                                  color: Colors
                                                      .black,
                                                ),
                                              ),
                                              Text(
                                                "Got any requests for the restaurant?",
                                                style:
                                                textTheme(context)
                                                    .bodyMedium
                                                    ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color: Colors
                                                      .black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SpecialRequestField(),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom sticky bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    // Quantity button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.darkGrey,
                              size: 15,
                            ),
                            onPressed: productDetailController.decreaseQty,
                          ),
                          Text(
                            productDetailController.quantity.toString(),
                            style: textTheme(context).bodyLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).onSurface,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 15,
                              color: AppColors.darkGrey,
                            ),
                            onPressed: productDetailController.increaseQty,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Add Button
                    Expanded(
                      child: CustomElevatedButton(
                        text: 'Add • ₹59',
                        onPressed: () {
                          if (productDetailController.quantity == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please select a quantity before adding.',
                                ),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Item added to cart successfully.',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      });
  }
}
