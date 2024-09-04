import 'package:flutter/material.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/widgets/custom_text_field.dart';
import 'package:vajra_test/features/store/view/widgets/hierarchy_user_popup.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_local_repository.dart';

class HierarchyUserSelector extends StatefulWidget {
  final int selectedUser;
  final Function onSalesmanChanged;

  const HierarchyUserSelector(
      {super.key, required this.selectedUser, required this.onSalesmanChanged});

  @override
  State<HierarchyUserSelector> createState() => _HierarchyUserSelectorState();
}

class _HierarchyUserSelectorState extends State<HierarchyUserSelector> {
  late List<UserHierarchy> users;

  final hierarchyLocalRepo = UserHierarchyLocalRepository();

  List<UserHierarchy> hierarchyList = [];

  late int selectedUser;

  @override
  void initState() {
    selectedUser = widget.selectedUser;

    users = hierarchyLocalRepo
        .getAllUsers()
        .where((e) => e.isActive ?? false)
        .toList();

    _createHierarchy();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgets(),
    );
  }

  void _createHierarchy() {
    hierarchyList.add(getHierarchyParent());
  }

  UserHierarchy getHierarchyParent() {
    late UserHierarchy parent;
    for (UserHierarchy user in users) {
      if (user.id == getSalesmanId()) {
        parent = user.copyWith(hierarchy: _fetchUserHierarchy(user));
        break;
      }
    }
    return parent;
  }

  List<UserHierarchy>? _fetchUserHierarchy(UserHierarchy parentUser) {
    List<UserHierarchy> hierarchy = [];
    for (UserHierarchy user in users) {
      if (user.manager != null && user.manager == parentUser.id) {
        user = user.copyWith(hierarchy: _fetchUserHierarchy(user));
        hierarchy.add(user);
      }
    }

    return hierarchy;
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = [];

    widgets.add(getDynamicField(hierarchyList[0], hierarchyList));

    if (hierarchyList[0].hierarchy != null &&
        hierarchyList[0].hierarchy!.isNotEmpty) {
      widgets.addAll(_getHierarchywidget(hierarchyList[0].hierarchy!));
    }

    widget.onSalesmanChanged(selectedUser);

    return widgets;
  }

  List<Widget> _getHierarchywidget(List<UserHierarchy> hierarchyUsers) {
    List<Widget> wids = [];
    int selected = -1;
    for (int i = 0; i < hierarchyUsers.length; i++) {
      if (_checkUserSelected(hierarchyUsers[i])) {
        selected = i;
      }
    }
    if (selected == -1) {
      wids.add(getDynamicField(null, hierarchyUsers));
    } else {
      wids.add(getDynamicField(hierarchyUsers[selected], hierarchyUsers));
      if (hierarchyUsers[selected].hierarchy != null &&
          hierarchyUsers[selected].hierarchy!.isNotEmpty) {
        wids.addAll(_getHierarchywidget(hierarchyUsers));
      }
    }
    return wids;
  }

  bool _checkUserSelected(UserHierarchy hierarchyUser) {
    if (hierarchyUser.id == selectedUser) {
      return true;
    }

    if (hierarchyUser.hierarchy != null &&
        hierarchyUser.hierarchy!.isNotEmpty) {
      for (int i = 0; i < hierarchyUser.hierarchy!.length; i++) {
        return false || _checkUserSelected(hierarchyUser.hierarchy![i]);
      }
    }
    return false;
  }

  Widget getDynamicField(UserHierarchy? user, List<UserHierarchy>? users) {
    final controller = TextEditingController();
    if (user != null) {
      controller.text = user.name!;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomTextField(
        labelText: AppStrings.user,
        textController: controller,
        isreadOnly: true,
        onTap: () {
          if (users != null && users.isNotEmpty) {
            showModalBottomSheet(
                context: context,
                builder: (ctx) => HierarchyUserPopup(
                    users: users, onUserSelected: onUserSelected));
          }
        },
      ),
    );
  }

  onUserSelected(int salesmanId) {
    selectedUser = salesmanId;
    widget.onSalesmanChanged(selectedUser);
    setState(() {});
  }
}
