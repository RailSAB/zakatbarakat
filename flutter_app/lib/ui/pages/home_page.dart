import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
=======
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
>>>>>>> d8d9c31e521b5b3b1a7268fe53f79e076b0c02ef

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Home Page'),
      body: Center(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: title(),
        ),
        //body
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buttons(),
        ),
<<<<<<< HEAD
      ])),
=======
        Padding(padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/funds');},
          child: const Text("View Funds", style: TextStyle(fontSize: 20),),
        )
        ),
        ]
        )
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0,),
>>>>>>> d8d9c31e521b5b3b1a7268fe53f79e076b0c02ef
    );
  }

  Widget title() => const Text(
        'Calculate Zakat',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      );

  Widget buttons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceEvenly, // This centers the buttons and adds space between them
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ushr');
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
            child: const Text(
              "Ushr",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
              width: 20), // Adds horizontal space between the first two buttons

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/livestock');
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
            child: const Text(
              "Livestock",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
              width:
                  20), // Adds horizontal space between the second and third buttons

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/property');
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
            child: const Text(
              "Property",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
