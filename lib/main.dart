import 'package:flutter/material.dart';
import 'package:thelast/screens/login.dart';
import 'screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users CRUD',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue),
      initialRoute: '/',
      routes: {
        '/':(context) => const Home(),
        '/login':(context) => const Login(),
      },
    );
  }
}