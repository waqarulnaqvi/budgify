import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_styles.dart';
import '../../../features/expense_tracker/model/currency_model.dart';
import '../../../features/expense_tracker/viewmodel/riverpod/currency_provider.dart';

class CurrencyPicker extends ConsumerWidget {
  const CurrencyPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyProvider);
    final theme = Theme.of(context).colorScheme;
    final double w = MediaQuery.of(context).size.width;
    final rProvider = ref.read(currencyProvider.notifier);
    // HiveDatabase hiveDatabase = HiveDatabase();


    return Container(
      width: w,
      padding: const EdgeInsets.symmetric(vertical: 10).copyWith(left: 15,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.surface,
        border: Border.all(
          width: 1,
          color: theme.onSurface,
        ),
      ),
      child: InkWell(
        onTap: () {
          showCurrencyPicker(
            context: context,
            showFlag: true,
            showCurrencyName: true,
            showCurrencyCode: true,
            onSelect: (Currency currency) {
              rProvider.state = CurrencyModel.fromJson(currency);
               // hiveDatabase.put(HiveDatabase.currentCurrencyBox, "${currency.name} - ${currency.code} - ${currency.symbol}");
              // print(currency.name);
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
                  "${currency.name} - ${currency.code} - ${currency.symbol}",
                  style: AppStyles.descriptionPrimary(context: context),
                )),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: theme.onSurface,
            )
          ],
        ),
      ),
    );
  }
}