import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import '../../../../../core/theme/app_styles.dart';
import '../../../viewmodel/riverpod/currency_provider.dart';
import '../../../viewmodel/riverpod/expense_tracker_notifier.dart';
import '../../../viewmodel/riverpod/transaction_provider.dart';
import '../reusable_list_view.dart';

class TransactionInfo extends ConsumerWidget {
  final bool isScrollable;

  const TransactionInfo({
    super.key,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final filteredExpModel =
        ref.watch(filteredTransactionProvider).filteredExpModel;
    final isLoading =
        ref.watch(expenseTrackerProviderOriginal.notifier).isLoading;
    final currency = ref.watch(currencyProvider).symbol;
    return isLoading
        ? SizedBox(
            width: w,
            height: isScrollable ? h - 200 : 250,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : filteredExpModel.isEmpty
            ? SizedBox(
                width: w,
                height: isScrollable ? h * 0.5 : 250,
                child: Center(
                  child: Text(
                    'No transactions found',
                    style: AppStyles.descriptionPrimary(
                      context: context,
                    ),
                  ),
                ),
              )
            : isScrollable
                ? Expanded(
                    child: ReusableListView(
                      filteredExpModel: filteredExpModel,
                      currency: currency,
                      isScrollable: isScrollable,
                    ),
                  )
                : ReusableListView(
                    filteredExpModel: filteredExpModel,
                    currency: currency,
                    isScrollable: isScrollable,
                  );
  }
}


//  @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final double w = MediaQuery.of(context).size.width;
//     final double h = MediaQuery.of(context).size.height;
//     final filteredExpModel =
//         ref.watch(filteredTransactionProvider).filteredExpModel;
//     final state = ref.watch(expenseTrackerProviderOriginal.notifier);
//     final currency = ref.watch(currencyProvider).symbol;
//
//     print("Current state of ExpenseTracker: ${state}");
//     if (state is ExpenseTrackerLoadingState) {
//       return SizedBox(
//         width: w,
//         height: isScrollable ? h - 200 : 250,
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     if (filteredExpModel.isEmpty) {
//       return SizedBox(
//         width: w,
//         height: isScrollable ? h * 0.5 : 250,
//         child: Center(
//           child: Text(
//             'No transactions found',
//             style: AppStyles.descriptionPrimary(context: context),
//           ),
//         ),
//       );
//     }
//
//
//     return filteredExpModel.isEmpty
//         ? SizedBox(
//       width: w,
//       height: isScrollable ? h * 0.5 : 250,
//       child: Center(
//         child: Text(
//           'No transactions found',
//           style: AppStyles.descriptionPrimary(
//             context: context,
//           ),
//         ),
//       ),
//     )
//         : isScrollable
//         ? Expanded(
//       child: ReusableListView(
//         filteredExpModel: filteredExpModel,
//         currency: currency,
//         isScrollable: isScrollable,
//       ),
//     )
//         : ReusableListView(
//       filteredExpModel: filteredExpModel,
//       currency: currency,
//       isScrollable: isScrollable,
//     );
//   }