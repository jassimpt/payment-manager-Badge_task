import 'package:badge_task/model/paymentmodel.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addVisitor(VisitorsModel visitor, String name) async {
    try {
      firestore.collection("visitors").doc(name).set(visitor.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  void addPayment(String name, PaymentModel payments) async {
    try {
      firestore.collection('payments').doc(name).set(payments.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  syncDataWithFirebase() async {
    final visitorsbox = await Hive.openBox<VisitorsModel>("visitors");
    final paymentsbox = await Hive.openBox<PaymentModel>("Payments");
    PaymentModel? payments;
    VisitorsModel? visitor;
    for (var i = 0; i < visitorsbox.length; i++) {
      visitor = visitorsbox.getAt(i);
      firestore.collection("visitors").doc(visitor!.name).set(visitor.toJson());
    }
    for (var i = 0; i < paymentsbox.length; i++) {
      payments = paymentsbox.getAt(i);
      firestore
          .collection('payments')
          .doc(payments!.name)
          .set(payments.toJson());
    }
  }
}
