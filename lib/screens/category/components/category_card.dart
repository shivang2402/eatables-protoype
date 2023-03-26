import 'package:eatables_app/components/custom_image.dart';
import 'package:flutter/material.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            title: Text(
              text,
            ),
            backgroundColor: Colors.black45,
          ),
          child: GestureDetector(
            onTap: press,
            child: CustomImage(
              searchTerm: text,
            ),
          ),
        ));
  }
}
// return GestureDetector(
// onTap: press,
// child: Container(
// padding: EdgeInsets.all(getProportionateScreenWidth(15)),
// // height: SizeConfig.screenWidth * 0.4,
// // width: SizeConfig.screenWidth * 0.4,
// decoration: BoxDecoration(
// color: const Color(0xFFFFECDF),
// // gradient: kPrimaryGradientColor,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Text(
// text!,
// textAlign: TextAlign.center,
// softWrap: true,
// style: const TextStyle(
// color: kPrimaryColor,
// fontSize: 22,
// ),
// )),
// ),
// );
