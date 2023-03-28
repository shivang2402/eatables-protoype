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
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              leading: CircleAvatar(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                child: Text("$index"),
              ),
              title: Text(
                data.itemsWithQuantity,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Delivered ${data.delivered}, To be delivered ${data.tobedelivered}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd MMM yyyy ').format(data.date) +
                        DateFormat.jm().format(data.date),
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Amount ${data.amount}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
