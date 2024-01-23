import 'dart:io';

import 'package:badge_task/model/paymentmodel.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference firebaseStorage = FirebaseStorage.instance.ref();
  String downloadurl = '';
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
    VisitorsModel? visitors;
    for (var i = 0; i < visitorsbox.length; i++) {
      visitors = visitorsbox.getAt(i);
      await imageAdder(image: File(visitors!.image!));
      VisitorsModel visitor = VisitorsModel(
          image: downloadurl,
          name: visitors.name,
          sponsorname: visitors.sponsorname);
      firestore.collection("visitors").doc(visitors.name).set(visitor.toJson());
    }
    for (var i = 0; i < paymentsbox.length; i++) {
      payments = paymentsbox.getAt(i);
      firestore
          .collection('payments')
          .doc(payments!.name)
          .set(payments.toJson());
    }
  }

  imageAdder({image, name}) async {
    Reference childfolder = firebaseStorage.child('images');
    Reference imageupload = childfolder.child("$image.jpg");
    try {
      await imageupload.putFile(image);
      downloadurl = await imageupload.getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }
}
