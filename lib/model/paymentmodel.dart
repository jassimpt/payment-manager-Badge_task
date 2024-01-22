import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'paymentmodel.g.dart';

@HiveType(typeId: 1)
class PaymentModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  dynamic amount;
  @HiveField(2)
  String paymentmethod;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  bool paymentcompleted;
  PaymentModel(
      {required this.amount,
      required this.paymentcompleted,
      required this.name,
      required this.paymentmethod,
      required this.time});
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    DateTime time = (json['time'] as Timestamp).toDate();
    return PaymentModel(
        paymentcompleted: json["paymentcompleted"],
        time: time,
        amount: json['amount'],
        name: json['name'],
        paymentmethod: json['paymentmethod']);
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "amount": amount,
      "paymentmethod": paymentmethod,
      "time": time,
      "paymentcompleted": paymentcompleted
    };
  }
}
