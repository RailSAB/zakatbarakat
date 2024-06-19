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
        title: const Text('Home Page'),
      ),
      body: Center(
        child:Column(
          children: [ 
            const Text("Zakat Calculation"),
            Row(
            children: [
              ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/ushr');}, child: const Text("Ushr")),
              ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/livestock');}, child: const Text("Livestock")),
              ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/property');}, child: const Text("Property"))],
            ),
          ]
        )
      ),
    );
  }
}