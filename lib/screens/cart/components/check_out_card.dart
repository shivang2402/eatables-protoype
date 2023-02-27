import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eatables_app/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:web_socket_channel/io.dart';

import '../../../constants.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  final CartProvider cart;
  const CheckoutCard({Key? key, required this.cart}) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  final _razorpay = Razorpay();
  var channel = IOWebSocketChannel.connect('ws://10.0.2.2:8080');
  var options = {
    'key': razorpayKey,
    'amount': 50000, //in the smallest currency sub-unit.
    'name': 'Acme Corp.',
    'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Fine T-Shirt',
    'timeout': 60, // in seconds
    'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  };

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    widget.cart.clear();
    Dio dio = Dio();
    String url = "$baseURL/razorpay/verification/user";
    Map<String, dynamic> jsonData = {
      "status": true,
      "oid": options["order_id"]

      // add more key-value pairs as needed
    };
    Response res = await dio.post(url, data: jsonData);
    print("success");
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("error");

    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();
    Orders orders = context.watch<Orders>();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$${widget.cart.totalAmount}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      //TODO : send order data
                      orders.addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      var msg = {
                        'type': "sendOrder",
                        'data': orders.toJson(),
                      };
                      channel.sink.add(jsonEncode(msg));
                      Dio dio = Dio();
                      var userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      String url = "$baseURL/razorpay/orderId";

                      Map<String, String> jsonData = {
                        "amount": "${widget.cart.totalAmount}",
                        "email": userProvider.getEmail

                        // add more key-value pairs as needed
                      };

                      try {
                        Response response = await dio.post(url, data: jsonData);
                        print("razorpay -----------------------------------");
                        print(response.data);
                        options = {
                          'key': razorpayId,
                          'amount': "${response.data['amount']}",
                          //in the smallest currency sub-unit.
                          'name': 'Eatables ',
                          'order_id': "${response.data['id']}",
                          // Generate order_id using Orders API
                          'description': jsonEncode(msg),
                          'timeout': 180,
                          // in seconds
                          'prefill': {
                            'contact': userProvider.getContact,
                            'email': userProvider.getEmail
                          }
                        };
                        _razorpay.open(options);
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
