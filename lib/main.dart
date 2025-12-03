import 'package:budgify/core/constants/constants.dart';
import 'package:budgify/shared/viewmodel/riverpod/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/prefs_keys.dart';
import 'core/local/prefs_helper.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/paths.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _loadFonts();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    // systemNavigationBarColor: AppColors.themeLight,
  ));
  PrefsHelper prefs = PrefsHelper();
  final bool isSeenOnBoard =
      await prefs.getBoolValue(PrefsKeys.isSeenOnBoard) ?? false;

  runApp(ProviderScope(child: MyApp(isSeenOnBoard: isSeenOnBoard),));
}

Future<void> _loadFonts() async {
  // Load Poppins font
  final fontLoaderPoppins = FontLoader('Poppins')
    ..addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'));

  // Load Montserrat font
  final fontLoaderMontserrat = FontLoader('Montserrat')
    ..addFont(rootBundle.load('assets/fonts/Montserrat-Regular.ttf'));

  // Load both fonts
  await Future.wait([
    fontLoaderPoppins.load(),
    fontLoaderMontserrat.load(),
  ]);
}

class MyApp extends ConsumerWidget {
  final bool isSeenOnBoard;

  const MyApp({super.key, required this.isSeenOnBoard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeAsyncValue = ref.watch(isLightThemeProvider);
    TextTheme textTheme = createTextTheme(
      context,
      "Noto Music",
      "Noto Sans Display",
    );
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: Constants.budgetFlow,
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      // themeMode: ThemeMode.system,
      // theme: themeAsyncValue.when(
      //   data: (isLight) => isLight ? theme.light() : theme.dark(),
      //   loading: () => theme.light(), // default while loading
      //   error: (_, __) => theme.light(),
      // ),
      themeMode: themeAsyncValue.when(
        data: (isLight) => isLight ? ThemeMode.light : ThemeMode.dark,
        loading: () => ThemeMode.light, // default while loading
        error: (_, __) => ThemeMode.light,
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: isSeenOnBoard ?  Paths
          .initial : Paths.onboardingPage,
    );
  }
}
