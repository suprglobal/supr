import 'package:flutter/material.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/views/pages/food/pages/offers_tabs_page.dart';

class FoodFilterButton extends StatelessWidget {
  final String label;

  const FoodFilterButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:  (context) => OffersTabsPage()));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(width: 5),
            Text(
              label,
              style: textTheme(context).titleSmall  ?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
          ])),
    );
  }
}
