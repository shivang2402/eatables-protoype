import 'package:flutter/material.dart';

import '../provider/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.title,
      'quantity': quantity,
      'price': price,
    };
  }
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int getQuantity(String id) {
    int count = 0;
    for (var k in _items.keys) {
      if (k == id) {
        count = _items[k]!.quantity;
      }
    }
    return count;
  }

  double get totalAmount {
    double amount = 0;
    for (var i in _items.keys) {
      amount += _items[i]!.price * _items[i]!.quantity;
    }
    return amount;
  }

  int get itemCount {
    return _items.length;
  }

  void removeItem(
    String productId,
  ) {
    _items.remove(productId);

    notifyListeners();
  }

  void changeQuantity(String productId, bool add) {
    if (add) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          product: existingCartItem.product,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          product: existingCartItem.product,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
      if (_items[productId]!.quantity <= 0) {
        removeItem(productId);
      }
    }
    notifyListeners();
  }

  void addItem(
    String productId,
    double price,
    Product product,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          product: existingCartItem.product,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: product.id.toString(),
          product: product,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  clear() {
    _items.clear();
    notifyListeners();
  }
}
