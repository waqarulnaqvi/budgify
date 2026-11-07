import 'dart:io';
import 'package:budgify/features/expense_tracker/model/tracker_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../features/my_budget/model/my_budget_model.dart';

class DBHelper {
  ///Table 1:
  static const String trackerTableName = "tracker";
  static const String columnTrackerId = "t_id";
  static const String columnTrackerTitle = "t_title";
  static const String columnTrackerDate = "t_date";
  static const String columnTrackerAmount = "t_amount";
  static const String columnTrackerCategory = "t_category";
  static const String columnTrackerPercentage = "t_percentage";
  static const String columnTrackerChooseCategory = "t_choose_category";

  ///Table 2:
  // static const String investmentTableName = "emi_loans";
  // static const String columnInvestmentId = "el_id";
  // static const String columnInvestmentTitle = "el_title";
  // static const String columnInvestmentDate = "el_date";

  ///Table 3:
  static const String myBudgetTableName = "my_budget";
  static const String columnMyBudgetId = "mb_id";
  static const String columnMyBudgetTitle = "mb_title";
  static const String columnMyBudgetDate = "mb_date";
  static const String columnMyBudgetDescription = "mb_description";
  static const String columnMyBudgetColor = "mb_color";

  // Private constructor
  DBHelper._private();

  // Singleton instance
  static final DBHelper _instance = DBHelper._private();

  // Factory constructor
  factory DBHelper() => _instance;

  Database? _myDB;

  Future<Database> getDB() async {
    return _myDB ??= await openDB();
  }

  Future<Database> openDB() async {
    Directory myDir = await getApplicationDocumentsDirectory();
    String dbPath = join(myDir.path, "expenseT.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $trackerTableName (
            $columnTrackerId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTrackerTitle TEXT,
            $columnTrackerDate TEXT,
            $columnTrackerAmount REAL,
            $columnTrackerCategory INTEGER,
            $columnTrackerChooseCategory INTEGER,
            $columnTrackerPercentage REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE $myBudgetTableName (
            $columnMyBudgetId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnMyBudgetTitle TEXT,
            $columnMyBudgetDate TEXT,
            $columnMyBudgetDescription TEXT,
            $columnMyBudgetColor INTEGER
          )
        ''');

        // await db.insert(trackerTableName, {
        //   columnTrackerTitle: "Sample Income",
        //   columnTrackerDate: DateTime.now().toString().split(" ")[0],
        //   columnTrackerAmount: 2334.0,
        //   columnTrackerCategory: 0
        // });
        //
        // await db.insert(trackerTableName, {
        //   columnTrackerTitle: "Sample Expense",
        //   columnTrackerDate: DateTime.now().toString().split(" ")[0],
        //   columnTrackerAmount: 23232.0,
        //   columnTrackerCategory: 1
        // });
      },
    );
  }

  /// Table 1:
  /// Add Tracker Data
  Future<bool> addTrackerData(TrackerModel tracker) async {
    try {
      Database mDB = await getDB();
      int rowsAffected = await mDB.insert(trackerTableName, tracker.toMap());
      return rowsAffected > 0;
    } catch (e) {
      if (kDebugMode) {
        print("Error in adding data: $e");
      }
      return false;
    }
  }
  /// Fetch Tracker Data
  Future<List<TrackerModel>> fetchTrackerData() async {
    try {
      Database mDB = await getDB();
      List<Map<String, dynamic>> trackerData =
          await mDB.query(trackerTableName);
      return trackerData.map((e) => TrackerModel.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error in fetching data: $e");
      }
      return [];
    }
  }
  /// Update Tracker Data
  Future<bool> updateTrackerData(TrackerModel tracker) async {
    try {
      Database mDB = await getDB();
      int rowsAffected = await mDB.update(trackerTableName, tracker.toMap(),
          where: "$columnTrackerId = ?", whereArgs: [tracker.id]);
      return rowsAffected > 0;
    } catch (e) {
      if (kDebugMode) {
        print("Error in updating data: $e");
      }
      return false;
    }
  }
  /// Delete Tracker Data
  Future<bool> deleteTrackerData(int id) async {
    try {
      Database mDB = await getDB();
      int rowsAffected = await mDB.delete(trackerTableName,
          where: "$columnTrackerId = ?", whereArgs: [id]);
      return rowsAffected > 0;
    } catch (e) {
      if (kDebugMode) {
        print("Error in deleting data: $e");
      }
      return false;
    }
  }

  /// Table 3:
 /// Add My Budget Data
  Future<bool> addMyBudgetData(MyBudgetModel myBudget) async {
    try {
      Database mDB = await getDB();
      int rowsAffected =
          await mDB.insert(myBudgetTableName, myBudget.toMap());
      return rowsAffected > 0;
    } catch (e) {
      if (kDebugMode) {
        print("Error in adding data: $e");
      }
      return false;
    }
  }
  /// Fetch My Budget Data
  Future<List<MyBudgetModel>> fetchMyBudgetData() async {
    try {
      Database mDB = await getDB();
      List<Map<String, dynamic>> myBudgetData =
          await mDB.query(myBudgetTableName);
      // print("myBudgetData: $myBudgetData");
      // print(myBudgetData.map((e) => MyBudgetModel.fromMap(e)).toList());
      return myBudgetData.map((e) => MyBudgetModel.fromMap(e)).toList();

    } catch (e) {
      if (kDebugMode) {
        print("Error in fetching data: $e");
      }
      return [];
    }
  }

  Future<MyBudgetModel?> getBudgetById(int id) async {
    final db = await getDB();
    final result = await db.query(
      myBudgetTableName,
      where: "$columnMyBudgetId = ?",
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return MyBudgetModel.fromMap(result.first);
    }
    return null;
  }


  /// Update My Budget Data
  /// only update if no change
  /// ignore date while comparing
  Future<bool> updateMyBudgetData(MyBudgetModel myBudget) async {
    try {
      Database mDB = await getDB();

      final oldItem = await getBudgetById(myBudget.id!);

      if (oldItem == null) return false; // Safety check

      // date intentionally NOT compared
      final bool noChanges =
          oldItem.title == myBudget.title &&
              oldItem.description == myBudget.description &&
              oldItem.color == myBudget.color;

      // 3. If nothing changed → do nothing
      if (noChanges) {
        return false; // ⛔ Stop here — don't update DB
      }

      int rowsAffected = await mDB.update(myBudgetTableName, myBudget.toMap(),
          where: "$columnMyBudgetId = ?", whereArgs: [myBudget.id]);
      return rowsAffected > 0;
    } catch (e) {
      if (kDebugMode) {
        print("Error in updating data: $e");
      }
      return false;
    }
  }
  /// Delete My Budget Data
  Future<bool> deleteMyBudgetData(int id) async {
    try {
      Database mDB = await getDB();
      int rowsAffected = await mDB.delete(myBudgetTableName,
          where: "$columnMyBudgetId = ?", whereArgs: [id]);
      return rowsAffected > 0;
    } catch (e) {
      if (kDebugMode) {
        print("Error in deleting data: $e");
      }
      return false;
    }
  }

}



// import 'package:hive/hive.dart';
//
// class HiveDatabase {
//   HiveDatabase._privateConstructor();
//   static final HiveDatabase _instance = HiveDatabase._privateConstructor();
//
//   factory HiveDatabase() {
//     return _instance;
//   }
//
//   static const String _boxName = 'app_data';
//   static const String allTransactionFilterBox = 'all_transaction_box';
//   static const String startDateBox = 'start_date_box';
//   static const String currentCurrencyBox = 'current_currency_box';
//   static const String investmentFilterBox = 'investment_filter_box';
//   static const String taxFilterBox = 'tax_filter_box';
//
//   Box<dynamic>? _box;
//
//   // /// get the box
//   // Box<dynamic>? get box => _box;
//
//
//   /// Initialize the box
//   Future<Box<dynamic>> init() async {
//     _box ??= await Hive.openBox(_boxName);
//     return _box!;
//   }
//
//   /// Put data into the box
//   Future<void> put(String key, dynamic value) async {
//     Box<dynamic> box = await init();
//     box.put(key, value);
//   }
//
//   /// Get data from the box
//   Future<void> getValue(String key) async {
//     Box<dynamic> box = await init();
//     return box.get(key);
//   }
//
//
//   /// Delete all the key-value pairs in the box
//   Future<void> clear() async {
//     await _box?.clear();
//   }
//
//
//   ///  Closes the box and removes it from memory.
//   Future<void> close() async {
//     await _box?.close();
//     _box = null;
//   }
// }
