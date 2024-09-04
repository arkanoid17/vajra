import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/widgets/loader.dart';
import 'package:vajra_test/features/sync/viewmodel/bloc/sync_bloc.dart';

class SyncViewer extends StatefulWidget {
  const SyncViewer({super.key});

  @override
  State<SyncViewer> createState() => _SyncViewerState();
}

class _SyncViewerState extends State<SyncViewer> {
  int syncPendingCount = 0;

  @override
  void initState() {
    context.read<SyncBloc>().add(SyncStartEvent(isForced: false));

    getPendingSyncData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SyncBloc, SyncState>(
      listener: (context, state) {
        if (state is SyncSuccessState) {
          AppUtils.isSyncing = false;
          showSnackbar(context, AppStrings.dataRetrievedSuccessfully);
        }

        if (state is SyncErrorState) {
          AppUtils.isSyncing = false;
          showSnackbar(context, AppStrings.failedToSync);
        }
      },
      builder: (context, state) {
        if (state is SyncLoadingState) {
          return const Loader(
            loaderColor: AppPalette.whiteColor,
          );
        }
        return Container();
      },
    );
  }

  void getPendingSyncData() {}
}
