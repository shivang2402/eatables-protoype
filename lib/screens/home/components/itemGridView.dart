import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

import '../../../components/product_card.dart';
import '../../../provider/product.dart';
import '../../../provider/products.dart';
import '../../../size_config.dart';

class ItemGridView extends StatelessWidget {
  final bool showOnlyFavorites;
  ItemGridView({Key? key, required this.showOnlyFavorites}) : super(key: key);
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect('ws://10.0.2.2:8080');

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> data = [];
    var data2 = {
      'type': 'getData',
      'data': {'id': 123, 'name': 'John Doe'}
    };
    print(data2);

    channel.sink.add(jsonEncode(data2));
    // final data = productsData.getData(showOnlyFavorites);
    return StreamBuilder(
        // stream: productsData.getStream(channel),
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
          }
          data =
              snapshot.hasData ? productsData.getStreamData(snapshot.data) : [];

          return SizedBox(
            height: (MediaQuery.of(context).size.height -
                    getProportionateScreenWidth(80) -
                    38) *
                0.9,
            //TODO :Change height
            child: snapshot.hasData
                ? GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      print(index);

                      Product dataValue = data[index];
                      return ChangeNotifierProvider.value(
                        value: dataValue,
                        child: ProductCard(
                          product: dataValue,
                        ),
                      );
                    },
                    itemCount: data.length,
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        });
    // return FutureBuilder(
    //     future: productsData.fetchData(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       data = snapshot.hasData ? [...snapshot.data] : [];
    //       return SizedBox(
    //         height: (MediaQuery.of(context).size.height -
    //                 getProportionateScreenWidth(80) -
    //                 38) *
    //             0.9,
    //         //TODO :Change height
    //         child: snapshot.hasData
    //             ? GridView.builder(
    //                 padding: const EdgeInsets.all(10),
    //                 gridDelegate:
    //                     const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 2,
    //                   childAspectRatio: 0.8,
    //                   crossAxisSpacing: 10,
    //                   mainAxisSpacing: 10,
    //                 ),
    //                 itemBuilder: (ctx, index) {
    //                   print(index);
    //
    //                   Product dataValue = data[index];
    //                   return ChangeNotifierProvider.value(
    //                     value: dataValue,
    //                     child: ProductCard(
    //                       product: dataValue,
    //                     ),
    //                   );
    //                 },
    //                 itemCount: data.length,
    //               )
    //             : const Center(child: CircularProgressIndicator()),
    //       );
    //     });
  }
}
