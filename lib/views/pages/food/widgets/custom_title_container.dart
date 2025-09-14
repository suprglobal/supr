import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/global_variables.dart';

class CustomTitleContainer extends StatelessWidget {
  final String title;
  final String location;
  final String distance;
  final String rating;
  final String norating;
  const CustomTitleContainer(
      {super.key,
      required this.title,
      required this.location,
      required this.distance,
      required this.rating,
      required this.norating});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            SizedBox(height: 5),
            Text(
              location,
              style: textTheme(context).bodyMedium?.copyWith(
                  color: Colors.black.withValues(alpha: 0.5),
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 3),
            Text(
              "Business Bay (${distance})",
              style: textTheme(context).bodySmall?.copyWith(
                  color: Colors.black.withValues(alpha: 0.5),
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: height * 0.09,
          width: width * 0.18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Theme.of(context).cardColor,
            border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: 0.05)),

          ),
          child: Column(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Theme.of(context).hintColor.withValues(alpha: 0.1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 3,
                  children: [
                    Icon(Icons.star,
                        size: 18, color: colorScheme(context).primary),
                    Text(
                      rating,
                      style: textTheme(context).labelMedium?.copyWith(
                          color: colorScheme(context).primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(norating,
                      style: textTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.darkGrey)),
                  Text("ratings",
                      style: textTheme(context).labelMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ))
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
