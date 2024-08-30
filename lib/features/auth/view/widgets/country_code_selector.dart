import 'package:flutter/material.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/model/country_codes.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/widgets/custom_text_field.dart';

class CountryCodeSelector extends StatefulWidget {
  final Function onSelected;

  const CountryCodeSelector({super.key, required this.onSelected});

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  List<CountryCode> countries = [];
  List<CountryCode> filterList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    fetchCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            AppStrings.selectCountryCode,
            style: AppTheme.titleText,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            onChanged: filterCountries,
            labelText: AppStrings.search,
            textController: searchController,
            suffixIcon: IconButton(
                onPressed: () {
                  searchController.text = '';
                  filterCountries('');
                },
                icon: const Icon(Icons.clear)),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: filterList.length,
                itemBuilder: (cx, position) {
                  return ListTile(
                    onTap: () =>
                        widget.onSelected(filterList[position].dialCode),
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${filterList[position].name} (${filterList[position].code})',
                    ),
                    trailing: Text(
                      filterList[position].dialCode,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterCountries(String query) async {
    List<CountryCode> list = [];
    if (query.isNotEmpty) {
      list.addAll(countries
          .where((item) =>
              item.name.toLowerCase().contains(query.trim().toLowerCase()))
          .toList());
    } else {
      list = countries;
    }
    setState(() {
      filterList = list;
    });
  }

  void fetchCountries() {
    loadCountries().then((data) => setState(() {
          filterList = data;
          countries = data;
        }));
  }
}
