import 'package:flutter/material.dart';
import './dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 144, 255, 161),
          secondary: Colors.green.withOpacity(0.05),
          tertiary: const Color.fromARGB(255, 101, 255, 196),
          shadow: const Color.fromARGB(255, 186, 186, 186),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
    );
  }
}
