import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Permissao concedida pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationsHandler(messaging);
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print(
        'Permissao concedida provisionariamente pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationsHandler(messaging);
  } else {
    print('Permissão negada pelo usuário');
  }

  runApp(App());
}

void _startPushNotificationsHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken(
    vapidKey: 'BNbkSjo7dMeBxL3D9OLUOOBjioOKiHFa9ueAy64XWXfjf1Y8IHCAV--D4WBZ6vbH8XmJi9bDZB9-G9eXdyZ8Fdw'
  );
  print('TOKEN $token');
  _setPushToken(token);

  //Foreground (quando app esta sendo usado)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Recebi uma mensagem enquanto estava com o app aberto!');
    print('Dados da mensagem: ${message.data}');

    if (message.notification != null) {
      print(
          'A mensagem também coninha uma notifciacao: ${message.notification!.title}, ${message.notification!.body}');
    }
  });

  //Background (app em segundo plano)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Terminated
  var notification = await FirebaseMessaging.instance.getInitialMessage();
  print(notification);
  if (notification != null) {
    if (notification.data['message'].length > 0) {
      showMyDialog(notification.data['message']);
    }
  }
}

void _setPushToken(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? prefsToken = prefs.getString('pushToken');
  bool? prefSent = prefs.getBool('tokenSent');
  print('Token: $prefsToken - Sent? $prefSent');

  if (prefsToken != token || (prefsToken == token && prefSent == false)) {
    print('Enviando o token para o servidor');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? brand;
    String? model;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Rodando no ${androidInfo.model}');
      model = androidInfo.model;
      brand = androidInfo.brand;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Rodando no ${iosInfo.utsname.machine}');
      model = iosInfo.utsname.machine;
      brand = 'Apple';
    }
    Device device = Device(brand: brand, model: model, token: token);
    sendDevice(device);
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev meetups',
      home: EventsScreen(),
      navigatorKey: navigatorKey,
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Mensagem recebida em background: ${message.data}');
  print(
      'Notificacao: ${message.notification!.title}, ${message.notification!.body}');
}

void showMyDialog(String message) {
  Widget okButton = OutlinedButton(
      onPressed: () => Navigator.pop(navigatorKey.currentContext!),
      child: Text('Ok!'));
  AlertDialog alerta = AlertDialog(
    title: Text('Promoção imperdível'),
    content: Text(message),
    actions: [okButton],
  );
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => alerta);
}
