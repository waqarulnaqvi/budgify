
import 'notification_helper.dart';

/// MUST BE a TOP LEVEL FUNCTION — not inside a class.
/// AlarmManager will pass the note ID automatically.
@pragma('vm:entry-point') // REQUIRED for AndroidAlarmManager
void alarmCallback(int id, Map<String, dynamic> params) async {
  print("ALARM TRIGGERED FOR NOTE ID: $id");

  /// Retrieve saved title & body using the ID as key
  final title =  "Reminder Your task is due now!!";
  final body  = params["title"];

  /// Trigger the notification
  await NotificationHelper.showNotification(
    id,
    title,
    body,
  );
}
