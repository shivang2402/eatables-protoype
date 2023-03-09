import 'package:eatables_app/screens/splash/components/body.dart';
import 'package:eatables_app/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    // context.read<Products>().fetchData();
    return const Scaffold(
      body: Body(),
    );
  }
}
