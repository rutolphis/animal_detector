import 'package:flutter/material.dart';
import 'package:nie_vmm/pages/home.dart';
import 'package:nie_vmm/widgets/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal recognizer',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        dialogBackgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}
