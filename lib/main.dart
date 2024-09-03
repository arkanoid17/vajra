import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vajra_test/cores/features/location/bloc/location_bloc.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/features/auth/view/pages/login.dart';
import 'package:vajra_test/features/auth/viewmodel/bloc/auth_bloc_bloc.dart';
import 'package:vajra_test/features/home/view/pages/home_page.dart';
import 'package:vajra_test/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:vajra_test/features/store/viewmodel/bloc/stores_bloc.dart';
import 'package:vajra_test/features/sync/viewmodel/bloc/sync_bloc.dart';
import 'package:vajra_test/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBlocBloc(),
      ),
      BlocProvider(
        create: (_) => HomeBloc(),
      ),
      BlocProvider(
        create: (_) => SyncBloc(),
      ),
      BlocProvider(
        create: (context) => LocationBloc(context: context),
      ),
      BlocProvider(
        create: (context) =>
            StoresBloc(locationBloc: context.read<LocationBloc>()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocationBloc>().add(FetchLocationPermissionEvent());

    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Vajra',
        theme: AppTheme.apptheme,
        debugShowCheckedModeBanner: false,
        home: BlocSelector<AuthBlocBloc, AuthBlocState, bool>(
          selector: (state) {
            return state is AuthUserAuthenticated;
          },
          builder: (context, isauthenticated) {
            if (isauthenticated) {
              return const HomePage();
            }
            return const Login();
          },
        ));
  }
}
