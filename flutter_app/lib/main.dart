import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/controller/dependency_injection.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/ui/pages/livestock/overall_screen_livestock.dart';
import 'package:flutter_app/ui/pages/livestock/zakat_livestock_screen_1.dart';
import 'package:flutter_app/ui/pages/organizations/organizations.dart';
import 'package:flutter_app/ui/pages/property/newproperty_screen.dart';
import 'package:flutter_app/ui/pages/ushr/zakat_ushr_screen.dart';
import 'package:flutter_app/ui/pages/home_page.dart';
import 'package:flutter_app/ui/pages/livestock/zakat_livestock_screen_2.dart.dart';
import 'package:flutter_app/ui/pages/property/overall_screen_property.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/pages/ushr/overall_screen_ushr.dart';
import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/knowledge_base/kb_main_frame.dart';

void main() {
  runApp(const ProviderScope(child: ExampleApp()));
  DependencyInjection.init();
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/livestock': (context) => const LivestockPage(),
        '/property': (context) =>  PropertyPage(selectedCurrencies: ModalRoute.of(context)!.settings.arguments as List<CurrencyModel>,),
        '/ushr': (context) => const UshrPage(),
        '/livestock2': (context) => const Livestock2Page(),
        '/propertyoverall': (context) => const PropertyOverallPage(),
        '/livestockoverall': (context) => const LivestockOverallPage(),
        // '/harvestTable': (context) => const DynamicTable(
        //       taskId: '1',
        //     ),
        //dont understand why this needs taskID, and what taskID should we use
        '/ushrOverall': (context) => const UshrOverallPage(),
        '/funds': (context) => Organizations(isCharity: true),
        '/kb': (context) => const KBPage(),
        '/org': (context) => Organizations(isCharity: false),
      },
    );
  }
}
