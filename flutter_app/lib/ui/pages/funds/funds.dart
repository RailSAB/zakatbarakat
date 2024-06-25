import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/fund.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

class FundsPage extends ConsumerStatefulWidget {
  const FundsPage({super.key});

  @override
  ConsumerState<FundsPage> createState() => _FundsState();
}

class _FundsState extends ConsumerState<FundsPage> {
  List<String> motto = [
    'Food for all',
    'Clean water',
    'Education for all',
    'Save turtles',
  ];
  List<NetworkImage> image = [
    const NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQRjRWlxq_UNhGIR8lGhUM_Y_j2GGhCl2C2w&s'),
    const NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkhR_5doNqp1UIsChEMf9wqlY-CIZ467MC3w&s'),
    const NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlhj8Vt8KOEQ9w6ZK68QUUIg_YTNYMVqAhQg&s'),
    const NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8a7rctG1u6nhnnDU3vrfW4b9pUiQwaKIkrg&s'),
  ];
  List<Uri> url = [
   Uri.parse('https://www.google.com/'),
   Uri.parse('https://www.google.com/'),  
   Uri.parse('https://www.google.com/'),
   Uri.parse('https://www.google.com/'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Recomended Funds'),
      body: ListView(
<<<<<<< HEAD
        children: <Widget>[
          const SizedBox(height: 32),
          Fund(title: motto[0], image: image[0]),
          const SizedBox(height: 16),
          Fund(title: motto[1], image: image[1]),
          const SizedBox(height: 16),
          Fund(title: motto[2], image: image[2]),
          const SizedBox(height: 16),
          Fund(title: motto[3], image: image[3]),
          const SizedBox(height: 16),
=======
        children: 
        <Widget>[
            const Text('Recomended Funds', style: TextStyle(fontSize: 30),),
            const SizedBox(height: 32),
            Fund(title: motto[0], image: image[0], url: url[0]),
            const SizedBox(height: 16),
            Fund(title: motto[1], image: image[1], url: url[1]),
            const SizedBox(height: 16),
            Fund(title: motto[2], image: image[2], url: url[2]),
            const SizedBox(height: 16),
            Fund(title: motto[3], image: image[3], url: url[3]),
            const SizedBox(height: 16),
>>>>>>> d8d9c31e521b5b3b1a7268fe53f79e076b0c02ef
        ],
      ),
    );
  }
}
