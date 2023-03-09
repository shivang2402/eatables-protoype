import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/OrderHistoryModel.dart';

class OrderHistoryTiles extends StatelessWidget {
  final OrderHistoryModel data;
  final int index;
  const OrderHistoryTiles({Key? key, required this.data, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: const Border.symmetric(
            horizontal: BorderSide(color: kPrimaryColor)),
        leading: CircleAvatar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          child: Text("$index"),
        ),
        title: Text(data.itemsWithQuantity),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(DateFormat('dd-MM-yyyy ').format(data.date) +
                DateFormat.jm().format(data.date)),
            Text("Amount ${data.amount}"),
          ],
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "delivered ${data.delivered}",
              textAlign: TextAlign.left,
            ),
            Text("tobedelivered ${data.tobedelivered}"),
          ],
        ),
      ),
    );
  }
}
