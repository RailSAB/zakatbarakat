import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/livestock/overall_screen_livestock.dart';
import 'package:flutter_app/ui/pages/livestock/zakat_livestock_screen_1.dart';
import 'package:flutter_app/ui/pages/property/zakat_property_screen_1.dart';
import 'package:flutter_app/ui/pages/ushr/zakat_ushr_screen.dart';
import 'package:flutter_app/ui/pages/home_page.dart';
import 'package:flutter_app/ui/pages/livestock/zakat_livestock_screen_2.dart.dart';
import 'package:flutter_app/ui/pages/property/zakat_property_screen_2.dart';
import 'package:flutter_app/ui/pages/property/zakat_property_screen_3.dart';
import 'package:flutter_app/ui/pages/property/overall_screen_property.dart';
import 'package:flutter_app/ui/widgets/dynamic_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/pages/ushr/overall_screen_ushr.dart';

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