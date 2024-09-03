import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/widgets/loader.dart';
import 'package:vajra_test/features/store/model/models/store.dart';
import 'package:vajra_test/features/store/model/repository/stores_local_repository.dart';
import 'package:vajra_test/features/store/view/pages/store_filters.dart';
import 'package:vajra_test/features/store/view/widgets/store_card.dart';
import 'package:vajra_test/features/store/viewmodel/bloc/stores_bloc.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';

class StorePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const StorePage());

  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<UserHierarchyBeats> selectedBeats = [];
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late int salesmanId;

  List<Store> stores = [];

  late Position lastLocation;

  @override
  void initState() {
    salesmanId = getSalesmanId();

    fetchInitialLocations();

    context.read<StoresBloc>().add(
          FetchBeatsEvent(
            id: salesmanId,
            date: selectedDate,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<StoresBloc, StoresState>(
            buildWhen: (prev, current) => current is! StoreListState,
            builder: (context, state) {
              if (state is BeatsFetchedState) {
                selectedBeats = state.beats;
              }
              return Text(
                selectedBeats
                    .map(
                      (e) => e.name!,
                    )
                    .toList()
                    .join(','),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.push(context, StoreFilters.route(selectedDate)),
              icon: const Icon(
                Icons.filter_alt_outlined,
              ),
            ),
          ],
        ),
        body: BlocConsumer<StoresBloc, StoresState>(
          buildWhen: (previous, current) => current is StoreListState,
          listener: (context, state) {
            if (state is BeatsFetchedState) {
              _onBeatsFetched(state);
            }
            if (state is OnLocationChangedState) {
              _onLocationFetched(state);
            }
          },
          builder: (context, state) {
            if (state is StoresLoadingState) {
              return const Loader();
            }

            if (state is StoresFetchedState) {
              stores = state.stores;

              stores.sort((a, b) => a.distance!.compareTo(b.distance!));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimens.screenPadding,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: '${AppStrings.showingResults}: ',
                        style: AppTheme.smallText,
                        children: [
                          TextSpan(
                              text: '${stores.length}',
                              style: AppTheme.smallText),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: stores.length,
                      itemBuilder: (ctx, pos) => StoreCard(
                        store: stores[pos],
                      ),
                    ),
                  )
                ],
              );
            }

            return Container();
          },
        ));
  }

  void fetchInitialLocations() async {
    lastLocation = await Geolocator.getCurrentPosition();
  }

  void _onBeatsFetched(BeatsFetchedState state) {
    context.read<StoresBloc>().add(
          FetchStoresEvent(
            selectedBeats: state.beats,
            salesmanId: salesmanId,
          ),
        );
  }

  void _onLocationFetched(OnLocationChangedState state) {
    final repo = StoresLocalRepository();
    repo.updateStoreDistances(state.location, stores);
    context.read<StoresBloc>().add(
          FetchStoresEvent(
            selectedBeats: selectedBeats,
            salesmanId: salesmanId,
          ),
        );
  }
}
