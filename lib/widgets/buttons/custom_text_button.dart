import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_text_styles.dart';
import 'package:superapp/widgets/busy_indicator.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color? titleColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final bool loading;

  //
  const CustomTextButton({
    this.onPressed,
    required this.title,
    this.titleColor,
    this.textStyle,
    this.padding,
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed != null ? () => this.onPressed!() : null,
      style: TextButton.styleFrom(
        padding: this.padding,
      ),
      child: loading
          ? Center(
              child: BusyIndicator(),
            )
          : Text(
              this.title,
              style: textStyle ?? AppTextStyle.h4TitleTextStyle(
                color: titleColor ?? AppColors.primaryColor,
              ),
            ),
    );
  }
}
