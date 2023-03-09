import 'package:flutter/material.dart';

import '../../models/OrderHistoryModel.dart';
import 'order_history_tile.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);
  static String routeName = "/OrderHistory";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: FutureBuilder(
        future: OrderHistoryList().getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data);
          var data;

          if (snapshot.hasData) {
            data = snapshot.data as List<OrderHistoryModel>;
          } else {
            data = [];
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return OrderHistoryTiles(
                        data: data[index], index: index + 1);
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
