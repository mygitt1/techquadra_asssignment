import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Prefrences {
  addDataToLocal(String text) async {
    Map allData = {};
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String jsonString = preferences.getString('data');
    if (jsonString != null) {
      allData = json.decode(jsonString);
      allData['${allData.length + 1}'] = {
        "text": text,
      };
      var jsonToSave = json.encode(allData);
      await preferences.setString('data', jsonToSave).whenComplete(() {
        Fluttertoast.showToast(msg: 'Data Added to Local Storage');
      });
    } else {
      allData["1"] = {
        "text": text,
      };
      String jsonToSave = json.encode(allData);
      await preferences.setString('data', jsonToSave);
    }
  }

  Future<Map<String, dynamic>> getDataFromLocal() async {
    Map<String, dynamic> allData;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final String jsonString = prefs.getString('data');
      if (jsonString != null && jsonString.isNotEmpty) {
        allData = json.decode(jsonString);
        return allData;
      } else {
        return {};
      }
    } catch (e) {
      print('inside catch block');
      return e;
    }
  }
}
