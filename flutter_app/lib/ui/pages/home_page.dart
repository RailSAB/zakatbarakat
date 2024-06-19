import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home Page'),),
      ),
      body: Center(
        child:Column(
          children: [ 
            Padding(
          padding: const EdgeInsets.all(32.0),
          child: title(),
        ),
        //body
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buttons(),
        ),
          ]
        )
      ),
    );
  }

  Widget title() => const Text('Calculate Zakat', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

  Widget buttons() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // This centers the buttons and adds space between them
      children: [
        ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/ushr');},
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
          child: const Text("Ushr", style: TextStyle(fontSize: 20),),
        ),
        const SizedBox(width: 20), // Adds horizontal space between the first two buttons

        ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/livestock');},
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
          child: const Text("Livestock", style: TextStyle(fontSize: 20),),
        ),
        const SizedBox(width: 20), // Adds horizontal space between the second and third buttons

        ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/property');},
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
          child: const Text("Property", style: TextStyle(fontSize: 20),),
        ),
      ],
    ),
  );
}

}