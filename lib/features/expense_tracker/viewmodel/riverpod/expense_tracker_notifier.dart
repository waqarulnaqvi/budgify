import 'package:budgify/features/expense_tracker/model/date_model.dart';
import 'package:budgify/features/expense_tracker/utils/expense_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/db_helper.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../model/tracker_model.dart';
import '../../model/tracker_summary.dart';

// Date Provider
class DateAsyncNotifier extends AsyncNotifier<DateModel> {
  final prefsHelper = PrefsHelper();

  @override
  Future<DateModel> build() async {
    final saved = await prefsHelper.getStringValue(PrefsKeys.startDate);
    return DateModel(
      startDateFilter: saved ?? formatDate(DateTime.now()),
      endDateFilter: formatDate(DateTime.now()),
      selectedDate: formatDate(DateTime.now()),
    );
  }

  Future<void> selectedDate(String newValue) async {
    state = AsyncValue.data(
      DateModel(
        startDateFilter: state.value?.startDateFilter ?? formatDate(DateTime.now()),
        endDateFilter: state.value?.endDateFilter ?? formatDate(DateTime.now()),
        selectedDate: newValue,
      ),
    );
  }

  Future<void> setBothDateFilter({required String startDate,required String endDate}) async {
    await prefsHelper.setStringValue(PrefsKeys.startDate, startDate);
    state = AsyncValue.data(
      DateModel(
        startDateFilter: startDate,
        endDateFilter: endDate,
        selectedDate: state.value?.selectedDate ?? formatDate(DateTime.now()),
      ),
    );
  }

  Future<void> resetFilter() async {
    state = AsyncValue.data(
      DateModel(
        startDateFilter: formatDate(DateTime.now()),
        endDateFilter:  formatDate(DateTime.now()),
        selectedDate:  formatDate(DateTime.now()),
      ),
    );
  }
}

final dateProvider =
AsyncNotifierProvider<DateAsyncNotifier, DateModel>(
    DateAsyncNotifier.new);



// final dateProvider = StateProvider<DateModel>((ref) {
//   return DateModel(
//     startDateFilter: formatDate(DateTime.now()),
//     // startDateFilter: formatDate(DateTime.now().subtract(Duration(days: 30))),
//     endDateFilter: formatDate(DateTime.now()),
//     selectedDate: formatDate(DateTime.now()),
//   );
// });

// Expense Notifier
class ExpenseTrackerNotifier extends StateNotifier<List<TrackerModel>> {
  ExpenseTrackerNotifier() : super([]);

  bool isLoading = false;
  DBHelper dbHelper = DBHelper();
  Database? database;

  // double totalIncome = 0.0;
  // double totalExpense = 0.0;
  // double totalBalance = 0.0;
  // double totalInvestment = 0.0;
  // double totalTax = 0.0;

  // Asynchronous init method for initializing the state
  Future<void> init() async {
    await getDB();
    await fetchData();
    isLoading = false;
  }

  // Get the database instance
  Future<void> getDB() async {
    database = await dbHelper.getDB();
  }

  Future<void> addData(
      {required String title,
      required String date,
      required double amount,
      required int trackerCategory,
      required int chooseCategory,
      required double percentage}) async {
    bool isValueAdded = await dbHelper.addTrackerData(TrackerModel(
        title: title,
        date: date,
        amount: amount,
        chooseCategory: chooseCategory,
        trackerCategory: trackerCategory,
        percentage: percentage));
    if (isValueAdded) {
      fetchData();
    }
  }

  Future<void> updateData(
      {required int id,
      required String title,
      required String date,
      required double amount,
      required int trackerCategory,
      required int chooseCategory,
      required double percentage}) async {
    bool isValueUpdated = await dbHelper.updateTrackerData(TrackerModel(
        id: id,
        title: title,
        date: date,
        amount: amount,
        trackerCategory: trackerCategory,
        chooseCategory: chooseCategory,
        percentage: percentage));
    if (isValueUpdated) {
      fetchData();
    }
  }

  Future<void> deleteData(int id) async {
    bool isValueDeleted = await dbHelper.deleteTrackerData(id);
    if (isValueDeleted) {
      fetchData();
    }
  }

  // Fetch data from the database and update the state
  Future<void> fetchData() async {
    // double totalIncome = 0.0;
    // double totalExpense = 0.0;
    // double totalInvestment = 0.0;
    // double totalTax = 0.0;

    final List<TrackerModel> list = await dbHelper.fetchTrackerData();
    final List<TrackerModel> filteredList = list.reversed.toList();
    state = filteredList;
  }
}

// Create a provider for the ExpenseTrackerNotifier
final expenseTrackerProviderOriginal =
    StateNotifierProvider<ExpenseTrackerNotifier, List<TrackerModel>>(
  (ref) => ExpenseTrackerNotifier(),
  // (ref) => ExpenseTrackerNotifier()..init(),
);

final expenseTrackerProvider = StateProvider<TrackerSummary>((ref) {
  final wProvider = ref.watch(dateProvider).value;
  final allData = ref.watch(expenseTrackerProviderOriginal);
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double totalInvestment = 0.0;
  double totalTax = 0.0;

  final List<TrackerModel> filteredList;



  if (wProvider!.startDateFilter != wProvider.endDateFilter) {
    DateTime startDate = parseDate(wProvider.startDateFilter!);
    DateTime endDate = parseDate(wProvider.endDateFilter!);
    // print("Start Date: ${wProvider.startDateFilter}");
    //  print("End Date: ${wProvider.endDateFilter}");

    filteredList = allData.where((tracker) {
      DateTime trackerDate = parseDate(tracker.date);
      return trackerDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          trackerDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();

    // print("Filtered List: $filteredList");
  } else {
    filteredList = allData;
  }

  for (var tracker in filteredList) {
    if (tracker.trackerCategory == ExpenseType.expense.intValue) {
      totalExpense += tracker.amount!;
    } else if (tracker.trackerCategory == ExpenseType.investment.intValue) {
      totalInvestment += tracker.amount!;
    } else if (tracker.trackerCategory == ExpenseType.tax.intValue) {
      totalTax += tracker.amount!;
    } else {
      totalIncome += tracker.amount!;
    }
  }

  return TrackerSummary(
    trackers: filteredList,
    trackerCategory: TrackerCategory(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      investment: totalInvestment,
      tax: totalTax,
    ),
  );
});

//nal wProvider = ref.watch(dateProvider);
//   List<TrackerModel> filteredList = [];
//   if (wProvider.startDateFilter != null) {
//   DateTime startDate = parseDate(wProvider.startDateFilter!);
//   DateTime endDate = parseDate(wProvider.endDateFilter!);
//
//   filteredList = allData.where((tracker) {
//     DateTime trackerDate = parseDate(tracker.date);
//     return trackerDate.isAfter(startDate.subtract(Duration(days: 1))) &&
//         trackerDate.isBefore(endDate.add(Duration(days: 1)));
//   }).toList();
//   }

//
// } else {
//   // print("Start Date: ${rProvider.startDateFilter}");
//   // print("End Date: ${rProvider.endDateFilter}");
//   DateTime startDate = parseDate(rProvider.startDateFilter!);
//   // DateTime startDate = DateTime.now().subtract(Duration(days:3));
//   DateTime endDate = parseDate(rProvider.endDateFilter!);
//   filteredList = list.where((tracker) {
//     DateTime trackerDate = parseDate(tracker.date);
//     // return trackerDate.isAfter(startDate) &&
//     //     trackerDate.isBefore(endDate);
//     return trackerDate.isAfter(startDate.subtract(Duration(days: 1))) &&
//         trackerDate.isBefore(endDate.add(Duration(days: 1)));
//   }).toList();
// }

// {
//   ref.listen<DateModel>(dateProvider, (previous, next) {
//     fetchData(); // This will be triggered whenever dateProvider changes
//   });
// }
