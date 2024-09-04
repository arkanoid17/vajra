import 'package:flutter/material.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy.dart';

class HierarchyUserPopup extends StatelessWidget {
  final List<UserHierarchy> users;
  final Function onUserSelected;

  const HierarchyUserPopup(
      {super.key, required this.users, required this.onUserSelected});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 1.0, // Adjust the initial size of the sheet
        expand: false,
        builder: (ctx, scrollController) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(
                  AppDimens.screenPadding,
                ),
                child: Text(
                  AppStrings.selectUser,
                  style: AppTheme.titleText,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (cx, index) {
                    return ListTile(
                      onTap: () {
                        onUserSelected(users[index].id!);
                        Navigator.pop(context);
                      },
                      title: Text(users[index].name!),
                      subtitle: Row(
                        children: [
                          Text('${users[index].employId!}  |  '),
                          const Icon(Icons.location_on),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            users[index]
                                .locations!
                                .map((e) => e.name!)
                                .toList()
                                .join(','),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: users.length,
                ),
              )
            ],
          );
        });
  }
}
