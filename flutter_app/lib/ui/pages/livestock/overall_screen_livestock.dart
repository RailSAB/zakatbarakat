
import 'package:flutter/widgets.dart';
import 'package:flutter_app/providers/zakat_on_livestock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';


class LivestockOverallPage extends ConsumerStatefulWidget {
  const LivestockOverallPage({super.key});

  @override
  ConsumerState<LivestockOverallPage> createState() => _OverallState();
}

class _OverallState extends ConsumerState<LivestockOverallPage> {
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Overall LiveStock Zakat'),
      backgroundColor: Color.fromARGB(104, 200, 215, 231),
      
      body: Padding(
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
       bottomNavigationBar: const CustomBottomNavBar(
        index: 0,
      ),

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
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          minimumSize: const Size(double.infinity, 60),
          textStyle: const TextStyle(fontSize: 20,color: Colors.black),
        ),
        child: Text(text),
      ),
    );
  }

  Widget sum() {
    final animalsForZakat = ref.watch(zakatOnLivestockProvider).animalsForZakat;
    final zakatForHorses = ref.watch(zakatOnLivestockProvider).zakatForHorses;

    return ListView(
      children: [
        if (animalsForZakat.isNotEmpty)
          ...animalsForZakat.map((animal) => Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Animal type: ${animal.type}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Quantity: ${animal.quantity}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Age: ${animal.age != 0 ? animal.age : "any"}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              )),
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Overall: ${ref.watch(zakatOnLivestockProvider).zakatForHorses}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}