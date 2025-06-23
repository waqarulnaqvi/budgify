import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../viewmodel/riverpod/currency_provider.dart';
import '../../../viewmodel/riverpod/expense_tracker_notifier.dart';
import '../../../viewmodel/riverpod/investment_provider.dart';
import '../../../viewmodel/riverpod/tax_provider.dart';
import '../reusable_list_view.dart';

class ReusableInfo extends ConsumerWidget {
  final bool isTaxPage;
  final bool isScrollable;

  const ReusableInfo({
    super.key,
    this.isTaxPage = true,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackerList = isTaxPage
        ? ref.watch(filteredTaxProvider).trackerModel
        : ref.watch(filteredInvestmentProvider).trackerModel;
    final isLoading = ref.watch(expenseTrackerProviderOriginal.notifier).isLoading;
    final currency = ref.watch(currencyProvider).value?.symbol ?? '₹';
    // final rProvider = isTaxPage
    //     ? ref.read(taxProvider.notifier)
    //     : ref.read(investmentProvider.notifier);
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return isLoading
        ? SizedBox(
            width: w,
            height: isScrollable ? h - 200 : 250,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : trackerList.isEmpty
            ? SizedBox(
                width: w,
                height: isScrollable ? h*0.5 : 250,
                child: Center(
                  child: Text(
                    isTaxPage ? 'No Tax History' : 'No Investment History',
                    style: AppStyles.descriptionPrimary(
                      context: context,
                    ),
                  ),
                ),
              )
            : isScrollable
                ? Expanded(
                    child: ReusableListView(
                      filteredExpModel: trackerList,
                      currency: currency,
                      isScrollable: isScrollable,
                    ),
                  )
                : ReusableListView(
                    filteredExpModel: trackerList,
                    currency: currency,
                    isScrollable: isScrollable,
                  );
  }
}
