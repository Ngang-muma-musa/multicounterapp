import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  String email = "";
  String uid = "";
  int baseNumber = 0;

  void setUid(String userid) {
    uid = userid;
    notifyListeners();
  }

  void incrementcounter(String userbasenumber) {
    baseNumber = int.parse(userbasenumber);
    notifyListeners();
  }
}
