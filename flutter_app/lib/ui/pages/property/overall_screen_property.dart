import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

class PropertyOverallPage extends ConsumerStatefulWidget {
  const PropertyOverallPage({super.key});

  @override
  ConsumerState<PropertyOverallPage> createState() => _PropertyOverallState();
}

class _PropertyOverallState extends ConsumerState<PropertyOverallPage> {
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(pageTitle: 'Overall on Property Zakat', appBarHeight: 70),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // This aligns items along the vertical axis
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: sum(ref.watch(zakatOnPropertyProvider).zakatValue),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: button(),
            ),
          ],
        )));
  }

  Widget title() => const Text(
        'Overall:',
        style: TextStyle(fontSize: 30),
      );

  Widget sum(int number) {
    if (number == 0) {
      return const Text(
        style: TextStyle(fontSize: 30),
        "You don't have any zakat",
        textAlign: TextAlign.center,
      );
    }
    return Text(
      style: const TextStyle(fontSize: 30),
      "Overall: $number ${ref.watch(currencyProvider).code}",
      textAlign: TextAlign.center,
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
      child: const Text(
        'Go to Home page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

