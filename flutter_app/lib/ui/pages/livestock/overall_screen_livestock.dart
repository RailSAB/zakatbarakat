import 'package:flutter_app/providers/zakat_on_livestock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class LivestockOverallPage extends ConsumerStatefulWidget {
  const LivestockOverallPage({super.key});

  @override
  ConsumerState<LivestockOverallPage> createState() => _OverallState();
}

class _OverallState extends ConsumerState<LivestockOverallPage> {

  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overall'),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // This aligns items along the vertical axis
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: sum(),
        ),
        Padding(padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/funds');},
          child: const Text("View Funds", style: TextStyle(fontSize: 20),),
        )
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

  Widget title() => const Text('Overall:', style: TextStyle(fontSize: 30),);

  Widget sum(){
    return Column(
      children: [
        if(ref.watch(zakatOnLivestockProvider).animalsForZakat.isNotEmpty )
          ...(ref.watch(zakatOnLivestockProvider).animalsForZakat.map((animal) => 
            Text(style: const TextStyle(fontSize: 30), "Animal type: ${animal.type}, Quantity: ${animal.quantity}, Age: ${animal.age != 0 ? animal.age : "any"}", textAlign: TextAlign.center,)
          ).toList()),
        Text(style: const TextStyle(fontSize: 30), "Overall: ${ref.watch(zakatOnLivestockProvider).zakatForHorses} RUB", textAlign: TextAlign.center,),
      ]
    );
  }

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Go to Home page', style: TextStyle(fontSize: 24),),);
  }


}