import 'package:flutter/material.dart';

class LivestockPage extends StatefulWidget {
  const LivestockPage({super.key});

  @override
  State<LivestockPage> createState() => _LivestockState();
}

class _LivestockState extends State<LivestockPage> {

  final List<TextEditingController> controllers = [];
  final List<String> elemTitle = ["Sheep/Rams", "Cows/Bulls", "Goats"];

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
          padding: const EdgeInsets.all(16.0),
          child: title(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: notificationBox(),
        ),
        body(),
        Padding(
          padding: const EdgeInsets.all(16.0),
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
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/livestock2');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Continue', style: TextStyle(fontSize: 24),),);
  }

 
 Widget body() {
  return Column(
    children: [
      ...[
        for (int i = 0; i < 3; i++)
          enterField(controllers[i], elemTitle[i])
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

}