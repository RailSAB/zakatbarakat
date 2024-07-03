
import 'dart:convert';
import 'package:flutter_app/models/zakat_on_livestock_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_on_livestock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class Livestock2Page extends ConsumerStatefulWidget {
  const Livestock2Page({super.key});

  @override
  ConsumerState<Livestock2Page> createState() => _Livestock2State();
}

class _Livestock2State extends ConsumerState<Livestock2Page> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  final List<TextEditingController> controllers = [];

  final List<String> elemTitles = ["Horses", "Buffaloes", "Camels"];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each title element
    for (var i = 0; i < elemTitles.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(104, 200, 215, 231),
      appBar: CustomAppBar(pageTitle: 'Zakat on Livestock', appBarHeight: 70),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildNotificationBox(),
            const SizedBox(height: 20),
            _buildFormFields(),
            const SizedBox(height: 20),
            _buildCalculateButton(),
          ],
        ),
      ),
       bottomNavigationBar: const CustomBottomNavBar(index: 0),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Zakat on Livestock',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNotificationBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),

      decoration: BoxDecoration(
       color: const Color.fromARGB(255, 176, 216, 253),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Text(
        "It does not count if the livestock is used for work or riding; "
        "the animal was harmed; the owner has NOT fed the herd on his own for more than 7 months.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        for (int i = 0; i < elemTitles.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: elemTitles[i] == "Horses" ? _buildHorsesField(controllers[i]) : _buildInputField(controllers[i], elemTitles[i]),
          ),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Enter amount',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildHorsesField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Horses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Bred for sale?'),
            Switch(
              value: isSwitched1,
              onChanged: (value) => setState(() => isSwitched1 = value),
              activeTrackColor: const Color.fromARGB(255, 176, 216, 253), 
              activeColor: const Color.fromARGB(255, 70, 130, 180), 
            ),
            
            const Spacer(),
            const Text('Any females?'),
            Switch(
              value: isSwitched2,
              onChanged: (value) => setState(() => isSwitched2 = value),
              activeTrackColor: const Color.fromARGB(255, 176, 216, 253), 
              activeColor: const Color.fromARGB(255, 70, 130, 180), 
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Enter amount',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _calculateZakat,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.symmetric(vertical: 20),
        textStyle: const TextStyle(fontSize: 18, color:Colors.black),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: const Text(
        'Calculate',
        style: TextStyle(color: Colors.black), 
      ),
    );
  }

  Future<void> _calculateZakat() async {
    ref.read(zakatOnLivestockProvider.notifier).setForSale(isSwitched1);
    ref.read(zakatOnLivestockProvider.notifier).setFemale(isSwitched2);
    ref.read(zakatOnLivestockProvider.notifier).setHorsesValue(_parseValue(controllers[0].text));
    ref.read(zakatOnLivestockProvider.notifier).setBuffaloes(_parseValue(controllers[1].text));
    ref.read(zakatOnLivestockProvider.notifier).setCamels(_parseValue(controllers[2].text));

    final response = await _performPostRequest();
    if (response != null && response.statusCode == 200) {
      _handleResponse(jsonDecode(response.body));
      Navigator.pushNamed(context, '/livestockoverall');
    } else {
      print('Request failed with status: ${response?.statusCode}.');
    }
  }

  Future<http.Response?> _performPostRequest() async {
    final url = Uri.parse('http://158.160.153.243:8000/calculator/zakat-livestock');
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
      "currency": ref.read(currencyProvider).code,
    });

    try {
      return await http.post(url, headers: headers, body: body);
    } catch (e) {
      return null;
    }
  }

  void _handleResponse(Map<String, dynamic> response) {
    final zakatValueForHorses = response['value_for_horses'].toInt();
    final animals = (response['animals'] as List).map((json) {
      return Animal(
        type: json['type'],
        quantity: json['quantity'],
        age: json['age'],
      );
    }).toList();

    if (response['nisab_status'] != false) {
      ref.read(zakatOnLivestockProvider.notifier).setHorsesValue(zakatValueForHorses);
      ref.read(zakatOnLivestockProvider.notifier).setAnimalsForZakat(animals);
    }
  }

  int _parseValue(String value) {
    return value.isEmpty ? 0 : int.parse(value);
  }
}