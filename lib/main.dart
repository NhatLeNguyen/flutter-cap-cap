import 'package:flutter/material.dart';
import 'signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MB Bank Login',
      /* theme: ThemeData(
        primarySwatch: color: Color(0xFF000080), ,
        scaffoldBackgroundColor: Colors.blue,
      ),*/
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
