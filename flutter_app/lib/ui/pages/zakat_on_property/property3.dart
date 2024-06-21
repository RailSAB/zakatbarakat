import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Property3Page extends ConsumerStatefulWidget {
  const Property3Page({super.key});

  @override
  ConsumerState<Property3Page> createState() => _Property3State();
}

class _Property3State extends ConsumerState<Property3Page> {
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
    return ElevatedButton(onPressed: () {
      ref.read(zakatOnPropertyProvider.notifier).setPurchasedNotForResaling(setValues(controllers[0].text));
      ref.read(zakatOnPropertyProvider.notifier).setUsedAfterNisab(setValues(controllers[1].text));
      ref.read(zakatOnPropertyProvider.notifier).setRentMoney(setValues(controllers[2].text));
      performPostRequest();
      }, 
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

int setValues(String value){
    if(value.isEmpty){
      return 0;
    }
    return int.parse(value);
  }


Future<void> performPostRequest() async {
    final url = Uri.parse('http://10.90.137.169:8000/calculator/zakat-property');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "cash": ref.read(zakatOnPropertyProvider).cash,
      "cash_on_bank_cards": ref.read(zakatOnPropertyProvider).cashOnBankCards,
      "silver_jewelry": ref.read(zakatOnPropertyProvider).silverJewellery,
      "gold_jewelry": ref.read(zakatOnPropertyProvider).goldJewellery,
      "purchased_product_for_resaling": ref.read(zakatOnPropertyProvider).purchasedProductForResaling,
      "unfinished_product": ref.read(zakatOnPropertyProvider).unfinishedProduct,
      "produced_product_for_resaling": ref.read(zakatOnPropertyProvider).producedProductForResaling,
      "purchased_not_for_resaling": ref.read(zakatOnPropertyProvider).purchasedNotForResaling,
      "used_after_nisab": ref.read(zakatOnPropertyProvider).usedAfterNisab,
      "rent_money":   ref.read(zakatOnPropertyProvider).rentMoney,
      "stocks_for_resaling": ref.read(zakatOnPropertyProvider).stocksForResaling,
      "income_from_stocks": ref.read(zakatOnPropertyProvider).incomeFromStocks,
      "taxes_value": ref.read(zakatOnPropertyProvider).taxesValue
    });
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final zakatvalue = jsonDecode(response.body)['zakat_value'].toInt();
        if(jsonDecode(response.body)['nisab_value'] == false)
        {
          ref.read(zakatOnPropertyProvider.notifier).setZakatValue(0);  
        }else{
          ref.read(zakatOnPropertyProvider.notifier).setZakatValue(zakatvalue);
        }
        Navigator.pushNamed(context, '/overall');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  } 
}