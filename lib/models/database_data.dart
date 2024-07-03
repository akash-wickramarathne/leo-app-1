import 'package:flutter/foundation.dart';
import 'package:leo_final/Service/database_services.dart';
import 'package:leo_final/models/database.dart';

class databasedata extends ChangeNotifier {
  List<databases> Databases = [];

  void adddata(String datatitle) async {
    databases database = await DatabaseServices.adddata(datatitle, title: '');
    Databases.add(database);
    notifyListeners();
  }
}
