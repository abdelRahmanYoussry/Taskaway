// ignore_for_file: depend_on_referenced_packages, unused_import, prefer_const_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../main.dart';
import '../../Presentation/AllTasks.dart';
import 'app_cubit.dart';

class Notications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  intializationNotification() async {
    // configureLocalTimezone();
    final IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/logo');
    Future selectNotification(String? payload, {context}) async {
      if (payload == null) return;
      if (payload != null) {
        debugPrint('notification payload: $payload');
      } else {
        debugPrint('notification payload: $payload');
      }
      await MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => AllTasksScreen()
          // NotifiedPage(label: payload, mylist: AppCubit.get(context).allTasks,)
          ));
    }

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload,
      {context}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  displayNotification() {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id115', 'Algoriza', '',

            // channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'logo',
            showWhen: false,
            playSound: true,
            fullScreenIntent: true,
            color: Colors.red,
            ticker: 'ticker');
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        0, ' New Task has been Added', '12:00 Pm', platformChannelSpecifics,
        payload: ' "${'model' '[' 'title' ']'}|"+"${'model' '[' 'time' ']'}|"');
  }

  scheduleNotification(int hour, int minutes, model) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        model['id'].toInt(),
        model['title'],
        model['note'],
        convertTime(hour, minutes),
        NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel 13',
          'your channel name', '',
          playSound: true,
          icon: 'logo',
          importance: Importance.high,
          priority: Priority.max,
          // channelDescription: 'your channel description'
        )),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${model['title']}|" + "${model['note']}|");
  }

  // Future<void> configureLocalTimezone()async{
  //   tz.initializeTimeZones();
  //   final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(timeZone));
  // }
  tz.TZDateTime convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate;
    }
    return scheduleDate.add(const Duration(days: 1));
  }
}

class LocalNotificationService {
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/logo');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      defaultPresentSound: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: _onDidReceiveLocalNotification
    );

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _localNotificationService.initialize(
      settings,
      // onSelectNotification: onSelectNotification
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint('id $id');
  }

  void onSelectNotification(String? payload) {
    debugPrint('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      '',
      priority: Priority.max,
      // channelDescription: 'description',
      playSound: true,
      icon: 'logo',
      importance: Importance.max,
    );
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();
    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotifications({
    required String title,
    required String body,
    required String payload,
    int? id,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id!, title, body, details,
        payload: payload);
  }

// Future<void> showScheduledNotifications({
//   required String title,
//   required String body,
//   int? id,
//  // required int seconds,
//  required int minutes,
//  // required int hours,
//  // required int days,
// })async{
//
//   final details=await _notificationDetails();
//
//   await _localNotificationService.zonedSchedule(
//       id!,
//       title,
//       body,
//     tz.TZDateTime.from(DateTime.now().add(Duration(minutes: minutes)), tz.local),
//       details,
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//
//   );
//
// }

// Future<void> showNotificationsWithPayLoad({
//   required String title,
//   required String body,
//   int? id,
//  required String payload,
// })async{
//
//   final details=await _notificationDetails();
//   await _localNotificationService.show(id!, title, body, details,payload: payload);
//
//
//
// }

  Future<void> deleteEndTimeNotifications({required int taskId}) async {
    await _localNotificationService.cancel(taskId + 1);

    debugPrint('Task Id ${taskId + 1} has been Deleted EndTime');
  }

  Future<void> deleteStartTimeNotifications({required int taskId}) async {
    await _localNotificationService.cancel(taskId);

    debugPrint('Task Id $taskId has been Deleted Start Time');
  }
// Future<void> pendingNotification() async {
//   var pendingNotificationRequests =
//       await _localNotificationService.pendingNotificationRequests();
//   pendingNotificationRequests.forEach((element) {
//     debugPrint(element.id.toString()+'Pending');
//   });
//
// }

// Future<void> configureLocalTimezone()async{
//   tz.initializeTimeZones();
//   final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZone));
// }

  Future<void> showScheduledNotificationsWithEndDate({
    required String title,
    required String body,
    required int id,
    String? payLoad,
    required DateTime dateTime,
  }) async {
    final details = await _notificationDetails();
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    debugPrint(timeZone + ' time zone End Time');
    tz.setLocalLocation(tz.getLocation(timeZone));
    await _localNotificationService.zonedSchedule(
      id + 1,
      title,
      body,
      payload: payLoad,
      tz.TZDateTime.local(dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    debugPrint(dateTime.toString() + "Notification EndTme");
  }

  // Future<void> showScheduledNotificationsWithAddTaskEndDate({
  //   required String title,
  //   required String body,
  //   required int id,
  //   String ?payLoad,
  //   required DateTime dateTime,
  //
  // })async{
  //   final details=await _notificationDetails();
  //   tz.initializeTimeZones();
  //   final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
  //   debugPrint(timeZone+' time zone EndTime New');
  //   tz.setLocalLocation(tz.getLocation(timeZone));
  //   await _localNotificationService.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     payload: payLoad,
  //     tz.TZDateTime.local(dateTime.year,dateTime.month,dateTime.day,dateTime.hour,dateTime.minute),
  //     details,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime ,
  //
  //   );
  //
  //
  // }
  Future<void> showScheduledNotificationsWithStartDate({
    required String title,
    required String body,
    required int id,
    String? payLoad,
    required DateTime dateTime,
  }) async {
    final details = await _notificationDetails();
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    debugPrint(timeZone + ' time zone Start Time');
    tz.setLocalLocation(tz.getLocation(timeZone));
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      payload: payLoad,
      tz.TZDateTime.local(dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
