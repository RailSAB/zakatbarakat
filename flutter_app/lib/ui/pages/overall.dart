import 'package:flutter/material.dart';

class OverallPage extends StatefulWidget {
  const OverallPage({super.key});

  @override
  State<OverallPage> createState() => _OverallState();
}

class _OverallState extends State<OverallPage> {

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
          child: sum(123456),
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

  Widget sum(int number){
    return Text(style: const TextStyle(fontSize: 30), "Overall: $number RUB", textAlign: TextAlign.center,);
  }

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Go to Home page', style: TextStyle(fontSize: 24),),);
  }
}