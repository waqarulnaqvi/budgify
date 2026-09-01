import 'dart:io';
import 'package:budgify/core/constants/constants.dart';
import 'package:budgify/shared/viewmodel/riverpod/theme_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'core/logger/app_logger.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/paths.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize(); // ✅ Initialize AdMob SDK
  // 1. Initialize Firebase
  final isFirebaseInitialized = await initializeFirebaseWithFallback();

  // 2. If it failed (returned false), the fallback UI is already running.
  // We just return to stop the rest of the app from executing.
  if (!isFirebaseInitialized) return;


  await configureCrashlyticsAndAnalytics();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      // systemNavigationBarColor: AppColors.themeLight,
    ),
  );

  runApp(ProviderScope(child: MyApp()));
}


/// Initializes Firebase and handles critical startup errors by showing a fallback UI.
/// Returns [true] if Firebase initialized successfully, or [false] if it failed.
Future<bool> initializeFirebaseWithFallback() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return true;
  } catch (e, s) {
    AppLogger.fatal('Firebase initialization failed', error: e, stackTrace: s);

    // Run a fallback UI instead of crashing to a blank screen
    runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'A critical error occurred while starting the app.\nPlease try restarting.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );

    return false;
  }
}

bool _isHandledImageLoadError(FlutterErrorDetails details) {
  final exceptionText = details.exception.toString();
  return details.library == 'image resource service' ||
      (exceptionText.contains('HttpException') &&
          exceptionText.contains('Invalid statusCode'));
}

Future<void> configureCrashlyticsAndAnalytics() async {
  if (kDebugMode) {
    // 🛠️ DEBUG MODE: Turn off Analytics globally
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);

    if (!kIsWeb) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      AppLogger.i(
        "Crashlytics & Analytics disabled. Local debug catchers activated.",
      );
    } else {
      AppLogger.i("Web Debug Mode: Analytics disabled.");
    }

    FlutterError.onError = (FlutterErrorDetails details) {
      if (_isHandledImageLoadError(details)) {
        AppLogger.d('Suppressed image load error: ${details.exception}');
        return;
      }
      AppLogger.e("🔴 CRITICAL FLUTTER UI ERROR CAUGHT:\n${details.exception}");
      FlutterError.presentError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.e(
        "🚨 CRITICAL ASYNC ERROR CAUGHT:\n$error",
        error: error,
        stackTrace: stack,
      );
      return false; // Returning false tells Flutter to print it normally to the console
    };
  } else {
    // 🚀 LIVE/RELEASE MODE
    if (!kIsWeb) {
      // 📊 FETCH INSTALLER SOURCE METADATA
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final store = packageInfo.installerStore ?? 'unknown_or_sideloaded';

      // Log the installation source to Crashlytics
      await FirebaseCrashlytics.instance.setCustomKey('installer_store', store);

      // --- CRASHLYTICS CONFIGURATION ---
      // Evaluates EVERY known platform, native package installer, store, browser, and sharing ecosystem
      final bool isFromOfficialStoreCrashAnalytics =
      (
          // 🍏 Apple Ecosystem
          store == 'com.apple' || // Apple App Store (iOS/macOS)
              store == 'com.apple.testflight' || // Apple TestFlight QA Tracks
              store ==
                  'com.apple.simulator' || // iOS Mac Core Simulator Environments
              // 🤖 Core Google / Android Systems
              store ==
                  'com.android.vending' || // Google Play Store (Production & Closed Tracks)
              store ==
                  'com.google.android.packageinstaller' || // Android OS Standard Manual Package Installer
              store ==
                  'com.android.packageinstaller' || // Native Package Installer (Older Android AOSP Versions)
              store ==
                  'adb' || // 🛠️ Flutter build apk --release / USB Debugging fallback installer ID
              // 📦 QA Testing, Cloud Storage & File Sharing Hubs
              store ==
                  'com.google.firebase.appdistribution' || // Firebase App Distribution Native App Hook
              store ==
                  'com.microsoft.appcenter' || // Microsoft Visual Studio App Center Client
              store ==
                  'com.dropbox.android' || // 📦 Dropbox Shared Link Downloads
              store ==
                  'com.google.android.apps.docs' || // 📦 Google Drive Shared Link Downloads
              store ==
                  'com.microsoft.skydrive' || // 📦 Microsoft OneDrive Shared Link Downloads
              store ==
                  'com.lenovo.anyshare.gps' || // 📳 SHAREit P2P Local Transfer Tool
              store == 'com.xender' || // 📳 Xender P2P Local Transfer Tool
              store ==
                  'com.google.android.apps.nbu.files' || // 📁 Files by Google (Local storage installation)
              // 💬 Communication & Messenger Apps (Direct Chat Attachment Installs)
              store == 'com.whatsapp' || // 🟢 WhatsApp Standard Messenger
              store == 'com.whatsapp.w4b' || // 🟢 WhatsApp Business Edition
              store ==
                  'org.telegram.messenger' || // 🔵 Telegram Messenger (Official Google Play Build)
              store ==
                  'org.telegram.messenger.web' || // 🔵 Telegram Direct APK Distribution Build
              store ==
                  'org.thoughtcrime.securesms' || // 🟡 Signal Private Messenger
              store == 'com.facebook.orca' || // 🔵 Meta Messenger
              // 🏭 Global OEM Hardware Manufacturer Storefronts
              store ==
                  'com.sec.android.app.samsungapps' || // Samsung Galaxy Store
              store == 'com.xiaomi.mipicks' || // Xiaomi GetApps Store
              store == 'com.huawei.appmarket' || // Huawei AppGallery
              store == 'com.oppo.market' || // OPPO App Market
              store == 'com.vivo.appstore' || // VIVO App Store
              store ==
                  'com.amazon.venezia' || // Amazon Appstore (Kindle Fire & Android Engine)
              store == 'com.lenovo.leos.appstore' || // Lenovo App Center
              store == 'com.htc.market' || // HTC BlinkFeed Market Hook
              store == 'co.asustek.appmarket' || // ASUS ZenUI App Store
              // 🌐 Major Android Mobile Web Browsers (Direct APK Download Handlers)
              store == 'com.android.chrome' || // Google Chrome Mobile
              store ==
                  'com.sec.android.app.sbrowser' || // Samsung Internet Browser
              store == 'org.mozilla.firefox' || // Mozilla Firefox Android
              store == 'com.opera.browser' || // Opera Mobile Web Browser
              store == 'com.microsoft.emmx' || // Microsoft Edge Mobile Android
              store == 'com.brave.browser' || // Brave Privacy Web Browser
              store == 'com.ucmobile.intl' || // UC Browser International Engine
              store ==
                  'com.duckduckgo.mobile.android' || // DuckDuckGo Mobile Browser
              store ==
                  'com.vivaldi.browser' // Vivaldi Web Engine for Android
      );

      if (isFromOfficialStoreCrashAnalytics) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
          true,
        );
        AppLogger.i(
          "Crashlytics actively enabled for authorized store/testing ($store).",
        );
      } else {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
          false,
        );
        AppLogger.i("Crashlytics disabled for unauthorized sideload ($store).");
      }

      // --- ANALYTICS CONFIGURATION ---
      final bool isFromOfficialStoreFirebaseAnalytics =
      (store == 'com.android.vending' || // Google Play Store
          store == 'com.apple' || // Apple App Store
          store == 'com.sec.android.app.samsungapps' || // Samsung Galaxy Store
          store == 'com.xiaomi.mipicks' || // Xiaomi GetApps Store
          store == 'com.huawei.appmarket' || // Huawei AppGallery
          store == 'com.amazon.venezia' || // Amazon Appstore
          store == 'com.oppo.market' || // OPPO App Market
          store ==
              'com.vivo.appstore' // Vivo App Store
      );
      if (isFromOfficialStoreFirebaseAnalytics) {
        await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
        AppLogger.i(
          "App installed from official store ($store). Analytics Enabled.",
        );
      } else {
        await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
        AppLogger.i(
          "App sideloaded or from testing/browser ($store). Analytics Disabled.",
        );
      }

      // --- ERROR ROUTING ---
      FlutterError.onError = (FlutterErrorDetails details) {
        if (_isHandledImageLoadError(details)) return;
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true; // Mark as handled
      };
    } else {
      // --- WEB RELEASE CONFIG ---
      AppLogger.i("Running on Web Release: Firebase Crashlytics is bypassed.");

      // Web doesn't have an installer store, so we simply enable Analytics directly.
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
      AppLogger.i("Analytics Enabled for Web Release.");

      // Basic error fallbacks for Web Release since Crashlytics is bypassed
      FlutterError.onError = (FlutterErrorDetails details) {
        if (_isHandledImageLoadError(details)) return;
        AppLogger.e("🔴 WEB FLUTTER UI ERROR CAUGHT:\n${details.exception}");
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        AppLogger.e(
          "🚨 WEB ASYNC ERROR CAUGHT:\n$error",
          error: error,
          stackTrace: stack,
        );
        return true; // Mark as handled
      };
    }
  }
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeAsyncValue = ref.watch(isLightThemeProvider);

    MaterialTheme theme = MaterialTheme();

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: AppConstants.budgetFlow,
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),

      themeMode: themeAsyncValue.when(
        data: (isLight) => isLight ? ThemeMode.light : ThemeMode.dark,
        loading: () => ThemeMode.light, // default while loading
        error: (_, __) => ThemeMode.light,
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute:  Paths.splash ,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics:
      analytics)],

      builder: Platform.isAndroid
          ? (context, child) => SafeArea(top: false, child: child!)
          : null,
    ));
  }
}
