import 'package:flutter/material.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/widgets/loader.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_remote_repository.dart';

class SyncViewer extends StatelessWidget {
  final int syncPendingCount;
  final bool isSyncing;
  final int percent;

  const SyncViewer(
      {super.key,
      required this.syncPendingCount,
      required this.isSyncing,
      required this.percent});

  @override
  Widget build(BuildContext context) {
    getData();

    return Container(
      child: syncPendingCount > 0
          ? Container()
          : isSyncing
              ? const Loader(
                  loaderColor: AppPalette.whiteColor,
                )
              : Container(),
    );
  }

  void getData() async {
    final data = await UserHierarchyRemoteRepository().getUserHierarchy(false);
    data.fold((err) => print(err), (hierarchy) => print(hierarchy.length));
  }
}
