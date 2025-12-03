import 'dart:ui';
import 'package:budgify/features/my_budget/model/my_budget_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/local/db_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../utils/budget_filters.dart';
part 'my_budget_state.dart';

class MyBudgetNotifier extends StateNotifier<MyBudgetState> {
  MyBudgetNotifier() : super(MyBudgetState());
  DBHelper dbHelper = DBHelper();
  Database? database;

  ///Database
  Future<void> init() async {
    try {
      state = state.copyWith(isLoading: true);

      await getDB();
      await fetchData();

    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // Get the database instance
  Future<void> getDB() async {
    database = await dbHelper.getDB();
  }

  Future<void> addData(
      {required String title,
      required String date,
      required Color color,
      // required int colorCode,
      required String description}) async {
    bool isValueAdded = await dbHelper.addMyBudgetData(MyBudgetModel(
        title: title, date: date, description: description, color: color));
    // print("isValueAdded");
    // print(isValueAdded);
    if (isValueAdded) {
      fetchData();
    }
  }

  Future<void> updateData(
      {required int id,
      required String title,
      required Color color,
      required String date,
      // required int colorCode,
      required String description}) async {
    bool isValueAdded = await dbHelper.updateMyBudgetData(MyBudgetModel(
        id: id,
        title: title,
        date: date,
        description: description,
        color: color));
    if (isValueAdded) {
      fetchData();
    }
  }

  Future<void> deleteData(int id) async {
    bool isValueAdded = await dbHelper.deleteMyBudgetData(id);
    if (isValueAdded) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    List<MyBudgetModel> myBudgetList = await dbHelper.fetchMyBudgetData();
    state = state.copyWith(myBudgetList: myBudgetList);
    ///Fetching the already set filter
    applyFilters();
  }


  ///Filters

  void setSelectedColor(Color color) {
    state = state.copyWith(selectedColor: color);
  }


  void setSortingFilter(String value) {
    state = state.copyWith(
      sortingFilter: SortingFilter.fromValue(value),
    );
    applyFilters();

  }

  void setOrderFilter(String value) {
    state = state.copyWith(
      orderFilter: OrderFilter.fromValue(value),
    );
    applyFilters();
  }

  void setStyleFilter(String value) {
    state = state.copyWith(
      styleFilter: StyleFilter.fromValue(value),
    );
  }

  Future<void> toggleFilter() async{
    state =state.copyWith(isShowFilter: !state.isShowFilter);
  }

  void applyFilters({
    bool applySorting = true,
    bool applyOrdering = true,
  }) {
    if (state.myBudgetList.isEmpty) return;

    List<MyBudgetModel> notes = List.from(state.myBudgetList);

    /// Apply Sorting
    if (applySorting) {
      if (state.sortingFilter == SortingFilter.title) {
        notes.sort(
              (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
      } else {
        notes.sort((a, b) => a.date.compareTo(b.date));
      }
    }

    /// Apply Order
    if (applyOrdering) {
      if (state.orderFilter == OrderFilter.descending) {
        notes = notes.reversed.toList();
      }else{
        notes =notes.toList();
      }
    }

    state = state.copyWith(myBudgetList: notes);
  }

}

final myBudgetProvider =
    StateNotifierProvider<MyBudgetNotifier, MyBudgetState>(
  (ref) => MyBudgetNotifier(),
);



// final filteredMyBudgetProvider = StateProvider<List<MyBudgetModel>>((ref) {
//   final myBudget = ref.watch(myBudgetProvider);
//   final budgetFilters = ref.watch(budgetFilterProvider);
//   final filter1 = budgetFilters.filter1;
//   final filter2 = budgetFilters.filter2;
//   List<MyBudgetModel> filteredList = [...myBudget.myBudgetList];
//
//   ///Filter by date
//   if (filter1 == Filter1Type.datetime.value) {
//     ///Filter by date ascending
//     if (filter2 == Filter2Type.ascending.value) {
//       filteredList.sort((a, b) => getDateTimeFromString(b.date)
//           .compareTo(getDateTimeFromString(a.date)));
//     }
//     ///Filter by date descending
//     else {
//       filteredList.sort((a, b) => getDateTimeFromString(a.date)
//           .compareTo(getDateTimeFromString(b.date)));
//     }
//   }
//
//   ///Filter by title
//   else {
//     ///Filter by title ascending
//     if (filter2 == Filter2Type.ascending.value) {
//       filteredList.sort((a, b) => a.title.compareTo(b.title));
//     }
//
//     ///Filter by title descending
//     else {
//       filteredList.sort((a, b) => b.title.compareTo(a.title));
//     }
//   }
//
//   return filteredList;
// });


// import 'dart:ui';
// import 'package:budgify/core/theme/app_colors.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// var selectedColorProvider = StateProvider<Color>((ref) => AppColors.lightGreen);
//



//If the value constantly changes at the runtime.
//provider is used when the value is going to change at the runtime.
//value does not override at runtime value will be changed.
//mutable
// final budgetFilterProvider = StateProvider<BudgetFilterModel>((ref) =>
//     BudgetFilterModel(
//       filter1: Filter1Type.datetime.value,
//       filter2: Filter2Type.ascending.value,
//     ));


//immutable
// provider is used when the value is not going to change at the runtime.
// can be used for static data.
// override the value
//If value does not change at the runtime.
// var budgetFilterProvider = Provider<BudgetFilterModel>((ref) =>
//     BudgetFilterModel(
//         filter1: Filter1Type.title.value,
//         filter2: Filter2Type.ascending.value));
