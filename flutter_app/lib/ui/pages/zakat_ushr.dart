import 'package:flutter/material.dart';

class UshrPage extends StatefulWidget {
  const UshrPage({super.key});

  @override
  State<UshrPage> createState() => _UshrState();
}

class _UshrState extends State<UshrPage> {
final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ushr Page'),
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
          child: addHarvest(),
        ),
        //body
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: button(),
        ),
      ],
    )
    )
    );
  }

  Widget title() => const Text('Zakat on Ushr', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/overall');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Calculate', style: TextStyle(fontSize: 24),),);
  }

  Widget addHarvest(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/harvestTable');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Edit Harvest', style: TextStyle(fontSize: 24),),);
  }
}