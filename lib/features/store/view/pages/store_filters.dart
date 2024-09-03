import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/widgets/custom_text_field.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/store/view/widgets/beats_popup.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_local_repository.dart';

class StoreFilters extends StatefulWidget {
  final int salesmanId;
  final String selectedDate;
  final List<UserHierarchyBeats> selectedBeats;

  static route(
    String selectedDate,
    List<UserHierarchyBeats> selectedBeats,
    int salesmanId,
  ) =>
      MaterialPageRoute(
          builder: (context) => StoreFilters(
                selectedDate: selectedDate,
                selectedBeats: selectedBeats,
                salesmanId: salesmanId,
              ));

  const StoreFilters(
      {super.key,
      required this.selectedDate,
      required this.selectedBeats,
      required this.salesmanId});

  @override
  State<StoreFilters> createState() => _StoreFiltersState();
}

class _StoreFiltersState extends State<StoreFilters> {
  final dateController = TextEditingController();
  final beatsController = TextEditingController();
  late List<UserHierarchyBeats> selectedBeats;
  late List<UserHierarchyBeats> beats;
  late String selectedDate;
  late int salesmanId;

  final userHierarchyLocalRepo = UserHierarchyLocalRepository();

  @override
  void initState() {
    salesmanId = widget.salesmanId;
    selectedDate = widget.selectedDate;
    _updatedBeatsList();
    _setDate(widget.selectedDate);
    _setBeats(widget.selectedBeats);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.filter),
        actions: [
          TextButton(
            onPressed: () {
              salesmanId = getSalesmanId();
              _setDate(DateFormat('yyyy-MM-dd').format(DateTime.now()));
              _setBeats(userHierarchyLocalRepo.filterBeatsByDateAndUser(
                  selectedDate, salesmanId));
            },
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
                      suffixIcon: IconButton(
                          onPressed: () => _setDate(''),
                          icon: const Icon(Icons.clear)),
                      onTap: _showCalendar,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      labelText: AppStrings.beats,
                      textController: beatsController,
                      isreadOnly: true,
                      onTap: _showBeatsPopup,
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
      initialDate: dateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(dateController.text)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _setDate(DateFormat('yyyy-MM-dd').format(pickedDate));
    }
  }

  void _setBeats(List<UserHierarchyBeats> beats) {
    selectedBeats = beats;
    beatsController.text = beats.map((e) => e.name!).toList().join(',');
  }

  void _setDate(String date) {
    selectedDate = date;
    dateController.text = date;
    _updatedBeatsList();
  }

  void _showBeatsPopup() {
    showBottomDialog(
      context,
      BeatsPopup(
        salesmanId: salesmanId,
        selectedBeats: selectedBeats,
        selectedDate: selectedDate,
        allBeats: beats,
      ),
    );
  }

  void _updatedBeatsList() {
    if (selectedDate.isNotEmpty) {
      beats = userHierarchyLocalRepo.filterBeatsByDateAndUser(
        selectedDate,
        salesmanId,
      );
    } else {
      beats = userHierarchyLocalRepo.getUserBeats(salesmanId);
    }
    _setBeats(beats);
  }
}
