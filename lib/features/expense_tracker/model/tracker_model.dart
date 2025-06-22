import 'package:budgify/core/local/db_helper.dart';

class FilteredExpModel{
  final String? title;
  final num bal;
  final String? image;
  final List<TrackerModel> allExp;

  FilteredExpModel({
    this.image,
    required this.title,
    required this.bal,
    required this.allExp,
  });
}



class TrackerModel {
  int? id;
  String title;
  String date;
  double? amount;
  int trackerCategory;
  int chooseCategory;
  double percentage;

  TrackerModel({
    this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.trackerCategory,
    required this.chooseCategory,
    required this.percentage,
  });

  factory TrackerModel.fromMap(Map<String, dynamic> map) {
    return TrackerModel(
        id: map[DBHelper.columnTrackerId],
        title: map[DBHelper.columnTrackerTitle],
        date: map[DBHelper.columnTrackerDate],
        amount: map[DBHelper.columnTrackerAmount],
        trackerCategory: map[DBHelper.columnTrackerCategory],
        chooseCategory: map[DBHelper.columnTrackerChooseCategory],
        percentage: map[DBHelper.columnTrackerPercentage] ?? 0.0,
    );
  }

  Map<String,dynamic> toMap() {
    return {
      DBHelper.columnTrackerTitle: title,
      DBHelper.columnTrackerDate: date,
      DBHelper.columnTrackerAmount: amount,
      DBHelper.columnTrackerChooseCategory: chooseCategory,
      DBHelper.columnTrackerCategory: trackerCategory,
      DBHelper.columnTrackerPercentage: percentage,
    };
  }
}
