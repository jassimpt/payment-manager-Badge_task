import 'package:badge_task/controller/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  List cash = [];
  List upi = [];
  List later = [];
  dynamic totalcash = 0;
  dynamic totalupi = 0;
  dynamic totallater = 0;
  dynamic total = 0;
  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 236, 255),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<DataController>(context, listen: false).clearData();
              },
              child: const Text('Clear'))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  'Payments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.3,
                ),
                const Text('Attendance',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Consumer<DataController>(
            builder: (context, value, child) => SizedBox(
              height: size.height * 0.75,
              child: ListView.builder(
                itemCount: value.paymentslist.length,
                itemBuilder: (context, index) {
                  final payment = value.paymentslist[index];
                  final formateddate =
                      DateFormat("hh:mm a").format(payment.time);

                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(payment.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                            Text("₹${payment.amount}-${payment.paymentmethod}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(payment.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                            Text(formateddate,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5)))
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Cash",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("₹${totalcash.toString()}")
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "UPI",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("₹${totalupi.toString()}")
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("₹${total.toString()}")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  calculateTotal() {
    final value = Provider.of<DataController>(context, listen: false);
    for (var i = 0; i < value.paymentslist.length; i++) {
      if (value.paymentslist[i].paymentmethod == "CASH") {
        cash.add(value.paymentslist[i].amount);
      } else if (value.paymentslist[i].paymentmethod == "UPI") {
        upi.add(value.paymentslist[i].amount);
      } else if (value.paymentslist[i].paymentmethod == "LATER") {
        later.add(value.paymentslist[i].amount);
      }
    }
    totalcash = cash.fold(0, (a, b) => a + int.parse(b));
    totalupi = upi.fold(0, (a, b) => a + int.parse(b));
    totallater = later.fold(0, (a, b) => a + int.parse(b));
    total = totalcash + totallater + totalupi;
  }
}
