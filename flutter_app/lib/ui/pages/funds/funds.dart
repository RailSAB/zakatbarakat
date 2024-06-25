import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/fund.dart';
<<<<<<< HEAD
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
=======
import 'package:http/http.dart' as http;
>>>>>>> 5fa12152a376219c1e3c17aaaa615cecdcd4ebde

class FundsPage extends ConsumerStatefulWidget {
  const FundsPage({super.key});

  @override
  ConsumerState<FundsPage> createState() => _FundsState();
}

class Item {
  Item({
    required this.name,
    required this.description,
    required this.logo,
    //required this.link,
  });

  String name;
  String description;
  NetworkImage logo;
  //Uri link;
}

class _FundsState extends ConsumerState<FundsPage> {
<<<<<<< HEAD
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
=======
  final List<Item> _data = [];

  Future getData() async {
    final response = await http.get(Uri.parse('https://freetestapi.com/api/v1/books?limit=5'));
    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        for (var item in jsonData) {
          String name = item["title"];
          String description = item["description"];
          NetworkImage logo = NetworkImage(item["cover_image"]);
          //Uri link = Uri.parse(item["link"]);

          _data.add(Item(
            name: name,
            description: description,
            logo: logo,
            //link: link,
          ));
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
>>>>>>> 5fa12152a376219c1e3c17aaaa615cecdcd4ebde

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 30,),
              ElevatedButton(
                onPressed: () {
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
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding around the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Recommended Funds', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 20), // Replaced SizedBox with Padding
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            const SizedBox(height: 5,),
                            Fund(
                              title: _data[index].name,
                              description: _data[index].description,
                              image: _data[index].logo,
                              //url: _data[index].link,
                            ),
                            const SizedBox(height: 5,),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            ),
            const SizedBox(height: 20), // Replaced SizedBox with Padding
            button(),
            const SizedBox(height: 20), // Replaced SizedBox with Padding
          ],
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: () { Navigator.pushNamed(context, '/home'); },
      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 60)), // Adjusted for full width
      child: const Text('Go to Home page', style: TextStyle(fontSize: 24)),
    );
  }
>>>>>>> 5fa12152a376219c1e3c17aaaa615cecdcd4ebde
}
