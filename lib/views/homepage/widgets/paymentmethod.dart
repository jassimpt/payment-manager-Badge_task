import 'package:badge_task/controller/baseprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({
    required this.switchvalue,
    required this.paymethod,
    super.key,
  });

  final String paymethod;
  final bool switchvalue;
  @override
  Widget build(BuildContext context) {
    return Consumer<BaseProvider>(
      builder: (context, pro, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            paymethod,
            style: const TextStyle(fontSize: 16),
          ),
          Switch(
            value: switchvalue,
            onChanged: (value) {
              pro.valueSetter(value: value, paymode: paymethod);
            },
          )
        ],
      ),
    );
  }
}
