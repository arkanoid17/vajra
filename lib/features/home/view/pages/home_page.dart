import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/features/location/bloc/location_bloc.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/widgets/loader.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/home/view/widgets/app_drawer.dart';
import 'package:vajra_test/features/home/view/widgets/home_cards.dart';
import 'package:vajra_test/features/home/view/widgets/last_sync_card.dart';
import 'package:vajra_test/features/home/view/widgets/places_dropdown.dart';
import 'package:vajra_test/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:vajra_test/features/store/view/pages/store_page.dart';
import 'package:vajra_test/features/sync/view/widgets/sync_viewer.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '', empId = '';
  List<Locations> places = [];
  Locations? selectedLocation;
  String lastSyncTime = AppStrings.noSyncDone;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeInitialEvent());
    context.read<LocationBloc>().add(FetchLocationServiceEvent());
    context.read<LocationBloc>().add(FetchLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFetchUserData) {
          name = state.name;
          empId = state.empId;
          places = state.loactions;
          selectedLocation = state.loactions[0];
          lastSyncTime = state.lastSyncTime;
          setState(() {});
        }
        if (state is HomeSyncTimeUpdated) {
          lastSyncTime = state.lastSyncTime;
          setState(() {});
        }
      },
      builder: (context, state) {
        return state is HomeLoadingState
            ? const Loader()
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration:
                        const BoxDecoration(color: AppPalette.whiteColor),
                  ),
                  SizedBox(
                    child: SvgPicture.asset(
                      width: MediaQuery.of(context).size.width,
                      'assets/images/home_bg.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Scaffold(
                    backgroundColor: AppPalette.transparent,
                    appBar: AppBar(
                      backgroundColor: AppPalette.transparent,
                      title: places.isNotEmpty
                          ? PlacesDropdown(
                              places: places,
                              selectedLocation: selectedLocation ?? Locations(),
                              locationSelected: _locationSelected,
                            )
                          : Container(),
                      actions: const [
                        SyncViewer(),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    drawer: AppDrawer(
                      name: name,
                      empId: empId,
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Transform.translate(
                                offset: const Offset(-30, 0),
                                child: SvgPicture.asset(
                                  'assets/images/home_hello.svg',
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    AppStrings.welcomeText,
                                    style: TextStyle(
                                        color: AppPalette.welcomeTextColor,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        color: AppPalette.whiteColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    empId,
                                    style: const TextStyle(
                                        color: AppPalette.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                HomeCards(
                                  header: AppStrings.bills,
                                  todayValue: '0',
                                  monthValue: '0',
                                  syncPendingValue: '0',
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                HomeCards(
                                  header: AppStrings.noBills,
                                  todayValue: '0',
                                  monthValue: '0',
                                  syncPendingValue: '0',
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                HomeCards(
                                  header: AppStrings.nrv,
                                  todayValue: '0',
                                  monthValue: '0',
                                  syncPendingValue: '0',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            margin:
                                const EdgeInsets.all(AppDimens.screenPadding),
                            child: Container(
                              padding:
                                  const EdgeInsets.all(AppDimens.screenPadding),
                              width: double.infinity,
                              height: 300,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.performance,
                                        style: AppTheme.textTheme(
                                            AppPalette.blackColor,
                                            16.0,
                                            FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Text(
                                        'No data to load!',
                                        style: AppTheme.textTheme(Colors.orange,
                                            18.0, FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LastSyncCard(
                            status: AppStrings.online,
                            time: lastSyncTime,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    4,
                                  ),
                                ),
                                backgroundColor:
                                    AppPalette.homeStartButtonColor,
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                StorePage.route(),
                              ),
                              child: Text(
                                AppStrings.start.toUpperCase(),
                                style: AppTheme.textTheme(
                                  AppPalette.whiteColor,
                                  14.0,
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  _locationSelected(Locations location) {
    selectedLocation = location;
    setState(() {});
  }
}
