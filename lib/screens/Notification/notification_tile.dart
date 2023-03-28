import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../models/notification.dart';

class notificationTiles extends StatelessWidget {
  final notificationModel data;
  final int index;

  const notificationTiles({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  child: Text("$index"),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      data.customerEmail,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(data.itemsWithQuantity),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy ').format(data.date) +
                          DateFormat.jm().format(data.date),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Amount ${data.amount}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Delivered: ${data.delivered}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "OTP: ${data.otp}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "To be delivered: ${data.tobedelivered}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../constants.dart';
// import '../../models/notification.dart';
//
// class notificationTiles extends StatelessWidget {
//   final notificationModel data;
//   final int index;
//
//   const notificationTiles({
//     Key? key,
//     required this.data,
//     required this.index,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: kPrimaryColor),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildIndexWidget(),
//             VerticalDivider(),
//             _buildDetailsWidget(),
//             VerticalDivider(),
//             _buildDeliveryWidget(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Expanded _buildIndexWidget() {
//     return Expanded(
//       flex: 1,
//       child: Container(
//         padding: const EdgeInsets.all(8.0),
//         child: CircleAvatar(
//           backgroundColor: kPrimaryColor,
//           foregroundColor: Colors.white,
//           child: Text("$index"),
//         ),
//       ),
//     );
//   }
//
//   Expanded _buildDetailsWidget() {
//     return Expanded(
//       flex: 3,
//       child: Container(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               data.customerEmail,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             VerticalDivider(),
//             Text(
//               data.itemsWithQuantity,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Expanded _buildDeliveryWidget() {
//     return Expanded(
//       flex: 2,
//       child: Container(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               "Delivered: ${data.delivered}",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             VerticalDivider(),
//             Text(
//               "OTP: ${data.otp}",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             VerticalDivider(),
//             Text(
//               "To be delivered: ${data.tobedelivered}",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             VerticalDivider(),
//             Text(
//               DateFormat('dd-MM-yyyy ').format(data.date) +
//                   DateFormat.jm().format(data.date),
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             VerticalDivider(),
//             Text(
//               "Amount ${data.amount}",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
