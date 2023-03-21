import 'package:cafe_animation/constant/service_locater.dart';
import 'package:cafe_animation/home_page.dart';
import 'package:cafe_animation/widgets/coffee_list_widget.dart';
import 'package:cafe_animation/widgets/intro_widget.dart';
import 'package:flutter/material.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
