import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(104, 200, 215, 231),
    appBar: CustomAppBar(
      pageTitle: 'Home Page',
      appBarHeight: 70,
    ),
    body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: title(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Закругление углов
                image: DecorationImage(
                  image: AssetImage('images/ashkan-forouzani-xiHAseekqqw-unsplash.jpg'), // Путь к вашему изображению
                  fit: BoxFit.cover, // Обрезка изображения до размеров контейнера
                ),
              ),
              width: double.infinity, // Ширина контейнера равна ширине экрана
              height: 150, // Высота контейнера
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
        ])),
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
      mainAxisAlignment: MainAxisAlignment.center, // Center Alignment
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distributes the space evenly around the buttons
          mainAxisSize: MainAxisSize.min, // Sets the minimum width for the Row
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/property');
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(100, 60)),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
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
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
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
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: Image.asset('images/ushr.png', height: 50, width: 50),
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