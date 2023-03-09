import 'package:eatables_app/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../provider/products.dart';

class SingleCategoryProductsScreen extends StatefulWidget {
  static String routeName = "/SingleCategoryProductsScreen";

  const SingleCategoryProductsScreen({Key? key}) : super(key: key);

  @override
  State<SingleCategoryProductsScreen> createState() =>
      _SingleCategoryProductsScreen();
}

class _SingleCategoryProductsScreen
    extends State<SingleCategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    String category = arg['category'];
    var categories = context.read<Products>().getCategory(category);

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
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (ctx, index) {
                  print(index);
                  return ProductCard(
                    product: categories[index],
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
