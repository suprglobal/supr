import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/constants/static_data.dart';
import 'package:superapp/shared/widgets/custom_elevated_button.dart';
import 'package:superapp/views/pages/auth/provider/auth_provider.dart';
import 'package:superapp/views/pages/profiles/controller/date_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DateOfBirthBottomSheet extends StatelessWidget {
  const DateOfBirthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final selectedDate = dateProvider.selectedDate ?? DateTime(2000);
    final formattedDate = DateFormat('MMMM d, y').format(selectedDate);
    final authprovider = Provider.of<AuthProviders>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select your date of birth',
            style: textTheme(context)
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              formattedDate,
              style: textTheme(context)
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.appGrey, thickness: 0.6),
          CalendarDatePicker(
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            onDateChanged: (pickedDate) {
              dateProvider.setDate(pickedDate);
            },
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(
              text: "Update",
              onPressed: () async {
                final gender = StaticData.model?.gender ?? '';
                final gmail = StaticData.model?.email ?? '';
                final phone = StaticData.model!.phone ?? '';
                final name = StaticData.model!.name;
                await authprovider.updateDobAndGender(
                    name: name,
                    context: context,
                    dob: formattedDate,
                    gender: gender,
                    email: gmail,
                    phoneNo: phone);
                Navigator.pop(context);

              })
        ],
      ),
    );
  }
}
