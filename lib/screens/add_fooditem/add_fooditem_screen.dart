import 'package:flutter/material.dart';

import '../../components/custom_surfix_icon.dart';

class AddFoodItemScreen extends StatefulWidget {
  static String routeName = "/AddFoodItemScreen";

  const AddFoodItemScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: ListView(
          children: [
            buildFoodNameFormField(),
          ],
        ),
      ),
    );
  }

  TextFormField buildFoodNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        return;
      },
      validator: (value) {
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Item Name",
        hintText: "Enter Food item name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: const [
          Text(
            "Add food Item",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
