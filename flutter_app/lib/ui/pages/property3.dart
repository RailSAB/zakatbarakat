import 'package:flutter/material.dart';

class Property3Page extends StatefulWidget {
  const Property3Page({super.key});

  @override
  State<Property3Page> createState() => _Property3State();
}

class _Property3State extends State<Property3Page> {
  List <TextEditingController> controllers = [];
  List <String> elemTitle = ["Bought without the intention \nof resale, but the first \nsteps towards this \nhave been taken",
  "Was used or spent after \npayment of zakat became \nobligatory \n(if stolen or lost, do not count)",
  "Income from premises for \nrent or sale"];

  final numberController = TextEditingController();

  @override
  void initState(){
    super.initState();
    for (int i = 0; i < 3; i++) { 
      controllers.add(TextEditingController());
    }
  }
  
  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
          padding: const EdgeInsets.all(16.0),
          child: title(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: body(),
        ),
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
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/overall');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Calculate', style: TextStyle(fontSize: 24),),);
  }

  Widget body() {
  return Column(
    children: [
      ...[
        const Text('Property', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        for (int i = 0; i < 3; i++)
          enterField(controllers[i], elemTitle[i]),
      ], // Explicitly converting the Set to a List
    ],
  );
}


  Widget enterField(TextEditingController controller, String text) {
  return Column(
    children: [
      const SizedBox(height: 10),
      Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 20),),
          const SizedBox(width: 20),
          Expanded(child: TextField(controller: controller, 
          decoration: const InputDecoration(
                      hintText: 'Enter value',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    keyboardType: TextInputType.number,)), 
        ],
      ),
      const SizedBox(height: 20,),
    ],
  );
}
}