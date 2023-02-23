import 'package:eatables_app/provider/cart_provider.dart';
import 'package:eatables_app/provider/order_provider.dart';
import 'package:eatables_app/provider/products.dart';
import 'package:eatables_app/provider/user_provider.dart';
import 'package:eatables_app/routes.dart';
import 'package:eatables_app/screens/splash/splash_screen.dart';
import 'package:eatables_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eatables',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
