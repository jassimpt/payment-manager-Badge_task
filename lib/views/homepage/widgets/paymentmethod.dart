import 'package:badge_task/controller/baseprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<BaseProvider>(
      builder: (context, pro, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.paymethod,
            style: TextStyle(fontSize: 16),
          ),
          Switch(
            value: isswtiched,
            onChanged: (value) {
              pro.valueSetter(value: value, paymode: widget.paymethod);
            },
          )
        ],
      ),
    );
  }
}
