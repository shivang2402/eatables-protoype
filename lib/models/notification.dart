import 'package:dio/dio.dart';

import '../constants.dart';

class notificationModel {
  String itemsWithQuantity = "",
      status = "",
      customerName = "",
      customerEmail = "";
  int orderId = 0, delivered = 0, tobedelivered = 0;
  int amount = 0;
  int otp = 0;
  DateTime date = DateTime.now();

  @override
  String toString() {
    return 'notificationModel{itemsWithQuantity: $itemsWithQuantity, status: $status, customerName: $customerName, customerEmail: $customerEmail, orderId: $orderId, delivered: $delivered, tobedelivered: $tobedelivered, amount: $amount, date: $date}';
  }

  notificationModel();
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

class notificationList {
  List<notificationModel> orderHistory = [];
  // List<TempOrderHistoryModel> tempOrderHistory = [];

  Future<List<notificationModel>> getData(String email) async {
    Dio dio = Dio();
    //TODO : change email get from userProvider
    Response response =
        await dio.post("$baseURL/notify/Notify", data: {"email": email});
    var data = response.data as Map<String, dynamic>;
    print("data=-=-=-=-=-=-=-=-=-");
    print(data);
    var orderData = data.values.toList();
    // print("orderData=-=-=-=-=-=-=-=-=-");
    // print(orderData);
    orderData.forEach((e) {
      print("e=-=-=-=-=-=-=-=-=-");
      print(e);
      notificationModel temp = notificationModel();
      e.forEach((el) {
        print("el=-=-=-=-=-=-=-=-=-");

        print(el['status']);
        temp.otp = el['otp'] as int;
        temp.status = setStatus(el['status'], temp.status);
        temp.itemsWithQuantity += "${el['item']} x ${el['quantity']} ,\n";
        temp.delivered += el['delivered'] as int;
        temp.tobedelivered += el['tobedelivered'] as int;
        temp.customerEmail = el['customerEmail'];
        temp.customerName = el['customerName'];
        temp.orderId = el['orderId'] as int;
        temp.amount += el['AMOUNT'] as int;
        temp.date = DateTime.fromMillisecondsSinceEpoch(el['orderId'] as int);
      });
      // print("temp=-=-=-=-=-=-=-=-=-");
      // print(temp);
      orderHistory.add(temp);
    });
    data.values.forEach((element) {
      // print("=-=-=-=-=-=-=-=-=-");
      // print(orderHistory);
    });

    return [...orderHistory];
  }
}
