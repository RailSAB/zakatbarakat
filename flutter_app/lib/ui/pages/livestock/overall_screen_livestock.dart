
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
      appBar: CustomAppBar(pageTitle: 'Overall Livestock Zakat', appBarHeight: 70),
       backgroundColor: Colors.grey[200],
      
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
          textStyle: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget sum() {
    final animalsForZakat = ref.watch(zakatOnLivestockProvider).animalsForZakat;
    final zakatForHorses = ref.watch(zakatOnLivestockProvider).zakatForHorses;

    if (animalsForZakat.isEmpty && zakatForHorses == 0) {
      return const Center(
        child: Text(
          "You don't have any zakat to pay.",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView(
  children: [
    if (animalsForZakat.isNotEmpty)
     ...animalsForZakat.map((animal) => Card(
              color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
               
                child: Padding(
                
                  padding: const EdgeInsets.all(16.0),
                 
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
              'Overall:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
    if (zakatForHorses!= 0)
      Card(
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Zakat for Horses: $zakatForHorses",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
  ],
);
  }
}