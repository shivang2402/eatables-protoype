import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  int id;
  String title, description;
  Uint8List imageUrl;
  double price;
  bool isFavorite;
  String category;
  Product(
      {required this.title,
      required this.imageUrl,
      required this.id,
      required this.description,
      required this.price,
      required this.category,
      this.isFavorite = false});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
    };
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
