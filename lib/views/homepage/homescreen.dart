import 'package:badge_task/constants/constants.dart';
import 'package:badge_task/controller/dataprovider.dart';
import 'package:badge_task/views/homepage/widgets/paymentbox.dart';
import 'package:badge_task/views/homepage/widgets/visitorbox.dart';
import 'package:badge_task/views/payment_history/paymenthistory.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<DataController>(context, listen: false).getAllVisitors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            backgroundColor: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return VisitorDialogueBox();
                },
              );
            },
            child: const Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'btn2',
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentHistory(),
              ));
            },
            child: const Icon(
              Icons.attach_money_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 220, 236, 255),
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Center(
            child: Text('Payment Manager'),
          )),
      body: Column(
        children: [
          Consumer<DataController>(
            builder: (context, value, child) => SizedBox(
              height: size.height * 0.78,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: value.visiors.length,
                itemBuilder: (context, index) {
                  final visitor = value.visiors[index];
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.green,
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
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: alphabets.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final String alphabet = alphabets[index];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      alphabet,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
