import 'package:dio/dio.dart';
import 'package:eatables_app/constants.dart';
//
// class OrderHistoryModel {
//   final String item, status, customerName, customerEmail;
//   final int deliverId, orderId, quantity, delivered, tobedelivered;
//   OrderHistoryModel({
//     required this.item,
//     required this.status,
//     required this.customerName,
//     required this.customerEmail,
//     required this.deliverId,
//     required this.orderId,
//     required this.quantity,
//     required this.delivered,
//     required this.tobedelivered,
//   });
// }

class OrderHistoryModel {
  String itemsWithQuantity = "",
      status = "",
      customerName = "",
      customerEmail = "";
  int orderId = 0, delivered = 0, tobedelivered = 0;
  int amount = 0;
  DateTime date = DateTime.now();

  @override
  String toString() {
    return 'OrderHistoryModel{itemsWithQuantity: $itemsWithQuantity, status: $status, customerName: $customerName, customerEmail: $customerEmail, orderId: $orderId, delivered: $delivered, tobedelivered: $tobedelivered, amount: $amount, date: $date}';
  }

  OrderHistoryModel();
}

String setStatus(String preStatus, String Status) {
  if (preStatus == "new order" || Status == "new order") {
    return "new order";
  } else if (preStatus == "partially delivered" ||
      Status == "partially delivered") {
    return "partially delivered";
  }
  return "Delivered";
}

class OrderHistoryList {
  List<OrderHistoryModel> orderHistory = [];
  // List<TempOrderHistoryModel> tempOrderHistory = [];

  Future<List<OrderHistoryModel>> getData() async {
    Dio dio = Dio();
    //TODO : change email get from userProvider
    Response response = await dio.post("$baseURL/order/orderHistory",
        data: {'email': "namanrajani16@gmail.com"});
    var data = response.data as Map<String, dynamic>;
    // print(data.values.toList());
    var orderData = data.values.toList();
    print("orderData=-=-=-=-=-=-=-=-=-");

    print(orderData);
    orderData.forEach((e) {
      // print("e=-=-=-=-=-=-=-=-=-");
      // print(e);
      OrderHistoryModel temp = OrderHistoryModel();
      e.forEach((el) {
        print("el=-=-=-=-=-=-=-=-=-");

        print(el);

        temp.status = setStatus(el['status'], temp.status);
        print("lol");
        temp.itemsWithQuantity += "${el['item']} x ${el['quantity']} ,\n";
        print("lol");

        temp.delivered += el['delivered'] as int;
        print("lol");

        temp.tobedelivered += el['tobedelivered'] as int;
        print("lol");
        temp.customerEmail = el['customerEmail'];
        print("lol");
        temp.customerName = el['customerName'];
        print("lol");
        temp.orderId = el['orderId'] as int;
        print("lol");
        temp.amount += el['AMOUNT'] as int;
        print("lol");
        temp.date = DateTime.fromMillisecondsSinceEpoch(el['orderId'] as int);
      });
      print("temp=-=-=-=-=-=-=-=-=-");
      print(temp);
      orderHistory.add(temp);
    });
    // data.values.forEach((element) {
    print("=-=-=-=-=-=-=-=-=-");
    print(orderHistory);
    // });

    return [...orderHistory];
  }
}
