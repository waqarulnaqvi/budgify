class DateModel {
  final String startDateFilter;
  final String endDateFilter;
  final String selectedDate;

  DateModel({
    required this.startDateFilter,
    required this.endDateFilter,
    required this.selectedDate,
  });

  DateModel copyWith({
    String? startDateFilter,
    String? endDateFilter,
    String? selectedDate,
  }) {
    return DateModel(
      startDateFilter: startDateFilter ?? this.startDateFilter,
      endDateFilter: endDateFilter ?? this.endDateFilter,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
