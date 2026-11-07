import 'package:budgify/core/local/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/transaction_type.dart';
import '../../../viewmodel/riverpod/transaction_provider.dart';
import '../custom_drop_down.dart';

class TransactionFilter extends StatefulWidget {
  const TransactionFilter({super.key});

  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  PrefsHelper prefsHelper = PrefsHelper();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer(builder: (context, ref, child) {
      final asyncValue = ref.watch(transactionProvider);

      return asyncValue.when(
        data: (selectedValue) {
          return CustomDropDown(
            icon: Icons.arrow_drop_down_rounded,
            categories: TransactionType.values.map((e) => e.value).toList(),
            leadingIconSize: 20,
            onChanged: (newValue) async {
              if (newValue != null) {
                await ref
                    .read(transactionProvider.notifier)
                    .setFilter(newValue);
              }
            },
            selectedValue: selectedValue,
            faLeadingIcon: FontAwesomeIcons.receipt,
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
