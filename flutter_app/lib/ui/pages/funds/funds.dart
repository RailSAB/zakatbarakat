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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Recomended Funds'),
      body: ListView(
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
        ],
      ),
    );
  }
}
