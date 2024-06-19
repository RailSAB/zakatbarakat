import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/zakat_livestock.dart';
import 'package:flutter_app/ui/pages/zakat_property.dart';
import 'package:flutter_app/ui/pages/zakat_ushr.dart';
import 'package:flutter_app/ui/pages/home_page.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple,),
      home: const HomePage(),
      routes: {
        '/livestock': (context) => const LivestockPage(),
        '/property': (context) => const PropertyPage(),
        '/ushr': (context) => const UshrPage()
      },
    );
  }
}