import 'dart:convert';
import 'package:flutter_app/models/zakat_on_livestock_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_on_livestock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Livestock2Page extends ConsumerStatefulWidget {
  const Livestock2Page({super.key});

  @override
  ConsumerState<Livestock2Page> createState() => _Livestock2State();
}

class _Livestock2State extends ConsumerState<Livestock2Page> {
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
    return ElevatedButton(onPressed: () {
    ref.read(zakatOnLivestockProvider.notifier).setForSale(isSwitched1);
    ref.read(zakatOnLivestockProvider.notifier).setFemale(isSwitched2);
    ref.read(zakatOnLivestockProvider.notifier).setHorsesValue(setValues(controllers[0].text));
    ref.read(zakatOnLivestockProvider.notifier).setBuffaloes(setValues(controllers[1].text));
    ref.read(zakatOnLivestockProvider.notifier).setCamels(setValues(controllers[2].text));
    performPostRequest();
    },
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


Future<void> performPostRequest() async {
    final url = Uri.parse('http://10.90.137.169:8000/calculator/zakat-livestock');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "camels": ref.read(zakatOnLivestockProvider).camels,
      "cows": ref.read(zakatOnLivestockProvider).cows,
      "buffaloes": ref.read(zakatOnLivestockProvider).buffaloes,
      "sheep": ref.read(zakatOnLivestockProvider).sheep,
      "goats": ref.read(zakatOnLivestockProvider).goats,
      "horses_value": ref.read(zakatOnLivestockProvider).horses_value,
      "isFemale_horses": ref.read(zakatOnLivestockProvider).isFemale,
      "isForSale_horses": ref.read(zakatOnLivestockProvider).isForSale,
      "currency": ref.read(currencyProvider).code
    });
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final zakatvalueForHorses = jsonDecode(response.body)['value_for_horses'].toInt();
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        List<dynamic> animals = parsedJson['animals'];
        List<Animal> animalList = animals.map((json) {
          return Animal(
            type: json['type'],
            quantity: json['quantity'],
            age: json.containsKey('age') ? json['age'] : null,
          );
        }).toList();

        if(jsonDecode(response.body)['nisab_status'] != false)
        {
          ref.read(zakatOnLivestockProvider.notifier).setHorsesValue(zakatvalueForHorses);
          ref.read(zakatOnLivestockProvider.notifier).setAnimalsForZakat(animalList);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      Navigator.pushNamed(context, '/livestockoverall');
    } catch (e) {
      print('Error: $e');
    }
  } 


int setValues(String value){
  
    if(value.isEmpty){
      return 0;
    }
    return int.parse(value);
  }

}