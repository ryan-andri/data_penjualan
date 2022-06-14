import 'package:flutter/material.dart';
import 'view/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Penjualan',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
  }
}
