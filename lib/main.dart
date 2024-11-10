import 'package:flutter/material.dart';
import 'package:food_delivery_ui/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Food delivery UI',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          primaryColor: Colors.deepOrangeAccent),
      home: HomeScreen(),
    );
  }
}
