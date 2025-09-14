import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/models/category.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    required this.category,
    required this.onPressed,
    this.maxLine = true,
    this.h,
    this.inverted = false,
    this.textColor,
    this.lines = 1,
    Key? key,
  }) : super(key: key);

  final Function(Category) onPressed;
  final Category category;
  final bool maxLine;
  final double? h;
  final bool inverted;
  final Color? textColor;
  final int lines;
  @override
  Widget build(BuildContext context) {
    Widget child = 5.heightBox;
    if (inverted) {
      // Color bgColor = Vx.hexToColor(category.color ?? "#ffffff");
      Color bgColor =AppColors.serviceCardColor;
      Color mTextColor = Utils.textColorByColor(bgColor);
      child =
          _buildCategoryViewBase(maxLine, inverted, textColor ?? mTextColor);
      child = child.p(8).box.roundedSM.color(bgColor).outerShadowSm.make();
    } else {
      Color mTextColor = Utils.textColorByColor(Colors.transparent);
      child =
          _buildCategoryViewBase(maxLine, inverted, textColor ?? mTextColor);
    }

    //
    if (maxLine) {
      child = child
          .w((AppStrings.categoryImageWidth * 1.8) +
              AppStrings.categoryTextSize)
          .h(h ??
              ((AppStrings.categoryImageHeight * 1.8) +
                  AppStrings.categoryImageHeight))
          .onInkTap(
            () => this.onPressed(this.category),
          )
          .px4();
    } else {
      child = child
          .onInkTap(
            () => this.onPressed(this.category),
          )
          .px4();
    }
    return child;
  }

  //
  Widget _buildCategoryViewBase(bool maxLine, bool inverted, Color textColor) {
    Widget nameView = category.name.text
        .size(AppStrings.categoryTextSize).bold
        .wrapWords(true)
        .center
        .color(textColor)
        .make()
        .py(1);
    if (maxLine) {
      nameView = category.name.text
          .minFontSize(AppStrings.categoryTextSize)
          .size(AppStrings.categoryTextSize).bold
          .center
          .color(textColor)
          .maxLines(lines)
          .ellipsis
          .make()
          .py(1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImage(
          imageUrl: category.imageUrl ?? "",
          boxFit: BoxFit.fill,
          width: double.infinity,
          height: 65,
        ),
        Text(category.name,
        textAlign: TextAlign.center,
        maxLines: maxLine ? lines : 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: AppStrings.categoryTextSize,
          color: textColor,
          fontWeight: FontWeight.bold,

        ),
        )
      ],
    );
    return VStack(
      [
        //
        CustomImage(
          imageUrl: category.imageUrl ?? "",
          boxFit: BoxFit.fill,
          width: AppStrings.categoryImageWidth * (inverted ? 0.75 : 1),
          height: AppStrings.categoryImageHeight * (inverted ? 0.75 : 1),
        )
            .box
            .roundedSM
            .clip(Clip.antiAlias)
            .color(inverted
                ? Colors.transparent
                : Vx.hexToColor(category.color ?? "#ffffff"))
            .make()
            .py2(),

        //
        nameView,
      ],
      crossAlignment: CrossAxisAlignment.center,
      alignment: MainAxisAlignment.start,
    );
  }
}
