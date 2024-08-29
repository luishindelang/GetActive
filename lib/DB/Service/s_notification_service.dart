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

    await _zonedSchedule(
      0,
      0,
      "Did you forget to enter your daily activities?",
    );

    await _zonedSchedule(
      1,
      1,
      "Did you forget to enter your daily activities again?",
    );

    await _zonedSchedule(
      2,
      2,
      "Have you broken up or why haven't you entered your daily activities yet?",
    );
  }

  tz.TZDateTime _nextInstance(int delay) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 22, 32);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate.add(Duration(days: delay));
  }

  Future<void> _zonedSchedule(int id, int delay, String message) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      "Get Active",
      message,
      _nextInstance(delay),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
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
