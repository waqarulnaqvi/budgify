
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/prefs_keys.dart';
import '../../../core/local/prefs_helper.dart';

class ThemeAsyncNotifier extends AsyncNotifier<bool> {
  final prefsHelper = PrefsHelper();

  @override
  Future<bool> build() async {
    final saved =await prefsHelper.getBoolValue(PrefsKeys.themeFilter);
    return saved ?? true;
  }

  Future<void> setFilter(bool newValue) async {
    await prefsHelper.setBoolValue(PrefsKeys.themeFilter, newValue);
    state = AsyncValue.data(newValue);
  }
}

final isLightThemeProvider =
AsyncNotifierProvider<ThemeAsyncNotifier, bool>(
    ThemeAsyncNotifier.new);