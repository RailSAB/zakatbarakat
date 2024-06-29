import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:http/http.dart' as http;

class Item {
  Item({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });

  String headerText;
  String expandedText;
  bool isExpanded;
}

class FAQPage extends ConsumerStatefulWidget {
  const FAQPage({super.key});

  @override
  ConsumerState<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends ConsumerState<FAQPage> {
  final List<Item> _data = [];

  Future getData() async {
  final response = await http.get(Uri.parse('http://158.160.153.243:8000/qna/get-questions'));
  try {
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        String headerText = item["question"];
        String expandedText = item["answer"];

        _data.add(Item(
          headerText: headerText,
          expandedText: expandedText,
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
      appBar: CustomAppBar(pageTitle: 'Frequently Asked Questions', appBarHeight: 70),
      backgroundColor: const Color.fromARGB(104, 200, 215, 231),
       body: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding value as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns the title to the start
          children: <Widget>[
            const Text(
              'Questions and Answers', // Body title
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30), // Adds some space between the title and the list
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                        title: Text(_data[index].headerText),
                        children: <Widget>[
                          ListTile(
                          title: Text(_data[index].expandedText),
                        ),
                      ],
                  );
                  },
                  );
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }) 
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 2,),
    );
  }

}