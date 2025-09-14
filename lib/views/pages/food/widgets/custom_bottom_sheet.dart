import 'package:flutter/material.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';

import '../../../../constants/global_variables.dart' show textTheme, colorScheme;

class GroupOrderBottomSheet extends StatelessWidget {
  const GroupOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Group Orders made easy',
            style: textTheme(context)
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold,
            fontSize: 18
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share your unique link through any social platform such as WhatsApp or Facebook',
            style:
                textTheme(context).bodyMedium?.copyWith(color: Colors.black54,
                fontWeight: FontWeight.w500,
                  fontSize: 14
                ),
          ),
          const SizedBox(height: 10),
          buildStep(
            isFirst: true,
            isLast: false,
            title: "Share the link with your friends",
            subtitle: "Invite friends and start ordering.",
          ),

          // Step 2
          buildStep(
            isFirst: false,
            isLast: false,
            title: "Friends add their items to the basket",
            subtitle: "Everyone can see what others are adding.",
          ),

          // Step 3
          buildStep(
            isFirst: false,
            isLast: true,
            title: "Pay a single delivery fee",
            subtitle: "Pay one delivery fee and enjoy your meal.",
          ),
          // const GroupOrderStep(
          //   title: 'Share the link with your friends',
          //   description: 'Invite friends and start ordering.',
          // ),
          // const GroupOrderStep(
          //   title: 'Friends add their items to the basket',
          //   description: 'Everyone can see what others are adding.',
          // ),
          // const GroupOrderStep(
          //   title: 'Pay a single delivery fee',
          //   description: 'Pay one delivery fee and enjoy your meal.',
          // ),
          Divider(
            color: Theme.of(context).hintColor.withValues(alpha: 0.1),
          ),
          SizedBox(height: 15),

          CustomElevatedButton(
              text: "Share your Group order",
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),

              onPressed: () {}),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CANCEL',
               style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).primary                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildStep({
    required bool isFirst,
    required bool isLast,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stepper Indicator
        Column(
          children: [
            // Top line
              Container(width: 2, height: 12, color: isFirst ? Colors.transparent :Colors.green),
            // Circle
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            // Bottom line

              Container(width: 2, height: 40, color: isLast? Colors.transparent :Colors.green),
          ],
        ),
        const SizedBox(width: 12),

        // Step Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupOrderStep extends StatelessWidget {
  final String title;
  final String description;

  const GroupOrderStep({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      visualDensity: VisualDensity.comfortable,
      leading: CircleAvatar(
          radius: 5, backgroundColor: colorScheme(context).primary),
      title: Text(title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme(context)
              .bodyMedium
              ?.copyWith(color: Colors.black.withValues(alpha: 0.4))),
    );
  }

}
