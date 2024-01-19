class PaymentModel {
  String name;
  dynamic amount;
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
