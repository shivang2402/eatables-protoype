import 'package:eatables_app/screens/home/components/itemGridView.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'home_header.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // var categories = context.read<Products>().getProductsCategory();

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          const HomeHeader(),
          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: categories.length,
          //     itemBuilder: (_, index) {
          //       return Text("${categories[index]}   ");
          //     },
          //   ),
          // ),
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
