import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/livestock/overallLivestock.dart';
import 'package:flutter_app/ui/pages/livestock/zakat_livestock.dart';
import 'package:flutter_app/ui/pages/property/zakat_property.dart';
import 'package:flutter_app/ui/pages/ushr/zakat_ushr.dart';
import 'package:flutter_app/ui/pages/home_page.dart';
import 'package:flutter_app/ui/pages/livestock/livestock2.dart';
import 'package:flutter_app/ui/pages/property/property2.dart';
import 'package:flutter_app/ui/pages/property/property3.dart';
import 'package:flutter_app/ui/pages/property/overallProperty.dart';
import 'package:flutter_app/ui/widgets/dynamic_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/pages/ushr/overallUshr.dart';

void main() {
  runApp(const ProviderScope(child:  ExampleApp()));
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
        '/propertyoverall': (context) => const PropertyOverallPage(),
        '/livestockoverall': (context) => const LivestockOverallPage(),
        '/harvestTable': (context) => const DynamicTable(taskId: '1',), 
        //dont understand why this needs taskID, and what taskID should we use
        '/ushrOverall': (context) => const UshrOverallPage(),
      },
    );
  }
}