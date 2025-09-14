import 'package:flutter/material.dart';
import 'package:superapp/constants/global_variables.dart';

class CatagoryTabButtons extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CatagoryTabButtons({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: isSelected ? Colors.green: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child:   Text(
          label,
          style: textTheme(context).bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
