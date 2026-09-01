import 'package:budgify/features/expense_tracker/utils/investment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/local/prefs_helper.dart';
import '../../../viewmodel/riverpod/investment_provider.dart';
import '../custom_drop_down.dart';

class InvestmentFilter extends StatefulWidget {
  const InvestmentFilter({super.key});

  @override
  State<InvestmentFilter> createState() => _InvestmentFilterState();
}

class _InvestmentFilterState extends State<InvestmentFilter> {
  PrefsHelper prefsHelper = PrefsHelper();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer(builder: (context, ref, child) {
      final asyncValue = ref.watch(investmentProvider);

      return asyncValue.when(
        data: (selectedValue) {
          return CustomDropDown(
            icon: Icons.arrow_drop_down_rounded,
            categories: InvestmentType.values.map((e) => e.value).toList(),
            leadingIconSize: 20,
            onChanged: (newValue) async {
              if (newValue != null) {
                await ref.read(investmentProvider.notifier).setFilter(newValue);
              }
            },
            selectedValue: selectedValue,
            faLeadingIcon: FontAwesomeIcons.sackDollar,
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
