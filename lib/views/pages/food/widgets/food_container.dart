import 'package:flutter/material.dart';
import 'package:superapp/constants/global_variables.dart';

class FoodContainer extends StatelessWidget {
  final String time;
  final String price;
  final String fee;
  const FoodContainer(
      {super.key, required this.time, required this.fee, required this.price});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 236, 232, 232)),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Text(
                "Delivery time",
                style: textTheme(context).labelLarge?.copyWith(
                      color: Colors.black.withValues(alpha: 0.3),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                    ),
              ),
              Text(time,
                  style: textTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: colorScheme(context).primary))
            ],
          ),
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.3),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Price For one",
                style: textTheme(context).labelLarge?.copyWith(
                  color: Colors.black.withValues(alpha: 0.3),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(price,
                  style: textTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14))
            ],
          ),
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.3),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Delivery Fee",
                style: textTheme(context).labelLarge?.copyWith(
                  color: Colors.black.withValues(alpha: 0.3),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(fee,
                  style: textTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
