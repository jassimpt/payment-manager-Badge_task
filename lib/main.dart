import 'package:badge_task/views/homepage/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User payment manager',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
