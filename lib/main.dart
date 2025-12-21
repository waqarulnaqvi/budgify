import 'package:budgify/core/constants/constants.dart';
import 'package:budgify/shared/viewmodel/riverpod/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/constants/prefs_keys.dart';
import 'core/local/prefs_helper.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/paths.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize(); // ✅ Initialize AdMob SDK
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _loadFonts();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      // systemNavigationBarColor: AppColors.themeLight,
    ),
  );
  PrefsHelper prefs = PrefsHelper();
  final bool isSeenOnBoard =
      await prefs.getBoolValue(PrefsKeys.isSeenOnBoard) ?? false;

  runApp(ProviderScope(child: MyApp(isSeenOnBoard: isSeenOnBoard)));
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

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeAsyncValue = ref.watch(isLightThemeProvider);

    MaterialTheme theme = MaterialTheme();

    return MaterialApp(
      title: Constants.budgetFlow,
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),

      themeMode: themeAsyncValue.when(
        data: (isLight) => isLight ? ThemeMode.light : ThemeMode.dark,
        loading: () => ThemeMode.light, // default while loading
        error: (_, __) => ThemeMode.light,
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: isSeenOnBoard ? Paths.initial : Paths.onboardingPage,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics:
      analytics)],
    );
  }
}
