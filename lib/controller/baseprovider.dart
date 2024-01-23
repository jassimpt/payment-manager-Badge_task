import 'dart:io';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BaseProvider extends ChangeNotifier {
  bool upiswitch = false;
  bool cashswitch = false;
  bool laterswitch = false;
  String? paymentmethod;
  List alphabets = [];
  int selected = 0;
  String? visitorname;
  ImagePicker imagepicker = ImagePicker();
  File? selectedimage;

  void imageSelecter({required source}) async {
    var image = await imagepicker.pickImage(source: source);
    selectedimage = File(image!.path);
    notifyListeners();
  }

  void valueSetter({value, paymode}) {
    if (paymode == "CASH") {
      cashswitch = value;
      cashswitch == true ? paymentmethod = paymode : paymentmethod = null;
      notifyListeners();
    } else if (paymode == "UPI") {
      upiswitch = value;
      upiswitch == true ? paymentmethod = paymode : paymentmethod = null;
      notifyListeners();
    } else if (paymode == "LATER") {
      laterswitch = value;
      laterswitch == true ? paymentmethod = paymode : paymentmethod = null;
      notifyListeners();
    }
  }

  void alphabetChanger(index) {
    if (selected == index) {
      selected = 0;
      notifyListeners();
    } else {
      selected = index;
      notifyListeners();
    }
  }

  void generateAlphabets(List<VisitorsModel> visitors) {
    Future.delayed(
      Duration.zero,
      () {
        alphabets = visitors
            .map((visitor) => visitor.name[0].toUpperCase())
            .toSet()
            .toList()
          ..sort();
        notifyListeners();
      },
    );
  }
}
