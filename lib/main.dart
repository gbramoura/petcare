import 'package:flutter/material.dart';
import 'package:petcare/pages/home_page.dart';
import 'package:petcare/themes/pet_care_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: petCareTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
