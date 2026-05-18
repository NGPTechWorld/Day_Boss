import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Damascus'));
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);

    // طلب إذن الإشعارات للأندرويد 13+
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final granted = await androidPlugin?.requestNotificationsPermission();
    debugPrint('🔔 Notification permission granted: $granted');
  }

  /// جدولة إشعار
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    final tzTime = tz.TZDateTime.from(
      scheduledTime.add(const Duration(seconds: 5)),
      tz.local,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'القناة الرئيسية',
          channelDescription: 'إشعارات المهام',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    debugPrint("✅ Notification scheduled for: $tzTime");
  }

  /// إلغاء إشعار
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// طباعة كل الإشعارات المجدولة (Debug)
  static Future<void> debugPrintScheduled() async {
    final pending = await _notifications.pendingNotificationRequests();
    debugPrint("📅 إشعارات مجدولة: ${pending.length}");
    for (var n in pending) {
      debugPrint("➡️ ID: ${n.id} | Title: ${n.title} | Body: ${n.body}");
    }
  }
}
