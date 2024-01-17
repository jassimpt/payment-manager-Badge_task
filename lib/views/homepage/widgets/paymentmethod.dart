import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({
    required this.paymethod,
    super.key,
  });

  String paymethod;

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isswtiched = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.paymethod,
          style: TextStyle(fontSize: 16),
        ),
        Switch(
          value: isswtiched,
          onChanged: (value) {
            setState(() {
              isswtiched = value;
            });
          },
        )
      ],
    );
  }
}
