import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/prefs_keys.dart';
import '../local/prefs_helper.dart';

class AdHelper {
  /* -------------------- BANNER AD -------------------- */
  /// Returns a new BannerAd instance
  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-4448937870984996/8375345668", // Ad Unit
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if(kDebugMode) {
            print('Ad loaded: $ad');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if(kDebugMode) {
            print("Ad failed to load: $error");
          }
          ad.dispose();
        },
      ),
    )..load();
  }

  /* -------------------- APP OPEN AD -------------------- */
  /// Creates, loads and immediately shows App Open Ad
  static void createAndShowAppOpenAd() {
    AppOpenAd.load(
      adUnitId: "ca-app-pub-4448937870984996/6935834543",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('App Open Ad loaded');
          }

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) async {
              if (kDebugMode) {
                print('App Open Ad showed');
              }

              // ✅ Increment count ONLY after successful show
              final prefs = PrefsHelper();
              final count =
                  await prefs.getIntValue(PrefsKeys.isShowOpenAds) ?? 1;
              await prefs.setIntValue(PrefsKeys.isShowOpenAds, count + 1);
            },
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) {
                print('App Open Ad dismissed');
              }
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              if (kDebugMode) {
                print('App Open Ad failed to show: $error');
              }
              ad.dispose();
            },
          );

          // 🚀 SHOW IMMEDIATELY
          ad.show();
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print('App Open Ad failed to load: $error');
          }
        },
      ),
    );
  }
}


// // //   adUnitId: "ca-app-pub-3940256099942544/6300978111", // Test Ad Unit
// // // adUnitId: "ca-app-pub-4448937870984996/5745138234", // Original Ad Unit
