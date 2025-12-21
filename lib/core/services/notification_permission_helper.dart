import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';

class NotificationPermissionHelper {
  NotificationPermissionHelper._();
  static final NotificationPermissionHelper instance = NotificationPermissionHelper._();

  static const MethodChannel _channel = MethodChannel("exact_alarm_checker");

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  // ─────────────────────────────────────────────────────────────
  // 1️⃣ NORMAL NOTIFICATION PERMISSION (Android 13+)
  // ─────────────────────────────────────────────────────────────
  Future<bool> requestNotificationPermission() async {
    if (!Platform.isAndroid) return true; // iOS auto-handled

    final status = await Permission.notification.status;

    switch (status) {
      case PermissionStatus.granted:
        _logger.i("🔔 Notification permission already granted.");
        return true;

      case PermissionStatus.denied:
        final result = await Permission.notification.request();
        _logger.i("🔔 Notification permission result → granted: ${result.isGranted}");
        return result.isGranted;

      case PermissionStatus.permanentlyDenied:
        _logger.w(
            "⚠️ Notification permission permanently denied. Opening app settings...");
        openAppSettings();
        return false;

      default:
        _logger.w("⚠️ Unknown notification permission state: $status");
        return false;
    }
  }

  // ─────────────────────────────────────────────────────────────
  // 2️⃣ EXACT ALARM PERMISSION CHECK — via Kotlin
  // ─────────────────────────────────────────────────────────────
  Future<bool> isExactAlarmAllowed() async {
    if (!Platform.isAndroid) return true;

    try {
      final allowed = await _channel.invokeMethod<bool>("isExactAlarmAllowed");
      return allowed ?? false;
    } catch (e) {
      _logger.e("❌ Error checking exact alarm permission: $e");
      return false;
    }
  }

  // ─────────────────────────────────────────────────────────────
  // 3️⃣ REQUEST EXACT ALARM PERMISSION (Only if not already allowed)
  // ─────────────────────────────────────────────────────────────
  Future<void> requestExactAlarmPermission() async {
    if (!Platform.isAndroid) return;

    final allowed = await isExactAlarmAllowed();

    if (allowed) {
      _logger.i("⏰ Exact alarm permission already granted.");
      return; // 👉 Do NOT ask again
    }

    _logger.w("⚠️ Exact alarm NOT allowed → Opening system settings...");

    const intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    );

    await intent.launch();
  }

  // ─────────────────────────────────────────────────────────────
  // 4️⃣ CALL THIS ON APP START
  // ─────────────────────────────────────────────────────────────
  Future<void> requestAllPermissions() async {
    _logger.i("🔍 Checking Notification & Exact Alarm Permissions...");

    await requestNotificationPermission();
    await requestExactAlarmPermission();
  }
}
