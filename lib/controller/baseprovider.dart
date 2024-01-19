import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool isswitched = false;
  String? paymentmethod;
  void valueSetter({value, paymode}) {
    isswitched = value;
    isswitched == true ? paymentmethod = paymode : paymentmethod = null;
    notifyListeners();
  }
}
