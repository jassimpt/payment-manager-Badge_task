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
  PaymentModel(
      {required this.amount, required this.name, required this.paymentmethod});
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
        amount: json['amount'],
        name: json['name'],
        paymentmethod: json['paymentmethod']);
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "amount": amount, "paymentmethod": paymentmethod};
  }
}
