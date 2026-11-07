/// Returns the current date and time in the format:
/// `YYYY/MM/DD | HH:MM AM/PM`
///
/// Example output:
/// `2025/12/03 | 08:45 PM`
///
/// This method:
/// - Gets the current system DateTime
/// - Converts it to `YYYY/MM/DD` format
/// - Converts 24-hour time to 12-hour format
/// - Appends `AM` or `PM`
/// - Returns a fully formatted datetime string
String formatDateTimeNow() {
  // DateTime format
  final List dateTime = DateTime.now().toString().split(".")[0].split(" ");
  dateTime[0] = dateTime[0].replaceAll("-", "/");
  var twelveHoursSystem = int.parse(dateTime[1].substring(0, 2));

  if (twelveHoursSystem == 12) {
    dateTime[1] = "${dateTime[1]} PM";
  } else if (twelveHoursSystem > 12) {
    twelveHoursSystem = twelveHoursSystem - 12;
    dateTime[1] =
    "$twelveHoursSystem${dateTime[1].substring(2, dateTime[1].length)} PM";
  } else {
    dateTime[1] = "${dateTime[1]} AM";
  }

  return "${dateTime[0]} | ${dateTime[1]}";
}
