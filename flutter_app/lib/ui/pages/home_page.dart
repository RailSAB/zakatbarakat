import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/currency_selection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/news_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class News {
  News({
    required this.name,
    required this.description,
    required this.link,
  });

  final String name;
  final String description;
  final Uri link;
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<News> newsArticles = [];

  Future getData() async {
    final response = await http
        .get(Uri.parse('https://weaviatetest.onrender.com/news/get-news'));
    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        for (var item in jsonData) {
          String name = item["name"];
          String description = item["body"];
          Uri link = Uri.parse(item["source_link"]);

          newsArticles.add(News(
            name: name,
            description: description,
            link: link,
          ));
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        pageTitle: 'Home Page',
        appBarHeight: 70,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: title(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://raw.githubusercontent.com/meldilen/deploying/main/assets/images/ashkan-forouzani-xiHAseekqqw-unsplash.jpg'),
                    //image: AssetImage('images/ashkan-forouzani-xiHAseekqqw-unsplash.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: buttons(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/funds');
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(10),
                ),
                child: const Text(
                  "View Funds",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'News',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            if (newsArticles.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsArticles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0), // Добавляем расстояние
                    child: NewsCard(
                      name: newsArticles[index].name,
                      description: newsArticles[index].description,
                      link: newsArticles[index].link,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        index: 0,
      ),
    );
  }

  Widget title() => const Text(
        'Calculate Zakat',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      );

  Widget buttons() {
    return Center(
      child: Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          _createButton(
              'Property',
              'https://raw.githubusercontent.com/meldilen/deploying/main/assets/images/property.png',
              '/property'),
          _createButton(
              'Livestock',
              'https://raw.githubusercontent.com/meldilen/deploying/main/assets/images/lifestock.png',
              '/livestock'),
          _createButton(
              'Ushr',
              'https://raw.githubusercontent.com/meldilen/deploying/main/assets/images/ushr.png',
              '/ushr'),
        ],
      ),
    );
  }

  Widget _createButton(String text, String assetPath, String route) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            if (route == '/property') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrencySelectionScreen(
                    onCurrencySelected: (selectedCurrencies) {},
                  ),
                ),
              );
            } else {
              Navigator.pushNamed(context, route);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(100, 90),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 10,
            padding: const EdgeInsets.all(16),
          ),
          child: Image.network(assetPath, height: 50, width: 50),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ],
    );
  }
}
