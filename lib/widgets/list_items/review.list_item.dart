import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/sizes.dart';
import 'package:superapp/models/review.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem(this.review, {Key? key}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        CustomImage(
          imageUrl: review.user.photo,
          width: 45,
          height: 45,
        ),
        //
        VStack(
          [
            review.user.name.text.semiBold.size(Sizes.fontSizeLarge).make(),
            VxRating(
              normalImage: EvaIcons.starOutline,
              selectImage: EvaIcons.star,
              value: review.rating.toDouble(),
              stepInt: true,
              selectionColor: AppColors.ratingColor,
              normalColor: AppColors.ratingColor,
              onRatingUpdate: (rating) {},
              isSelectable: false,
              size: 16,
            ),
            1.heightBox,
            "${review.review}".text.size(Sizes.fontSizeLarge).make(),
          ],
          spacing: 5,
        ).expand(),
      ],
      spacing: 10,
      crossAlignment: CrossAxisAlignment.start,
      alignment: MainAxisAlignment.start,
    );
  }
}
