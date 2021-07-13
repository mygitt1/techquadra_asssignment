import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techquadra_asssignment/model/model.dart';
import 'package:techquadra_asssignment/provider/auth_service.dart';
import 'package:techquadra_asssignment/provider/dataprovider.dart';
import 'package:techquadra_asssignment/widget/list_of_input.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  String location = 'Location';
  String date = 'Date';
  String time = 'Time';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthService>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     provider.logout();
          //   },
          //   child: Text(
          //     'Logout',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListTile(
            leading: CircleAvatar(
              child: Image.network(user.photoURL),
            ),
            title: Text(user.displayName),
            subtitle: Text(user.email),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter what you like',
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        insert(location);
                      },
                      child: Text(location),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        insert(date);
                      },
                      child: Text(date),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        insert(time);
                      },
                      child: Text(time),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Model model;
                    model = Model(text: controller.text);
                    Provider.of<DataProvider>(context, listen: false)
                        .addData(model);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ListOFInput(
                          text: model.text,
                        ),
                      ),
                    );
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
        ],
      ),
    );
  }

  void insert(String txText) {
    var text = controller.text;
    var pos = controller.selection.start;
    controller.value = TextEditingValue(
      text: text.substring(0, pos) + txText + text.substring(pos),
      selection: TextSelection.collapsed(offset: pos + txText.length),
    );
  }
}
