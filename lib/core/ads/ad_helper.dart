import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
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
}


// // //   adUnitId: "ca-app-pub-3940256099942544/6300978111", // Test Ad Unit
// // // adUnitId: "ca-app-pub-4448937870984996/5745138234", // Original Ad Unit
