import 'package:eatables_app/screens/Empty/EmptyScreen.dart';
import 'package:eatables_app/screens/Notification/notify.dart';
import 'package:eatables_app/screens/cart/cart_screen.dart';
import 'package:eatables_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:eatables_app/screens/details/details_screen.dart';
import 'package:eatables_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:eatables_app/screens/home/home_screen.dart';
import 'package:eatables_app/screens/login_success/login_success_screen.dart';
import 'package:eatables_app/screens/otp/otp_screen.dart';
import 'package:eatables_app/screens/profile/profile_screen.dart';
import 'package:eatables_app/screens/sign_in/sign_in_screen.dart';
import 'package:eatables_app/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  EmptyScreen.routeName: (context) => const EmptyScreen(),
  Notify.routeName: (context) => const Notify()
};
