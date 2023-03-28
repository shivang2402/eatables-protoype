import 'package:eatables_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/notification.dart';
import 'notification_tile.dart';

class notification extends StatelessWidget {
  const notification({Key? key}) : super(key: key);
  static String routeName = "/notification";
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text(
              "Notifications",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: notificationList().getData(userProvider.getEmail),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data);
          var data;

          if (snapshot.hasData) {
            data = snapshot.data as List<notificationModel>;
          } else {
            data = [];
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return notificationTiles(
                        data: data[index], index: index + 1);
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
