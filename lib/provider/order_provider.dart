import 'package:eatables_app/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.date,
  });
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productJsonList =
        products.map((product) => product.toJson()).toList();
    return {
      'id': id,
      'amount': amount,
      'products': productJsonList,
      'date': date.toIso8601String(),
      'userId': UserProvider().toJson()
    };
  }
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> products, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            amount: total,
            products: products,
            date: DateTime.now()));
    notifyListeners();
  }

  // List<Map<String, dynamic>> toJson() {
  //   return _orders.map((order) => order.toJson()).toList();
  // }
  Map<String, dynamic> toJson() {
    return _orders[0].toJson();
  }
}
