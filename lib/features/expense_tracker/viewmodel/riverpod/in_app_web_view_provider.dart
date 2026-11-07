import 'package:flutter_riverpod/flutter_riverpod.dart';

class InAppWebViewProvider extends StateNotifier<double> {
  InAppWebViewProvider() : super(0.0);

  void updateProgress(double newProgress) {
    if (newProgress >= 0.0 && newProgress <= 1.0) {
      state = newProgress;
    }
  }
}

final inAppWebViewProvider =
StateNotifierProvider<InAppWebViewProvider, double>(
      (ref) => InAppWebViewProvider(),
);
