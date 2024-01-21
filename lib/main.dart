import 'package:badge_task/controller/baseprovider.dart';
import 'package:badge_task/controller/dataprovider.dart';
import 'package:badge_task/firebase_options.dart';
import 'package:badge_task/model/paymentmodel.dart';
import 'package:badge_task/model/visitorsmodel.dart';
import 'package:badge_task/views/homepage/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PaymentModelAdapter().typeId) &&
      !Hive.isAdapterRegistered(VisitorsModelAdapter().typeId)) {
    Hive.registerAdapter(PaymentModelAdapter());
    Hive.registerAdapter(VisitorsModelAdapter());
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BaseProvider(),
        )
      ],
      child: const MaterialApp(
        title: 'User payment manager',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
