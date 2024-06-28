import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(104, 200, 215, 231),
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
        Padding(padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/funds');},
          style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)), 
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white), 
  ),
          child: const Text("View Funds",style: TextStyle(fontSize:20,color: Colors.black)),
        )
        ),
        ]
        )
        
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
      
    );
    
  }

  Widget title() => const Text(
        'Calculate Zakat',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      );

  Widget buttons() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center Alignment
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distributes the space evenly around the buttons
          mainAxisSize: MainAxisSize.min, // Sets the minimum width for the Row
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.pushNamed(context, '/property');},
                  style: ButtonStyle(
                     minimumSize: MaterialStateProperty.all(Size(100, 60)), 
                     backgroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                  ),
                  
                  child: Image.asset('property.png', height: 45, width: 45),
                ),
                const SizedBox(height: 10), // Indentation under the button
                const Text("Property", style: TextStyle(fontSize: 20)),
              ],
            ),
            Spacer(), // Creates a free space between the buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.pushNamed(context, '/livestock');},
                  style: ButtonStyle(
                     minimumSize: MaterialStateProperty.all(Size(100, 60)), 
                     backgroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                  ),
                  child: Image.asset('lifestock.png', height: 50, width: 50),
                ),
                const SizedBox(height: 10), // Indentation under the button
                const Text("Livestock", style: TextStyle(fontSize: 20)),
              ],
            ),
            Spacer(), // Creates a free space between the buttons
            Column(
              children:[
                ElevatedButton(
                onPressed:() {Navigator.pushNamed(context, '/ushr');},
                 style: ButtonStyle(
                     minimumSize: MaterialStateProperty.all(Size(100, 60)), 
                     backgroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                  ),
                 child: Image.asset('ushr.png',height:50 ,width: 50),
                 ),
                 const SizedBox(height: 10),
                 const Text("Ushr", style: TextStyle(fontSize: 20)),

              ],
            ),
          ],
        ),
      ],
    ),
  );
}
}
