import 'package:flutter_app/providers/zakat_ushr_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UshrOverallPage extends ConsumerStatefulWidget {
  const UshrOverallPage({super.key});

  @override
  ConsumerState<UshrOverallPage> createState() => _UshrOverallState();
}

class _UshrOverallState extends ConsumerState<UshrOverallPage> {

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
          padding: EdgeInsets.all(32.0),
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
    if(ref.watch(zakatUshrProvider).crops.isEmpty || ref.watch(zakatUshrProvider).isUshrLand == false) {
      ref.read(zakatUshrProvider.notifier).setCrops([]);
      return const Text(style: TextStyle(fontSize: 30), "You don't have any zakat", textAlign: TextAlign.center,);
    }
    final toReturn =Column(
      children: [
        ...(ref.watch(zakatUshrProvider).crops.map((crop) => 
          Text(style: const TextStyle(fontSize: 30), "Crop type: ${crop.type}, Quantity: ${crop.quantity}", textAlign: TextAlign.center,)
        ).toList()),
      ]
    );

    ref.read(zakatUshrProvider.notifier).setCrops([]);

    return toReturn;
  }

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Go to Home page', style: TextStyle(fontSize: 24),),);
  }


}