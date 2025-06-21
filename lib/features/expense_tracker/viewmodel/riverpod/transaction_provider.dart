import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../model/tracker_model.dart';
import '../../model/transaction_summary.dart';
import '../../utils/expense_type.dart';
import '../../utils/filter_type.dart';
import '../../utils/transaction_type.dart';
import 'expense_tracker_notifier.dart';
import 'filter_provider.dart';

// final transactionProvider =
// StateProvider<String>((ref) => TransactionType.allTransactions.value);


// final transactionProvider = FutureProvider<String>((ref) async {
//   final prefsHelper = PrefsHelper();
//   String? savedFilter = await prefsHelper.getStringValue(PrefsKeys.allFilter);
//   return savedFilter ?? TransactionType.allTransactions.value;
// });


class TransactionAsyncNotifier extends AsyncNotifier<String> {
  final prefsHelper = PrefsHelper();

  @override
  Future<String> build() async {
    final saved = await prefsHelper.getStringValue(PrefsKeys.allFilter);
    return saved ?? TransactionType.allTransactions.value;
  }

  Future<void> setFilter(String newValue) async {
    await prefsHelper.setStringValue(PrefsKeys.allFilter, newValue);
    state = AsyncValue.data(newValue);
  }
}

final transactionProvider =
AsyncNotifierProvider<TransactionAsyncNotifier, String>(TransactionAsyncNotifier.new);



final filteredTransactionProvider = Provider<TransactionSummary>((ref) {
  final transactionAsync = ref.watch(transactionProvider);

  return transactionAsync.when(
    data: (transactionTypeValue) {
      final wProvider = ref.watch(expenseTrackerProvider).trackerCategory;

      double totalBalance = 0.0, totalIncome = 0.0, totalExpense = 0.0;
      final isExcludeInvestmentAndTax =
          transactionTypeValue == TransactionType.excludingInvestmentAndTax.value;

      if (isExcludeInvestmentAndTax) {
        totalBalance = wProvider.totalIncome - wProvider.totalExpense;
        totalIncome = wProvider.totalIncome;
        totalExpense = wProvider.totalExpense;
      } else {
        totalBalance = wProvider.totalIncome -
            wProvider.totalExpense +
            wProvider.investment -
            wProvider.tax;
        if (wProvider.investment > 0) {
          totalIncome += wProvider.investment + wProvider.totalIncome;
          totalExpense += wProvider.totalExpense - wProvider.tax;
        } else {
          totalIncome += wProvider.totalIncome;
          totalExpense +=
              wProvider.totalExpense - wProvider.tax - wProvider.investment;
        }
      }

      ///Based on the selected transaction type, filter the data
      final allData = ref.watch(expenseTrackerProvider).trackers;
      List<TrackerModel> filteredList = [];

      if (transactionTypeValue == TransactionType.mostExpensive.value) {
        filteredList = allData
            .where((tracker) =>
        tracker.trackerCategory == ExpenseType.expense.intValue)
            .toList()
          ..sort((a, b) => b.amount!.compareTo(a.amount!));
      } else if (transactionTypeValue ==
          TransactionType.excludingInvestmentAndTax.value) {
        filteredList = allData
            .where((tracker) =>
        (tracker.trackerCategory != ExpenseType.investment.intValue) &&
            (tracker.trackerCategory != ExpenseType.tax.intValue))
            .toList();
      } else if (transactionTypeValue == TransactionType.leastExpensive.value) {
        filteredList = allData
            .where((tracker) =>
        tracker.trackerCategory == ExpenseType.expense.intValue)
            .toList()
          ..sort((a, b) => a.amount!.compareTo(b.amount!));
      } else if (transactionTypeValue ==
          TransactionType.transactionsNewestToOldest.value) {
        filteredList = allData.toList()
          ..sort((a, b) => parseDate(b.date).compareTo(parseDate(a.date)));
      } else if (transactionTypeValue == TransactionType.mostIncome.value) {
        filteredList = allData
            .where((tracker) =>
        tracker.trackerCategory == ExpenseType.income.intValue)
            .toList()
          ..sort((a, b) => b.amount!.compareTo(a.amount!));
      } else if (transactionTypeValue == TransactionType.leastIncome.value) {
        filteredList = allData
            .where((tracker) =>
        tracker.trackerCategory == ExpenseType.income.intValue)
            .toList()
          ..sort((a, b) => a.amount!.compareTo(b.amount!));
      } else if (transactionTypeValue ==
          TransactionType.transactionsOldestToNewest.value) {
        filteredList = allData.toList()
          ..sort((a, b) => parseDate(a.date).compareTo(parseDate(b.date)));
      } else {
        filteredList = allData;
      }


      ///Based on Filter Provider - Filter the data like date wise and category wise
      final selectedFilter = ref.watch(filterProvider);

      if(selectedFilter == FilterType.dateWise.stringValue) {
        // filteredList = filteredList.where((tracker) {
        //   DateTime trackerDate = parseDate(tracker.date);
        //   return trackerDate.isAfter(wProvider.startDateFilter!.subtract(Duration(days: 1))) &&
        //       trackerDate.isBefore(wProvider.endDateFilter!.add(Duration(days: 1)));
        // }).toList();
      } else //selectedFilter == FilterType.categoryWise.stringValue
        {
        // filteredList = filteredList.where((tracker) =>
        //     tracker.trackerCategory == wProvider.selectedCategory).toList();
      }


      return TransactionSummary(
        trackerModel: filteredList,
        transactionModel: TransactionModel(
          income: totalIncome.toStringAsFixed(2),
          expense: totalExpense.toStringAsFixed(2),
          totalBalance: totalBalance.toStringAsFixed(2),
        ),
      );
    },
    loading: () => TransactionSummary.empty(),
    error: (err, stack) {
      // log or handle the error as needed
      return TransactionSummary.empty();
    },
  );
});
