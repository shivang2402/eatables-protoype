import 'package:dio/dio.dart';
import 'package:eatables_app/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../constants.dart';
import '../../../provider/user_provider.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  var _razorpay = Razorpay();

  var options = {
    'key': razorpayKey,
    'amount': 50000, //in the smallest currency sub-unit.
    'name': 'Acme Corp.',
    'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Fine T-Shirt',
    'timeout': 60, // in seconds
    'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  };
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                const Text("Add voucher code"),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$500",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      Dio dio = Dio();
                      var userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      String url = "$baseURL/razorpay/orderId";

                      Map<String, String> jsonData = {
                        "amount": "500",
                        "email": userProvider.getEmail

                        // add more key-value pairs as needed
                      };

                      try {
                        Response response = await dio.post(url, data: jsonData);
                        print("razorpay -----------------------------------");
                        print(response.data);
                        options = {
                          'key': razorpayId,
                          'amount':
                              "${response.data['amount']}", //in the smallest currency sub-unit.
                          'name': 'Acme Corp.',
                          'order_id':
                              "${response.data['id']}", // Generate order_id using Orders API
                          'description': 'Fine T-Shirt',
                          'timeout': 60, // in seconds
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
