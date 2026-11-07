import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
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
    AsyncNotifierProvider<TransactionAsyncNotifier, String>(
        TransactionAsyncNotifier.new);

final filteredTransactionProvider = Provider<TransactionSummary>((ref) {
  final transactionAsync = ref.watch(transactionProvider);

  return transactionAsync.when(
    data: (transactionTypeValue) {
      final wProvider = ref.watch(expenseTrackerProvider).trackerCategory;

      double totalBalance = 0.0,
          totalIncome = wProvider.totalIncome,
          totalExpense = wProvider.totalExpense;
      final isExcludeInvestmentAndTax = transactionTypeValue ==
          TransactionType.excludingInvestmentAndTax.value;

      if (isExcludeInvestmentAndTax) {
        totalBalance = wProvider.totalIncome - wProvider.totalExpense;
        totalIncome = wProvider.totalIncome;
        totalExpense = wProvider.totalExpense;
      } else {
        totalBalance = wProvider.totalIncome -
            wProvider.totalExpense +
            wProvider.investment +
            wProvider.tax;

        /// Investment and tax are considered as income and expense respectively
        if (wProvider.tax >= 0) {
          totalIncome += wProvider.tax;
        } else if (wProvider.tax < 0) {
          totalExpense -= wProvider.tax;
        }

        if (wProvider.investment >= 0) {
          totalIncome += wProvider.investment;
        } else if (wProvider.investment < 0) {
          totalExpense -= wProvider.investment;
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

      List<FilteredExpModel> filteredExpenses = [];

      ///Based on Filter Provider - Filter the data like date wise and category wise
      final selectedFilter = ref.watch(filterProvider);

      if (selectedFilter == FilterType.dateWise.stringValue) {
        List<DateTime> uniqueDates = [];

        for (TrackerModel exp in filteredList) {
          DateTime eachDate = parseDate(exp.date);
          // String eachDate = parseDate(exp.date).toIso8601String().split('T')[0];
          if (!uniqueDates.contains(eachDate)) {
            uniqueDates.add(eachDate);
          }
        }

        for (DateTime eachDate in uniqueDates) {
          num bal = 0.0;
          List<TrackerModel> allExp = [];
          for (TrackerModel eachExp in filteredList) {
            DateTime expDate = parseDate(eachExp.date);
            if (expDate.isAtSameMomentAs(eachDate)) {
              allExp.add(eachExp);
              if (eachExp.trackerCategory == ExpenseType.expense.intValue) {
                bal -= eachExp.amount!;
              } else if (eachExp.trackerCategory ==
                  ExpenseType.income.intValue) {
                bal += eachExp.amount!;
              } else if (eachExp.trackerCategory ==
                  ExpenseType.investment.intValue) {
                /// Representing investment returns
                if (eachExp.percentage >= 0) {
                  bal += eachExp.amount! +
                      (eachExp.amount! * (eachExp.percentage / 100));
                } else {
                  bal += eachExp.amount! -
                      (eachExp.amount! * (eachExp.percentage / 100));
                }
              } else {
                bal += eachExp.amount! -
                    (eachExp.amount! * (eachExp.percentage / 100));
              }
            }
          }

          if (allExp.isNotEmpty) {
            filteredExpenses.add(FilteredExpModel(
              title: formatDate(eachDate),
              bal: bal,
              allExp: allExp,
            ));
          }
        }
      } else //selectedFilter == FilterType.categoryWise.stringValue
      {
        for (Map<String, dynamic> eachCat in AppConstants.mCat) {
          num bal = 0.0;
          List<TrackerModel> eachCatExp = [];
          for (TrackerModel eachExp in filteredList) {
            if (eachExp.chooseCategory == eachCat['catId']) {
              eachCatExp.add(eachExp);
              if (eachExp.trackerCategory == ExpenseType.expense.intValue) {
                bal -= eachExp.amount!;
              } else if (eachExp.trackerCategory ==
                  ExpenseType.income.intValue) {
                bal += eachExp.amount!;
              } else if (eachExp.trackerCategory ==
                  ExpenseType.investment.intValue) {
                bal += eachExp.amount!; // Investment is considered as income
                // Do not include investment and tax in balance calculation
              }
            }
          }

          if (eachCatExp.isNotEmpty) {
            filteredExpenses.add(FilteredExpModel(
              title: eachCat['catName'],
              image: eachCat['catImage'],
              bal: bal,
              allExp: eachCatExp,
            ));
          }
        }
      }

      return TransactionSummary(
        filteredExpModel: filteredExpenses,
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


// final transactionProvider =
// StateProvider<String>((ref) => TransactionType.allTransactions.value);

// final transactionProvider = FutureProvider<String>((ref) async {
//   final prefsHelper = PrefsHelper();
//   String? savedFilter = await prefsHelper.getStringValue(PrefsKeys.allFilter);
//   return savedFilter ?? TransactionType.allTransactions.value;
// });
