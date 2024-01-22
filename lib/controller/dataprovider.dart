import 'package:badge_task/controller/baseprovider.dart';
import 'package:badge_task/model/paymentmodel.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:badge_task/service/firebaseservice.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DataController extends ChangeNotifier {
  FirebaseService service = FirebaseService();
  List<VisitorsModel> visitorslist = [];
  List<PaymentModel> paymentslist = [];
  BaseProvider base = BaseProvider();

  void addVisitor({name, sponsorname}) async {
    final visitorsbox = await Hive.openBox<VisitorsModel>("visitors");

    var connectionresult = await Connectivity().checkConnectivity();
    try {
      VisitorsModel visitor =
          VisitorsModel(name: name, sponsorname: sponsorname);
      if (connectionresult == ConnectivityResult.none) {
        visitorsbox.add(visitor);
        visitorslist.add(visitor);
      } else {
        service.addVisitor(visitor, name);
      }
    } catch (e) {
      print(e);
    }
  }

  void addpayment(String amount, String name, String paymentmethod, time,
      bool paymentstatus) async {
    final paymentsbox = await Hive.openBox<PaymentModel>("payments");

    var connectionresult = await Connectivity().checkConnectivity();

    try {
      PaymentModel payments = PaymentModel(
          amount: amount,
          name: name,
          paymentmethod: paymentmethod,
          time: time,
          paymentcompleted: paymentstatus);
      if (connectionresult == ConnectivityResult.none) {
        paymentsbox.add(payments);
        paymentslist.add(payments);
        notifyListeners();
      } else {
        service.addPayment(name, payments);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  List<VisitorsModel> getAllVisitors() {
    try {
      service.firestore.collection("visitors").snapshots().listen((visitor) {
        visitorslist = visitor.docs
            .map((doc) => VisitorsModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
      return visitorslist;
    } catch (e) {
      throw Exception(e);
    }
  }

  List<PaymentModel> getAllPayments() {
    try {
      service.firestore.collection('payments').snapshots().listen((payment) {
        paymentslist = payment.docs
            .map((doc) => PaymentModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
      return paymentslist;
    } catch (e) {
      throw Exception(e);
    }
  }

  fetchDataFromHive() async {
    final visitorsbox = await Hive.openBox<VisitorsModel>("visitors");
    final paymentsbox = await Hive.openBox<PaymentModel>("Payments");
    visitorslist.clear();
    visitorslist = visitorsbox.values.toList();
    paymentslist.clear();
    paymentslist = paymentsbox.values.toList();

    notifyListeners();
  }

  getAllData() async {
    try {
      var connectivityresult = await Connectivity().checkConnectivity();
      if (connectivityresult == ConnectivityResult.none) {
        await fetchDataFromHive();
        notifyListeners();
      } else {
        service.syncDataWithFirebase();
        getAllVisitors();
        getAllPayments();
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void clearData() async {
    final paymentsbox = await Hive.openBox<PaymentModel>("Payments");
    paymentslist.clear();
    paymentsbox.clear();
    var payments = await service.firestore.collection('payments').get();
    for (var doc in payments.docs) {
      await doc.reference.delete();
    }
    notifyListeners();
  }
}
