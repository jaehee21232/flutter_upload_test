import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

initNotification(context) async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  //ios에서 권한요청
  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(initializationSettings,
      onSelectNotification: (payload) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Text("알림을 눌렀음")));
  }
      //알림 누를때 함수실행하고 싶으면
      //onSelectNotification: 함수명추가
      );
}

showNotification() async {
  var androidDetails = AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(1, '제목1', '내용1',
      NotificationDetails(android: androidDetails, iOS: iosDetails));
}
