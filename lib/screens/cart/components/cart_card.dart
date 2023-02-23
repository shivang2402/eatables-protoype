import 'package:eatables_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = context.watch<CartProvider>();
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.memory(cart.product.imageUrl),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                    text: " x${cart.quantity}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
        Column(
          children: [
            IconButton(
                onPressed: () => {cartProvider.changeQuantity(cart.id, true)},
                icon: const Icon(Icons.add)),
            Text("${cart.quantity}"),
            IconButton(
                onPressed: () => {cartProvider.changeQuantity(cart.id, false)},
                icon: const Icon(Icons.remove)),
          ],
        )
      ],
    );
  }
}
