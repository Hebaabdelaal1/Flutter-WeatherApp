import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, 
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor:Colors.white),
      ),
      home:Home(),
    );
  }
}
  //   String  apiKey="7ff521c8b27a48b299d180623252704";
  // final String baseUrl="http://api.weatherapi.com/v1/current.json";