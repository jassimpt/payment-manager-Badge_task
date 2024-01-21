import 'package:badge_task/controller/dataprovider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitorDialogueBox extends StatelessWidget {
  VisitorDialogueBox({
    super.key,
  });

  final TextEditingController visitornamecontroller = TextEditingController();
  final TextEditingController sponsorcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DataController>(context, listen: false);

    return AlertDialog(
      content: const Text(
        'Enter visitor Details',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextFormField(
          controller: visitornamecontroller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              prefixIcon: Icon(Icons.person),
              hintText: 'Enter visitor name'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: sponsorcontroller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              prefixIcon: Icon(Icons.person),
              hintText: 'Enter Sponsor name'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  pro.addVisitor(
                    name: visitornamecontroller.text,
                    sponsorname: sponsorcontroller.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save'))
          ],
        )
      ],
    );
  }

  // addVisitor(context) async {
  //   var connectivityresult = await Connectivity().checkConnectivity();
  //   print(connectivityresult);
  //   if (connectivityresult == ConnectivityResult.none) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('No network')));
  //   } else {

  //   }
  // }
}
