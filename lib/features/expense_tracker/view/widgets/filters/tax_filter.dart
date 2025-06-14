import 'package:budgify/features/expense_tracker/utils/tax_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/local/prefs_helper.dart';
import '../../../viewmodel/riverpod/tax_provider.dart';
import '../custom_drop_down.dart';

class TaxFilter extends StatefulWidget {
  const TaxFilter({super.key});

  @override
  State<TaxFilter> createState() => _TaxFilterState();
}

class _TaxFilterState extends State<TaxFilter> {
  PrefsHelper prefsHelper = PrefsHelper();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer(builder: (context, ref, child) {
      final asyncValue = ref.watch(taxProvider);

      return asyncValue.when(
        data: (selectedValue) {
          return CustomDropDown(
            icon: Icons.arrow_drop_down_rounded,
            categories: TaxType.values.map((e) => e.value).toList(),
            leadingIconSize: 20,
            onChanged: (newValue) async {
              if (newValue != null) {
                await ref.read(taxProvider.notifier).setFilter(newValue);
              }
            },
            selectedValue: selectedValue,
            leadingIcon: Icons.receipt_long,
            color: theme.onSurface,
            borderColor: theme.onSurface,
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      );
    });
  }
}
