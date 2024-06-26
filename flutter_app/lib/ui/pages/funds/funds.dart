import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/fund.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;

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
    required this.link,
  });

  String name;
  String description;
  NetworkImage logo;
  Uri link;
}

class _FundsState extends ConsumerState<FundsPage> {
  final List<Item> _data = [];

  Future getData() async {
    final response = await http.get(Uri.parse('http://10.90.137.169:8000/funds/get-funds'));
    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        for (var item in jsonData) {
          String name = item["name"];
          String description = item["description"];
          NetworkImage logo = NetworkImage(item["logo_link"]);
          Uri link = Uri.parse(item["link"]);

          _data.add(Item(
            name: name,
            description: description,
            logo: logo,
            link: link,
          ));
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Recommended Funds'),
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
                              url: _data[index].link,
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
}
