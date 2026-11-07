import 'package:currency_picker/currency_picker.dart';

class CurrencyModel {
  final String name;
  final String code;
  final String symbol;

  CurrencyModel({
    required this.name,
    required this.code,
    required this.symbol,
  });


  // factory CurrencyModel.fromJson(Currency currency) {
  //   return CurrencyModel(
  //     name: currency.name,
  //     code: currency.code,
  //     symbol: currency.symbol,
  //   );
  // }
}