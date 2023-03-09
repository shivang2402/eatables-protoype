import 'dart:convert';

import 'package:eatables_app/provider/cart_provider.dart';
import 'package:eatables_app/provider/order_provider.dart';
import 'package:eatables_app/provider/products.dart';
import 'package:eatables_app/provider/user_provider.dart';
import 'package:eatables_app/routes.dart';
import 'package:eatables_app/screens/Notification/notify.dart';
import 'package:eatables_app/screens/splash/splash_screen.dart';
import 'package:eatables_app/theme.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final channel1 = WebSocketChannel.connect(
  Uri.parse('ws://10.0.2.2:8080'),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    if (message.notification != null) {
      // Extract notification details and display as a SnackBar
      final snackBar = SnackBar(
        content: Text(message.notification!.title ?? ''),
      );
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
    }
  });

  //background and terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("OnMessageOpenedApp : $message");
    navigatorKey.currentState?.pushNamed(
      Notify.routeName,
      arguments: {"message": json.encode(message.data)},
    );
  });

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    print("OnMessageOpenedApp11 : $message");

    if (message != null) {
      navigatorKey.currentState?.pushNamed(
        Notify.routeName,
        arguments: {"message": json.encode(message.data)},
      );
    }
  });

  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  FirebaseMessaging.instance.getToken().then((value) async {
    print("getToken : $value");
    Dio dio = Dio();
    var msg1 = {
      'fcm_token': "$value",
    };
    Orders.fcm_token = value!;
    print(msg1);
    var res = jsonEncode(msg1);
    print(res);

    print("f1 -------------------------------");
    var response = await dio.post('$baseURL/api/send-notifications', data: res);
    print("response --------------------");
    print(response);

    print("kkkkkkkkkkkkkkk");
    var msg = {'type': "sendToken", 'data': "$value"};
    print(msg);
    print(jsonEncode(msg));

    // send the selected items to the backend
    channel1.sink.add(jsonEncode(msg));
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler : $message");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
      navigatorKey: navigatorKey,
    );
  }
}
