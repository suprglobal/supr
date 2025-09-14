import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/product.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/widgets/buttons/custom_steppr.view.dart';
import 'package:superapp/widgets/cards/custom.visibility.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:superapp/widgets/inputs/drop_down.input.dart';
import 'package:superapp/widgets/states/product_stock.dart';
import 'package:superapp/widgets/tags/discount.positioned.dart';
import 'package:superapp/widgets/tags/fav.positioned.dart';
import 'package:superapp/widgets/tags/product_tags.dart';
import 'package:velocity_x/velocity_x.dart';

class GroceryProductListItem extends StatefulWidget {
  const GroceryProductListItem({
    required this.product,
    required this.onPressed,
    required this.qtyUpdated,
    this.showStepper = false,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final Function(Product) onPressed;
  final Function(Product, int) qtyUpdated;
  final Product product;
  final bool showStepper;
  final double? height;
  final double? width;

  @override
  State<GroceryProductListItem> createState() => _GroceryProductListItemState();
}

class _GroceryProductListItemState extends State<GroceryProductListItem> {
  @override
  Widget build(BuildContext context) {
    return VStack([
          //
          //product image
          Stack(
            children: [
              //
              Hero(
                tag: widget.product.heroTag ?? widget.product.id,
                child: CustomImage(
                  imageUrl: widget.product.photo,
                  boxFit: BoxFit.contain,
                  width: double.infinity,
                  height: Vx.dp64 * 1.25,
                ),
              ),
              //
              //discount tag
              DiscountPositiedView(widget.product),

              //fav icon
              FavPositiedView(widget.product),
            ],
          ),

          //
          VStack([
            "${widget.product.name}".text.light
                .size(14)
                .minFontSize(12)
                .maxFontSize(14)
                .maxLines(widget.product.showDiscount ? 1 : 2)
                .overflow(TextOverflow.ellipsis)
                .make()
                .expand(),

            //discounted price
            CustomVisibilty(
              visible: widget.product.showDiscount,
              child:
                  "${AppStrings.currencySymbol} ${widget.product.price}"
                      .currencyFormat()
                      .text
                      .lineThrough
                      .xs
                      .semiBold
                      .make(),
            ),
            //options
            CustomVisibilty(
              visible:
                  widget.showStepper && widget.product.optionGroups.isNotEmpty,
              child: DropdownInput(
                options:
                    widget.product.optionGroups.isNotEmpty
                        ? widget.product.optionGroups[0].options
                        : [],
                onChanged: (option) {
                  widget.product.selectedOptions = [option];
                },
              ).pOnly(top: Vx.dp4),
            ),
          ]).p8().expand(),

          VStack([
            //
            CustomVisibilty(
              visible: widget.product.hasStock,
              child:
                  HStack([
                    //price
                    "${AppStrings.currencySymbol} ${widget.product.sellPrice}"
                        .currencyFormat()
                        .text
                        .base
                        .bold
                        .make()
                        .expand(),
                    UiSpacer.smHorizontalSpace(),
                    //counter input
                    CustomVisibilty(
                      visible: widget.product.selectedQty >= 1,
                      child: CustomStepper(
                        defaultValue: widget.product.selectedQty,
                        max: widget.product.availableQty ?? 20,
                        onChange: (qty) {
                          //
                          updateProductQty(value: qty);
                        },
                      ),
                    ),
                    //add to cart icon
                    //hide when selected qty is more than 0
                    CustomVisibilty(
                      visible: widget.product.selectedQty < 1,
                      child: Icon(FlutterIcons.plus_ant, size: 20).box.p4
                          .color(context.theme.colorScheme.surface)
                          .outerShadowSm
                          .roundedFull
                          .make()
                          .onInkTap(() {
                            //
                            updateProductQty();
                          }),
                    ),
                  ]).p8(),
            ),

            //no stock indicator
            CustomVisibilty(
              visible: !widget.product.hasStock,
              child: ProductStockState(widget.product),
            ),
          ]).box.color(AppColors.faintBgColor).make().p2(),

          //
          ProductTags(widget.product),
        ])
        .h(
          widget.height != null
              ? widget.height!
              : widget.product.optionGroups.isNotEmpty
              ? 220
              : 180,
        )
        .onInkTap(() => this.widget.onPressed(this.widget.product))
        .material(color: context.theme.colorScheme.surface)
        .box
        .roundedSM
        .color(context.theme.colorScheme.surface)
        .clip(Clip.antiAlias)
        .outerShadowSm
        .makeCentered()
        .w(widget.width ?? context.percentWidth * 100);
    // .w( context.percentWidth * 40);
  }

  //
  void updateProductQty({int value = 1}) {
    bool required = widget.product.optionGroupRequirementCheck();
    if (!required) {
      //add to cart/update cart
      widget.qtyUpdated(widget.product, value);
      //
      setState(() {
        widget.product.selectedQty = value;
      });
    } else {
      //open the product details page
      widget.onPressed(widget.product);
    }
  }
}
