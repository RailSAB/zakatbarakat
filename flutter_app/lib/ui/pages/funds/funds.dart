import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_app/ui/widgets/fund.dart';

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
    const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQRjRWlxq_UNhGIR8lGhUM_Y_j2GGhCl2C2w&s'),
    const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkhR_5doNqp1UIsChEMf9wqlY-CIZ467MC3w&s'),
    const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlhj8Vt8KOEQ9w6ZK68QUUIg_YTNYMVqAhQg&s'),
    const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8a7rctG1u6nhnnDU3vrfW4b9pUiQwaKIkrg&s'),
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
      appBar: AppBar(
        title:  Center(child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 50,),
            ElevatedButton(
              onPressed: (){
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (Currency currency) {
                    ref.read(currencyProvider.notifier).setCurrency(currency);
                  },
                  favorite: ['USD', 'RUB'],
                  currencyFilter: CurrencyModel.currencies.values.toList(),
                );
              }, 
              child: const Text('Choose Currency'),

              )
          ],
        ),
      ),
      ),
      body: ListView(
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
        ],
      ),

    );
  }
}