import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../model/currency_model.dart';

// Date Provider
class CurrencyAsyncNotifier extends AsyncNotifier<CurrencyModel> {
  final prefsHelper = PrefsHelper();

  @override
  Future<CurrencyModel> build() async {
    final saved = await prefsHelper.getStringValue(PrefsKeys.currencyFilter);
    List data = saved != null ? saved.split('/') : [];
    String name = 'Indian Rupee';
    String code = 'INR';
    String symbol = '₹';
    if (data.isNotEmpty) {
      name = data[0];
      code = data[1];
      symbol = data[2];
    }

    return CurrencyModel(name: name, code: code, symbol: symbol);
  }

  Future<void> currencyFilter(
      {required String name,
      required String code,
      required String symbol}) async {
    await prefsHelper.setStringValue(
        PrefsKeys.currencyFilter, "$name/$code/$symbol");
    state = AsyncValue.data(
      CurrencyModel(name: name, code: code, symbol: symbol),
    );
  }
}

final currencyProvider =
    AsyncNotifierProvider<CurrencyAsyncNotifier, CurrencyModel>(
        CurrencyAsyncNotifier.new);

// final currencyProvider = StateProvider<CurrencyModel>((ref) {
//   return CurrencyModel(
//     name:  'Indian Rupee',
//     code: 'INR',
//     symbol: '₹',
//   );
// });
