import 'dart:convert';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class OverallPage extends ConsumerStatefulWidget {
  const OverallPage({super.key});

  @override
  ConsumerState<OverallPage> createState() => _OverallState();
}

class _OverallState extends ConsumerState<OverallPage> {

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
          child: sum(ref.watch(zakatOnPropertyProvider).zakatValue),
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