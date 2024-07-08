import 'dart:convert';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/ui/widgets/news_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_app/ui/widgets/currency_selection.dart';

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

  String name;
  String description;
  Uri link;
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<News> newsArticles = [];

  Future getData() async {
    final response =
        await http.get(Uri.parse('http://158.160.153.243:8000/news/get-news'));
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
        print(newsArticles.length);
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
      backgroundColor: const Color.fromARGB(104, 200, 215, 231),
      appBar: CustomAppBar(
        pageTitle: 'Home Page',
        appBarHeight: 70,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: title(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage(
                      'images/ashkan-forouzani-xiHAseekqqw-unsplash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: buttons(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/funds');
              },
              style: ButtonStyle(
                minimumSize:
                    WidgetStateProperty.all(const Size(double.infinity, 50)),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text("View Funds",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          // Adding a bold "News" text
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'News',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Using ListView.builder to dynamically generate list items for news articles
          //
          SingleChildScrollView(
            child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newsArticles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            NewsCard(
                              name: newsArticles[index].name,
                              description: newsArticles[index].description,
                              link: newsArticles[index].link,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        index: 0,
      ),
    );
  }

  Widget title() => const Text(
        'Calculate Zakat',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      );

  Widget buttons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurrencySelectionScreen(
                            onCurrencySelected: (selectedCurrencies) {},
                          ),
                        ),
                      );
                      //Navigator.pushNamed(context, '/property');
                    },
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(100, 60)),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: Image.asset('images/property.png',
                        height: 45, width: 45),
                  ),
                  const SizedBox(height: 10),
                  const Text("Property", style: TextStyle(fontSize: 20)),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/livestock');
                    },
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(100, 60)),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: Image.asset('images/lifestock.png',
                        height: 50, width: 50),
                  ),
                  const SizedBox(height: 10), // Indentation under the button
                  const Text("Livestock", style: TextStyle(fontSize: 20)),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ushr');
                    },
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(100, 60)),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child:
                        Image.asset('images/ushr.png', height: 50, width: 50),
                  ),
                  const SizedBox(height: 10),
                  const Text("Ushr", style: TextStyle(fontSize: 20)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
