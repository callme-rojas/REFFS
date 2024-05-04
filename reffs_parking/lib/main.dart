import 'package:flutter/material.dart';
import 'package:reffs_parking/car_register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RegisterCarPage(), // Cambiado de MyHomePage a LoginPage
      debugShowCheckedModeBanner: false, 
    );
  }
}

