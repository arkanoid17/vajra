import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/widgets/custom_text_field.dart';

class StoreFilters extends StatefulWidget {
  final String selectedDate;

  static route(String selectedDate) => MaterialPageRoute(
      builder: (context) => StoreFilters(selectedDate: selectedDate));

  const StoreFilters({super.key, required this.selectedDate});

  @override
  State<StoreFilters> createState() => _StoreFiltersState();
}

class _StoreFiltersState extends State<StoreFilters> {
  final dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.filter),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppStrings.reset,
              style: AppTheme.textTheme(
                  AppPalette.whiteColor, 16.0, FontWeight.w400),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: AppStrings.date,
                      textController: dateController,
                      isreadOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                      onTap: _showCalendar,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {},
              child: Text(
                AppStrings.apply.toUpperCase(),
                style: AppTheme.buttonText,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showCalendar() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('yyyy-MM-dd').parse(dateController.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }
}
