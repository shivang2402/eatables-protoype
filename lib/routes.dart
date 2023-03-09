import 'package:eatables_app/screens/Empty/EmptyScreen.dart';
import 'package:eatables_app/screens/Notification/notify.dart';
import 'package:eatables_app/screens/cart/cart_screen.dart';
import 'package:eatables_app/screens/category/category_screen.dart';
import 'package:eatables_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:eatables_app/screens/details/details_screen.dart';
import 'package:eatables_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:eatables_app/screens/forgot_password/set_password_screen.dart';
import 'package:eatables_app/screens/history/order_history.dart';
import 'package:eatables_app/screens/home/home_screen.dart';
import 'package:eatables_app/screens/login_success/login_success_screen.dart';
import 'package:eatables_app/screens/otp/otp_screen.dart';
import 'package:eatables_app/screens/profile/profile_screen.dart';
import 'package:eatables_app/screens/sign_in/sign_in_screen.dart';
import 'package:eatables_app/screens/single_category/SingleCategoryProducts.dart';
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
<<<<<<< HEAD
  EmptyScreen.routeName: (context) => const EmptyScreen(),
  Notify.routeName: (context) => const Notify()
=======
  SetPasswordScreen.routeName: (context) => SetPasswordScreen(),
  CategoryScreen.routeName: (context) => CategoryScreen(),
  SingleCategoryProductsScreen.routeName: (context) =>
      SingleCategoryProductsScreen(),
  OrderHistory.routeName: (context) => OrderHistory(),
>>>>>>> 0ab0e612eb1affeb45477a69e5af7f2b32e99c0b
};
