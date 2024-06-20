import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/zakat_livestock.dart';
import 'package:flutter_app/ui/pages/zakat_property.dart';
import 'package:flutter_app/ui/pages/zakat_ushr.dart';
import 'package:flutter_app/ui/pages/home_page.dart';
import 'package:flutter_app/ui/pages/livestock2.dart';
import 'package:flutter_app/ui/pages/property2.dart';
import 'package:flutter_app/ui/pages/property3.dart';
import 'package:flutter_app/ui/pages/overall.dart';
import 'package:flutter_app/ui/widgets/dynamic_table.dart';

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
        '/home': (context) => const HomePage(),
        '/livestock': (context) => const LivestockPage(),
        '/property': (context) => const PropertyPage(),
        '/ushr': (context) => const UshrPage(),
        '/property2': (context) => const Property2Page(),
        '/property3': (context) => const Property3Page(),
        '/livestock2': (context) => const Livestock2Page(),
        '/overall': (context) => const OverallPage(),
        '/harvestTable': (context) => const DynamicTable(taskId: '1',),
      },
    );
  }
}