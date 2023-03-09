import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import '../constants.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final Set<Product> _data = {};
  final StreamController<String> _counterController =
      StreamController<String>();
  StreamSink<String> get counterSink => _counterController.sink;
  Stream<String> get counterStream => _counterController.stream;
  List<Product> getCategory(String category) {
    List<Product> res = [];
    _data.forEach((element) {
      if (element.category == category) {
        res.add(element);
      }
    });
    return res;
  }

  List<Product> get data {
    return [..._data.toList()];
  }

  List<String> getProductsCategory() {
    print("getProductsCategory =-=-=-=-=-=-");
    Set<String> temp = {};
    // List<String> temp = [];

    _data.forEach((element) {
      print(element.category);
      temp.add(element.category);
    });
    print(temp);
    return [...temp.toList()];
  }

  List<Product> getStreamData(dynamic str) {
    // print("str1");
    _data.clear();
    var temp = jsonDecode(str + "");
    // print(temp);
    var resMap = temp["data"] as List;
    // print(resMap);
    resMap.forEach((element) {
      // print(element);
      List<int> intList = [
        ...element["image"]["data"].map((e) => int.tryParse(e.toString()) ?? 0)
      ];

      _data.add(Product(
          title: element["title"],
          imageUrl: Uint8List.fromList(intList),
          id: int.tryParse(element["id"].toString()) ?? 0,
          description: element["description"],
          price: double.tryParse(element["price"].toString()) ?? 0,
          category: element['category']));
    });
    return [..._data];
  }

  Stream getStream(IOWebSocketChannel channel) {
    var data = {
      'type': 'getData',
      'data': {'id': 123, 'name': 'John Doe'}
    };
    print(data);

    channel.sink.add(jsonEncode(data));
    var controller = StreamController();
    _data.clear();

    var listener = channel.stream.listen(
      (data) {
        print("websocket data --------------------");
        var temp = jsonDecode(data);
        print(temp);
        var resMap = temp["data"] as List;
        print(resMap);
        resMap.forEach((element) {
          // print(element);
          List<int> intList = [
            ...element["image"]["data"]
                .map((e) => int.tryParse(e.toString()) ?? 0)
          ];

          _data.add(Product(
              title: element["title"],
              imageUrl: Uint8List.fromList(intList),
              id: int.tryParse(element["id"].toString()) ?? 0,
              description: element["description"],
              price: double.tryParse(element["price"].toString()) ?? 0,
              category: element['category']));
        });
      },
      onError: (error) => print(error),
    );
    listener.onDone(() => controller.close());
    listener.onError((error) => controller.addError(error));
    listener.pause();
    print(_data);
    controller.onListen = () {
      listener.resume();
    };

    controller.onCancel = () {
      listener.cancel();
    };
    return controller.stream;
  }

  Future<List<Product>> fetchData() async {
    Dio dio = Dio();
    _data.clear();

    String url = "$baseURL/item/displayItem";
    Response response = await dio.post(url);
    // print(response.data);

    var resMap = await response.data as List;
    for (var element in resMap) {
      // print(element);
      List<int> intList = [
        ...element["image"]["data"].map((e) => int.tryParse(e.toString()) ?? 0)
      ];

      _data.add(Product(
          title: element["title"],
          imageUrl: Uint8List.fromList(intList),
          id: int.tryParse(element["id"].toString()) ?? 0,
          description: element["description"],
          price: double.tryParse(element["price"].toString()) ?? 0,
          category: element['category']));
    }
    print("data");
    print(data);

    return [..._data];
  }

  List<Product> getData(bool favs) {
    fetchData();

    return !favs
        ? [..._data]
        : [..._data.where((element) => element.isFavorite)];
  }

  void changeFavorite(String id) {
    Product prod = _data.firstWhere((element) => element.id == id);
    var index = _data.toList().indexOf(prod);
    _data.elementAt(index).toggleFavoriteStatus();
    // prod.isFavorite = !prod.isFavorite;
    notifyListeners();
  }

  List get favoriteItems {
    return _data.where((prodItem) => prodItem.isFavorite).toList();
  }

  void addData() {
    print("data changes");
    notifyListeners();
  }
}
