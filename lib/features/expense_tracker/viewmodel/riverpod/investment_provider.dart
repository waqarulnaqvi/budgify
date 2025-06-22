import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../model/investment_summary.dart';
import '../../model/tracker_model.dart';
import '../../utils/expense_type.dart';
import '../../utils/filter_type.dart';
import '../../utils/investment_type.dart';
import 'expense_tracker_notifier.dart';
import 'filter_provider.dart';

// final investmentProvider =
// StateProvider<String>((ref) => InvestmentType.investmentLatestFirst.value);

class InvestmentAsyncNotifier extends AsyncNotifier<String> {
  final prefsHelper = PrefsHelper();

  @override
  Future<String> build() async {
    final saved = await prefsHelper.getStringValue(PrefsKeys.investmentFilter);
    return saved ?? InvestmentType.investmentLatestFirst.value;
  }

  Future<void> setFilter(String newValue) async {
    await prefsHelper.setStringValue(PrefsKeys.investmentFilter, newValue);
    state = AsyncValue.data(newValue);
  }
}

final investmentProvider =
    AsyncNotifierProvider<InvestmentAsyncNotifier, String>(
        InvestmentAsyncNotifier.new);

final filteredInvestmentProvider = Provider<InvestmentSummary>((ref) {
  final investmentAsync = ref.watch(investmentProvider);

  return investmentAsync.when(
    data: (filter) {
      final allData = ref.watch(expenseTrackerProvider).trackers;

      List<TrackerModel> filteredList = [];
      double currentAmount = 0.0;
      double investedAmount = 0.0;
      double totalReturns = 0.0;
      double returnsPercentage = 0.0;

      if (filter == InvestmentType.investmentLatestFirst.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.investment.intValue)
            .toList()
          ..sort((a, b) => parseDate(b.date).compareTo(parseDate(a.date)));

        // Newest to Oldest
      } else if (filter == InvestmentType.investmentOldestFirst.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.investment.intValue)
            .toList()
          ..sort((a, b) => parseDate(a.date)
              .compareTo(parseDate(b.date))); // Oldest to Newest
      } else if (filter == InvestmentType.investmentHighToLow.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.investment.intValue)
            .toList()
          ..sort((a, b) => b.amount!.compareTo(a.amount!));
      } else if (filter == InvestmentType.investmentLowToHigh.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.investment.intValue)
            .toList()
          ..sort((a, b) => a.amount!.compareTo(b.amount!));
      }

      for (var tracker in filteredList) {
        investedAmount += tracker.amount!;
        totalReturns += tracker.amount! * (tracker.percentage / 100);
        returnsPercentage += tracker.percentage;
      }
      if (filteredList.isNotEmpty) {
        returnsPercentage = returnsPercentage / filteredList.length;
      }
      currentAmount = investedAmount + totalReturns;

      ///Based on Filter Provider - Filter the data like date wise and category wise
      final selectedFilter = ref.watch(filterProvider);
      List<FilteredExpModel> filteredExpenses = [];

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
              }
              else if (eachExp.trackerCategory ==
                  ExpenseType.income.intValue) {
                bal += eachExp.amount!;
              }
              else if (eachExp.trackerCategory ==
                  ExpenseType.investment.intValue) {
                /// Representing investment returns
                if(eachExp.percentage >=0)
                  {
                    bal += eachExp.amount!;
                  }
                else{
                    bal -= eachExp.amount!;
                }

              } else {
                bal -= eachExp.amount!;
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
        for (Map<String, dynamic> eachCat in Constants.mCat) {
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

      return InvestmentSummary(
          trackerModel: filteredExpenses,
          investmentModel: InvestmentModel(
              currentAmount: currentAmount.toStringAsFixed(2),
              investedAmount: investedAmount.toStringAsFixed(2),
              totalReturns: totalReturns.toStringAsFixed(2),
              returnsPercentage: returnsPercentage.toStringAsFixed(2)));
    },
    loading: () => InvestmentSummary.empty(),
    error: (err, stack) {
      // log or handle the error as needed
      return InvestmentSummary.empty();
    },
  );
});
