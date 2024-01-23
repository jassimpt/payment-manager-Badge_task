import 'package:badge_task/controller/baseprovider.dart';
import 'package:badge_task/controller/dataprovider.dart';
import 'package:badge_task/views/homepage/widgets/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentDialogueBox extends StatelessWidget {
  PaymentDialogueBox({
    super.key,
    required this.visitorname,
  });
  final String visitorname;

  final TextEditingController amountcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DataController>(context);
    final basepro = Provider.of<BaseProvider>(context);
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
        PaymentMethod(paymethod: "UPI", switchvalue: basepro.upiswitch),
        PaymentMethod(paymethod: "CASH", switchvalue: basepro.cashswitch),
        PaymentMethod(paymethod: "LATER", switchvalue: basepro.laterswitch),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: amountcontroller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money_outlined)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  DateTime time = DateTime.now();

                  pro.addpayment(amountcontroller.text, visitorname,
                      basepro.paymentmethod!, time, true);

                  Navigator.pop(context);
                },
                child: const Text('Done')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
          ],
        )
      ],
    );
  }
}
