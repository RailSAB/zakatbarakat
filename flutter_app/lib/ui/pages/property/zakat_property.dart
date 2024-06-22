import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyPage extends ConsumerStatefulWidget {
  const PropertyPage({super.key});

  @override
  ConsumerState<PropertyPage> createState() => _PropertyState();
}

class _PropertyState extends ConsumerState<PropertyPage> {

  List <TextEditingController> controllers = [];
  List <String> elemTitle = ["Cash", "Bank card", "Silver", "Gold"];
  final numberController = TextEditingController();

  @override
  void initState(){
    super.initState();
    for (int i = 0; i < 4; i++) { 
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
          padding: const EdgeInsets.all(32.0),
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

        ref.read(zakatOnPropertyProvider.notifier).setCash(setValues(controllers[0].text));
        ref.read(zakatOnPropertyProvider.notifier).setCashOnBankCards (setValues(controllers[1].text));
        ref.read(zakatOnPropertyProvider.notifier).setGoldJewellery (setValues(controllers[3].text));
        ref.read(zakatOnPropertyProvider.notifier).setSilverJewellery(setValues(controllers[2].text));

        Navigator.pushNamed(context, '/property2');
      }, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Continue', style: TextStyle(fontSize: 24),),);
  }


  Widget body() {
  return Column(
    children: [
      ...[
        const Text('Money', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        for (int i = 0; i < 2; i++)
          enterField(controllers[i], elemTitle[i]),
        const SizedBox(height: 40),
        const Text('Jewlery', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        for (int i = 2; i < 4; i++)
          enterField(controllers[i], elemTitle[i])
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
}