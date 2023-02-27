import 'package:eatables_app/screens/home/components/itemGridView.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          const HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
          ItemGridView(showOnlyFavorites: false),
          // SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),

      // child: SingleChildScrollView(
      // child: Column(
      //   children: [
      //     SizedBox(height: getProportionateScreenHeight(20)),
      //     HomeHeader(),
      //     SizedBox(height: getProportionateScreenWidth(10)),
      //     DiscountBanner(),
      //     Categories(),
      //     SpecialOffers(),
      //     SizedBox(height: getProportionateScreenWidth(30)),
      //     PopularProducts(),
      //     SizedBox(height: getProportionateScreenWidth(30)),
      //   ],
      // ),
      // ),
    );
  }
}
