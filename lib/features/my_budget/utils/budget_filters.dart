/// Defines how budgets should be sorted.
/// `title` = sort alphabetically
/// `datetime` = sort by date/time
enum SortingFilter {
  title("Title"),
  datetime("DateTime");

  final String value;
  const SortingFilter(this.value);

  /// Convert display text → enum (useful for saved prefs).
  static SortingFilter fromValue(String value) =>
      SortingFilter.values.firstWhere(
            (e) => e.value == value,
        orElse: () => SortingFilter.datetime,
      );

  /// Convert index → enum (safe with clamping).
  static SortingFilter fromInt(int index) =>
      SortingFilter.values[index.clamp(0, SortingFilter.values.length - 1)];

  /// Convert display text → index (for storing in prefs/db).
  static int toInt(String sorting) =>
      SortingFilter.values.indexWhere((e) => e.value == sorting);
}

/// Defines the order direction for sorting.
/// `ascending` = A→Z / Oldest first
/// `descending` = Z→A / Newest first
enum OrderFilter {
  ascending("Ascending"),
  descending("Descending");

  final String value;
  const OrderFilter(this.value);

  /// Convert display text → enum.
  static OrderFilter fromValue(String value) =>
      OrderFilter.values.firstWhere(
            (e) => e.value == value,
        orElse: () => OrderFilter.ascending,
      );

  /// Convert index → enum.
  static OrderFilter fromInt(int index) =>
      OrderFilter.values[index.clamp(0, OrderFilter.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String order) =>
      OrderFilter.values.indexWhere((e) => e.value == order);
}

/// Defines UI layout style for budgets.
/// `classic` = normal list
/// `staggered` = masonry-style grid
enum StyleFilter {
  classic("Classic"),
  staggered("Staggered");

  final String value;
  const StyleFilter(this.value);

  /// Convert display text → enum.
  static StyleFilter fromValue(String value) =>
      StyleFilter.values.firstWhere(
            (e) => e.value == value,
        orElse: () => StyleFilter.classic,
      );

  /// Convert index → enum.
  static StyleFilter fromInt(int index) =>
      StyleFilter.values[index.clamp(0, StyleFilter.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String style) =>
      StyleFilter.values.indexWhere((e) => e.value == style);
}


//enum Filter1Type {
//   title,
//   datetime;
//
//   String get value {
//     switch (this) {
//       case Filter1Type.title:
//         return 'Title';
//       case Filter1Type.datetime:
//         return 'DateTime';
//     }
//   }
// }
//
// enum Filter2Type {
//   ascending,
//   descending;
//
//   String get value {
//     switch (this) {
//       case Filter2Type.ascending:
//         return 'Ascending';
//       case Filter2Type.descending:
//         return 'Descending';
//     }
//   }
// }