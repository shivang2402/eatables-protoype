import 'package:eatables_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: CheckoutCard(
        cart: cart,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();

    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cart.itemCount} items",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
