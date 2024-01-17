import 'package:badge_task/views/homepage/widgets/paymentmethod.dart';
import 'package:flutter/material.dart';

class PaymentDialogueBox extends StatelessWidget {
  const PaymentDialogueBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
          ),
        ),
        const Center(
          child: Text(
            "Name",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        PaymentMethod(paymethod: "UPI"),
        PaymentMethod(paymethod: "CASH"),
        PaymentMethod(paymethod: "LATER"),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money_outlined)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: Text('Done')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
          ],
        )
      ],
    );
  }
}
