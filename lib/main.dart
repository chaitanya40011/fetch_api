

import 'package:api_example/views/screens/api_call.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
      Widget build(BuildContext context) {
    return const MaterialApp(
    home: ApiCall(),
    );


