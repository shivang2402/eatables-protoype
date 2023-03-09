import 'package:eatables_app/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'cart_provider.dart';

class OrderItem {
  final String fcm_token;
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  OrderItem({
    required this.fcm_token,
    required this.id,
    required this.amount,
    required this.products,
    required this.date,
  });
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productJsonList =
        products.map((product) => product.toJson()).toList();
    return {
      'fcm_token': fcm_token,
      'id': id,
      'amount': amount,
      'products': productJsonList,
      'date': date.toIso8601String(),
      'userId': UserProvider().toJson()
    };
  }
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  static String fcm_token = '';
  addOrder(List<CartItem> products, double total) {
    print("LlLllLlLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    print(fcm_token);
    print("LlLllLlLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");

    _orders.insert(
        0,
        OrderItem(
<<<<<<< HEAD
          id: DateTime.now().toString(),
          amount: total,
          products: products,
          date: DateTime.now(),
          fcm_token: fcm_token,
        ));
    notifyListeners();
  }

  setfcm_token(String token) {
    fcm_token = token;

=======
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            amount: total,
            products: products,
            date: DateTime.now()));
>>>>>>> 0ab0e612eb1affeb45477a69e5af7f2b32e99c0b
    notifyListeners();
  }

  // List<Map<String, dynamic>> toJson() {
  //   return _orders.map((order) => order.toJson()).toList();
  // }
  Map<String, dynamic> toJson() {
    return _orders[0].toJson();
  }
}
