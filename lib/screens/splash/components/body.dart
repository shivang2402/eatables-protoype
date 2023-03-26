import 'package:eatables_app/constants.dart';
import 'package:eatables_app/screens/splash/components/splash_content.dart';
import 'package:eatables_app/size_config.dart';
import 'package:flutter/material.dart';

import '../../../components/default_button.dart';
import '../../home/home_screen.dart';
import '../../sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Eatables, Let’s Eat!",
      "image": "assets/images/22326.jpg"
    },
    {
      "text": "Order your next meal with ease using our food ordering app. ",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "Browse menus, customize your order, and track order history all in one place.",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        print('hello world ');
                        // Navigator.pushNamed(context, OrderHistory.routeName);

                        // Navigator.pushNamed(context, ProfileScreen.routeName);
                        // Navigator.pushNamed(context, CartScreen.routeName);
                        Navigator.pushNamed(context, HomeScreen.routeName);

                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
