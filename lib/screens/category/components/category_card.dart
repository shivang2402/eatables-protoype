import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(15)),
        // height: SizeConfig.screenWidth * 0.4,
        // width: SizeConfig.screenWidth * 0.4,
        decoration: BoxDecoration(
          color: const Color(0xFFFFECDF),
          // gradient: kPrimaryGradientColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          text!,
          textAlign: TextAlign.center,
          softWrap: true,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 22,
          ),
        )),
      ),
    );
  }
}
