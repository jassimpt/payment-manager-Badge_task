import 'package:badge_task/controller/baseprovider.dart';
import 'package:badge_task/controller/dataprovider.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:badge_task/views/homepage/widgets/paymentbox.dart';
import 'package:badge_task/views/homepage/widgets/visitorbox.dart';
import 'package:badge_task/views/payment_history/paymenthistory.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<VisitorsModel> filteredvisitors = [];

  @override
  void initState() {
    checkConnection();
    final pro = Provider.of<DataController>(context, listen: false);
    pro.getAllData();
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
                builder: (context) => const PaymentHistory(),
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
      body: Consumer2<BaseProvider, DataController>(
          builder: (context, base, data, child) {
        base.generateAlphabets(data.visitorslist);

        return Column(
          children: [
            SizedBox(
              height: size.height * 0.78,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: filteredvisitors.length,
                itemBuilder: (context, index) {
                  final visitor = filteredvisitors[index];
                  var payments;
                  if (data.paymentslist.isNotEmpty &&
                      index < data.paymentslist.length) {
                    payments = data.paymentslist[index];
                  }
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
                              CircleAvatar(
                                  backgroundColor: payments != null &&
                                          payments.paymentcompleted &&
                                          visitor.name == payments.name
                                      ? Colors.green
                                      : Colors.blue),
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
            Expanded(
              child: ListView.builder(
                itemCount: base.alphabets.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final String alphabet = base.alphabets[index];
                  filterVisitors(
                      firstletter: base.alphabets[base.selected],
                      visitorslist: data.visitorslist);
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        base.alphabetChanger(index);
                      },
                      child: Container(
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                            color: base.selected == index
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          alphabet,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  void checkConnection() async {
    var connectionresult = await Connectivity().checkConnectivity();

    if (connectionresult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Internet')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Internet Available')));
    }
  }

  void filterVisitors(
      {String? firstletter, List<VisitorsModel>? visitorslist}) {
    filteredvisitors = visitorslist!
        .where((visitor) =>
            visitor.name.toLowerCase().startsWith(firstletter!.toLowerCase()))
        .toList();
  }
}
