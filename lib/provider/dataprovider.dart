import 'package:flutter/cupertino.dart';
import 'package:techquadra_asssignment/model/model.dart';
import 'package:techquadra_asssignment/service/prefrence.dart';

class DataProvider extends ChangeNotifier {
  Prefrences prefrences = Prefrences();
  List<Model> listOfModel = [];

  addData(Model model) {
    listOfModel.add(model);
    prefrences.addDataToLocal(model.text);
  }
}
