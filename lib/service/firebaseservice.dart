import 'package:badge_task/model/paymentmodel.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addVisitor(VisitorsModel visitor, String name) {
    try {
      firestore.collection("visitors").doc(name).set(visitor.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  void addPayment(String name, PaymentModel payments) {
    try {
      firestore.collection('payments').doc(name).set(payments.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
