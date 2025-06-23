import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../model/tax_summary.dart';
import '../../model/tracker_model.dart';
import '../../utils/expense_type.dart';
import '../../utils/filter_type.dart';
import '../../utils/tax_type.dart';
import 'expense_tracker_notifier.dart';
import 'filter_provider.dart';

// final taxProvider =
// StateProvider<String>((ref) => TaxType.taxLatestFirst.value);

class TaxAsyncNotifier extends AsyncNotifier<String> {
  final prefsHelper = PrefsHelper();

  @override
  Future<String> build() async {
    final saved = await prefsHelper.getStringValue(PrefsKeys.taxFilter);
    return saved ?? TaxType.taxLatestFirst.value;
  }

  Future<void> setFilter(String newValue) async {
    await prefsHelper.setStringValue(PrefsKeys.taxFilter, newValue);
    state = AsyncValue.data(newValue);
  }
}

final taxProvider =
    AsyncNotifierProvider<TaxAsyncNotifier, String>(TaxAsyncNotifier.new);

final filteredTaxProvider = Provider<TaxSummary>((ref) {
  final taxAsync = ref.watch(taxProvider);
  return taxAsync.when(
    data: (filter) {
      final allData = ref.watch(expenseTrackerProvider).trackers;

      List<TrackerModel> filteredList = [];

      double netAmountAfterTax = 0.0;

      /// The portion of the amount on which tax was calculated.
      double taxableAmount = 0.0;

      /// The total tax calculated on the taxable amount.
      double totalTax = 0.0;

      /// The percentage rate used to calculate the tax.
      double taxPercentage = 0.0;

      if (filter == TaxType.taxLatestFirst.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.tax.intValue)
            .toList()
          ..sort((a, b) => parseDate(b.date)
              .compareTo(parseDate(a.date))); // Newest to Oldest
      } else if (filter == TaxType.taxOldestFirst.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.tax.intValue)
            .toList()
          ..sort((a, b) => parseDate(a.date)
              .compareTo(parseDate(b.date))); // Oldest to Newest
      } else if (filter == TaxType.taxHighToLow.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.tax.intValue)
            .toList()
          ..sort((a, b) => b.amount!.compareTo(a.amount!));
      } else if (filter == TaxType.taxLowToHigh.value) {
        filteredList = allData
            .where((tracker) =>
                tracker.trackerCategory == ExpenseType.tax.intValue)
            .toList()
          ..sort((a, b) => a.amount!.compareTo(b.amount!));
      } else {
        filteredList = allData;
      }

      for (var tracker in filteredList) {
        taxableAmount += tracker.amount!;
        totalTax += tracker.amount! * (tracker.percentage / 100);
        taxPercentage += tracker.percentage;
      }
      if (filteredList.isNotEmpty) {
        taxPercentage = taxPercentage / filteredList.length;
      }
      netAmountAfterTax = taxableAmount - totalTax;

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

      return TaxSummary(
        trackerModel: filteredExpenses,
        taxModel: TaxModel(
            netAmountAfterTax: netAmountAfterTax.toStringAsFixed(2),
            taxableAmount: taxableAmount.toStringAsFixed(2),
            totalTax: totalTax.toStringAsFixed(2),
            taxPercentage: taxPercentage.toStringAsFixed(2)),
      );
    },
    loading: () => TaxSummary.empty(),
    error: (err, stack) {
      // log or handle the error as needed
      return TaxSummary.empty();
    },
  );
});
