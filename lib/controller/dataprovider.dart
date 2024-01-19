import 'package:badge_task/model/paymentmodel.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:badge_task/service/firebaseservice.dart';
import 'package:flutter/material.dart';

class DataController extends ChangeNotifier {
  FirebaseService service = FirebaseService();
  List<VisitorsModel> visiors = [];
  List<PaymentModel> payments = [];

  void addVisitor({name, sponsorname}) {
    try {
      VisitorsModel visitor =
          VisitorsModel(name: name, sponsorname: sponsorname);
      service.addVisitor(visitor, name);
    } catch (e) {
      throw Exception(e);
    }
  }

  void addpayment(String amount, String name, String paymentmethod) {
    try {
      PaymentModel payments = PaymentModel(
          amount: amount, name: name, paymentmethod: paymentmethod);
      service.addPayment(name, payments);
    } catch (e) {
      throw Exception(e);
    }
  }

  List<VisitorsModel> getAllVisitors() {
    try {
      service.firestore.collection("visitors").snapshots().listen((visitor) {
        visiors = visitor.docs
            .map((doc) => VisitorsModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
      return visiors;
    } catch (e) {
      throw Exception(e);
    }
  }

  List<PaymentModel> getAllPayments() {
    try {
      service.firestore.collection('payments').snapshots().listen((payment) {
        payments = payment.docs
            .map((doc) => PaymentModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
      return payments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
