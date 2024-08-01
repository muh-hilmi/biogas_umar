import 'dart:ui';

import 'package:biogas_umar/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';

class NotificationService {
  static RxBool firstLaunchApp = true.obs;

  static Future<void> initializeNotif() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    InitializationSettings initializationSettings =
        const InitializationSettings(android: androidInitializationSettings);

    await requestPermission(flutterLocalNotificationsPlugin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: getResponNotif);

    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    await service.startService();
  }

  static getResponNotif(NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
      debugPrint("GET NOTIF RESPONSE ${notificationResponse.payload}");
    }
  }

  static Future<void> requestPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (e) {
      debugPrint("ERROR FROM REQUEST NOTIF $e");
    }
  }

  static Future<void> showNotif(
    int numberOfRepeats,
    String title,
    String body,
  ) async {
    List<int> vibrationPattern = [500, 500];

    // Duplicate the pattern for the specified number of repeats
    List<int> extendedPattern = List<int>.generate(
      numberOfRepeats * vibrationPattern.length,
      (index) => vibrationPattern[index % vibrationPattern.length],
    );
    Vibration.vibrate(duration: 0, pattern: extendedPattern);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      '1111',
      'Notifikasi',
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails);
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    // panggil fungsi service notifikasi
    notificationService();
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    return false;
  }

  static void notificationService() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseDatabase.instance.setPersistenceEnabled(true);

    listenHistory();
  }

  static void listenHistory() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("/History");
    ref.onValue.listen((event) async {
      var data = event.snapshot.value as Map<dynamic, dynamic>;

      // Ambil tanggal hari ini dalam format yang sesuai dengan key di database

      String today = DateFormat('dd MM yyyy').format(DateTime.now());
      // print(data);
      // Filter data untuk mengambil entri dari hari ini
      var todayEntries = data.entries
          .where((entry) => entry.key.startsWith(' $today at'))
          .toList();

      if (todayEntries.isNotEmpty) {
        // Ambil entri terakhir berdasarkan waktu
        var lastEntry =
            todayEntries.reduce((a, b) => a.key.compareTo(b.key) > 0 ? a : b);
        var lastData = lastEntry.value;

        // print(lastData);

        // Ambil nilai sensor dari data terbaru
        double suhu = (lastData['Suhu'] is int)
            ? (lastData['Suhu'] as int).toDouble()
            : lastData['Suhu'] as double;
        double tekanan = (lastData['Tekanan'] is int)
            ? (lastData['Tekanan'] as int).toDouble()
            : lastData['Tekanan'] as double;
        double gasMetana = (lastData['Gas_Metana'] is int)
            ? (lastData['Gas_Metana'] as int).toDouble()
            : lastData['Gas_Metana'] as double;
        double ph = (lastData['PH'] is int)
            ? (lastData['PH'] as int).toDouble()
            : lastData['PH'] as double;

        // Logika untuk mengecek kondisi dan menampilkan notifikasi
        if ((suhu < 25.0 || suhu > 40.0) ||
            tekanan > 1000000 ||
            gasMetana > 10000 ||
            (ph < 6.7 || ph > 7.5)) {
          if (firstLaunchApp.isFalse) {
            NotificationService.showNotif(5, 'Warning!',
                "Nilai sensor tidak ideal: Suhu: $suhu, Tekanan: $tekanan, Gas Metana: $gasMetana, pH: $ph. Silahkan periksa.");
          }
        }
      } else {
        print("Tidak ada data untuk tanggal $today");
      }

      firstLaunchApp.value = false;
    });
  }
}
