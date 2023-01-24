import 'package:eatables_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:eatables_app/routes.dart';
import 'package:eatables_app/screens/profile/profile_screen.dart';
import 'package:eatables_app/screens/splash/splash_screen.dart';
import 'package:eatables_app/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
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
    );
  }
}
