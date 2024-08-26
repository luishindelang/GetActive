import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SNotificationService {
  static final SNotificationService _instance =
      SNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final String _channelId = "160794467";
  final String _channelName = "Daily Reminders";

  factory SNotificationService() {
    return _instance;
  }

  SNotificationService._internal();

  Future<void> scheduleDailyNotification() async {
    tz.initializeTimeZones();
    final berlin = tz.getLocation('Europe/Berlin');
    tz.setLocalLocation(berlin);

    await _notificationsPlugin.zonedSchedule(
      0,
      "Get Active",
      "Did you forget to enter your daily activities?",
      _nextInstance(),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime _nextInstance() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 21, 00);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // Future<void> checkPendingNotificationRequests() async {
  //   final List<PendingNotificationRequest> pending =
  //       await _notificationsPlugin.pendingNotificationRequests();
  //   print('${pending.length} pending notification ');

  //   for (var pendingNotification in pending) {
  //     print(pendingNotification.id.toString() +
  //         " " +
  //         (pendingNotification.payload ?? ""));
  //   }
  //   print('NOW ' + tz.TZDateTime.now(tz.local).toString());
  // }
}
