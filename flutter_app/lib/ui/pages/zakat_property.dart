import 'package:flutter/material.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyState();
}

class _PropertyState extends State<PropertyPage> {

  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Page'),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // This aligns items along the vertical axis
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: title(),
        ),
        // body
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: button(),
        ),
      ],
    )
    )
    );
  }

  Widget title() => const Text('Zakat on Property', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/property2');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Continue', style: TextStyle(fontSize: 24),),);
  }
}