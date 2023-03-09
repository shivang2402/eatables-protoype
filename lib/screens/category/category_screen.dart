import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../provider/products.dart';
import '../single_category/SingleCategoryProducts.dart';
import 'components/category_card.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/categoryScreen";

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var categories = context.read<Products>().getProductsCategory();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Categories"),
        ),
        bottomNavigationBar: const CustomBottomNavBar(
          selectedMenu: MenuState.categories,
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (ctx, index) {
                  print(index);
                  return CategoryCards(
                    text: '${categories[index]}   ',
                    press: () {
                      Navigator.of(context).pushNamed(
                          SingleCategoryProductsScreen.routeName,
                          arguments: {
                            'category': categories[index],
                          });
                    },
                  );
                },
                itemCount: categories.length,
              ),
              // child: ListView.builder(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.horizontal,
              //   itemCount: categories.length,
              //   itemBuilder: (_, index) {
              //     return CategoryCards(
              //       text: '${categories[index]}   ',
              //       press: () {},
              //     );
              //   },
              // ),
            ),
          ],
        ));
  }
}
