import 'dart:io';

import 'package:badge_task/model/visitorsmodel.dart';
import 'package:badge_task/views/homepage/widgets/paymentbox.dart';
import 'package:flutter/material.dart';

class VisitorsCard extends StatelessWidget {
  VisitorsCard({
    super.key,
    required this.visitor,
    required this.size,
    required this.payments,
    required this.connection,
  });

  final VisitorsModel visitor;
  final Size size;
  var payments;
  final bool connection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return PaymentDialogueBox(
                visitorname: visitor.name,
              );
            },
          );
        },
        child: Container(
          height: size.height * 0.2,
          width: size.width * 0.2,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: payments != null &&
                                  payments.paymentcompleted &&
                                  visitor.name == payments.name
                              ? Colors.green
                              : Colors.white,
                          width: 5),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundImage: visitor.image != null
                        ? connection
                            ? NetworkImage(visitor.image!)
                            : FileImage(File(visitor.image!)) as ImageProvider
                        : const AssetImage('assets/images/profilke.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  visitor.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  visitor.sponsorname,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
