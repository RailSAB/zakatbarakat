

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/providers/zakat_ushr_provider.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

class UshrOverallPage extends ConsumerStatefulWidget {
  const UshrOverallPage({super.key});

  @override
  ConsumerState<UshrOverallPage> createState() => _UshrOverallState();
}

class _UshrOverallState extends ConsumerState<UshrOverallPage> {
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(104, 200, 215, 231),
      appBar: CustomAppBar(pageTitle: 'Overall', appBarHeight: 70),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: sum()),
            buildNavigationButton(context, '/funds', "View Funds"),
            buildNavigationButton(context, '/home', "Go to Home page"),
          ],
        ),
      ),
    )
    );
  }

  Widget buildNavigationButton(BuildContext context, String route, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 60),
          textStyle: const TextStyle(fontSize: 20),
        ),
        child: Text(text),
      ),
    );
  }

  Widget sum() {
    final isUshrLand = ref.watch(zakatUshrProvider).isUshrLand;
    final crops = ref.watch(zakatUshrProvider).crops;

    if (crops.isEmpty || !isUshrLand) {
      ref.read(zakatUshrProvider.notifier).setCrops([]);
      return const Center(
        child: Text(
          "You don't have any zakat",
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      );
    }

    final toReturn = ListView(
      children: crops.map((crop) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Crop type: ${crop.type}",
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  "Quantity: ${crop.quantity}",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );

    ref.read(zakatUshrProvider.notifier).setCrops([]);
    return toReturn;
  }
}