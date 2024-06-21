import 'package:flutter/material.dart';

class Livestock2Page extends StatefulWidget {
  const Livestock2Page({super.key});

  @override
  State<Livestock2Page> createState() => _Livestock2State();
}

class _Livestock2State extends State<Livestock2Page> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;

  final List<TextEditingController> controllers = [];
  final List<String> elemTitle = ["Horses", "Buffaloes", "Camels"];

   @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) { // Assuming you want 3 fields
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
        title: const Text('Livestock Page'),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // This aligns items along the vertical axis
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: title(),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: notificationBox(),
        ),
        body(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: button(),
        ),
      ],
    )
    )
    );
  }

  Widget title() => const Text('Zakat on Livestock', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

  Widget notificationBox(){
    return Container(
      width: 600,
      height: 90,
      decoration: BoxDecoration(
              color: Colors.grey, 
              borderRadius: BorderRadius.circular(20), 
            ),
      child: const Center(
        child: 
            Text("It does not count if the livestock is used for work, riding; "
            "the animal was harmed; the owner has NOT fed the herd on his own for more than 7 months",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,),
            )
      );

  }

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/overall');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Calculate', style: TextStyle(fontSize: 24),),);
  }

 
 Widget body() {
  return Column(
    children: [
      ...[
        for (int i = 0; i < 3; i++)
          if (elemTitle[i] != "Horses")
            enterField(controllers[i], elemTitle[i])
          else horses(controllers[i]),
      ], // Explicitly converting the Set to a List
    ],
  );
}


  Widget enterField(TextEditingController controller, String text) {
  return Column(
    children: [
      const SizedBox(height: 20),
      Text(text, style: const TextStyle(fontSize: 24), ), 
      const SizedBox(height: 20), 
      Row(
        children: [
          const SizedBox(width: 20),
          const Text('Amount'),
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
    ],
  );
}

Widget horses(TextEditingController controller){
  return Column(
    children: [
      const Text('Horses', style: TextStyle(fontSize: 24),), 
      const SizedBox(height: 20),
      Row (
        children: [
          const SizedBox(width: 20),
          const Text('Are they being \nbred for sale?'),
          const SizedBox(width: 20),
          Switch(value: isSwitched1,
                 onChanged: (value) {
                  setState(() {
                  isSwitched1 = value;
                });
              },),
          const SizedBox(width: 50,),
          const Text('Are there any \nfemales?'),
          Switch(value: isSwitched2,
                 onChanged: (value) {
                  setState(() {
                  isSwitched2 = value;
                });
              },),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          const SizedBox(width: 20),
          const Text('Amount'),
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
    ],
  );
}
}