import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(child:Text('Home Page')),
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
      body: Center(
        child:Column(
          children: [ 
          Padding(
          padding: const EdgeInsets.all(32.0),
          child: title(),
        ),
        //body
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buttons(),
        ),
        Padding(padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {Navigator.pushNamed(context, '/funds');},
          child: const Text("View Funds", style: TextStyle(fontSize: 20),),
        )
        ),
        ]
        )
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0,),
    );
  }

  Widget title() => const Text('Calculate Zakat', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

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
                  onPressed: () {Navigator.pushNamed(context, '/property');},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 60)
                  ),
                  child: Image.asset('/Users/anastasiakucumova/swp/zakatcalcteam55/flutter_app/pngtree-vector-property-search-icon-png-image_4015722.jpg', height: 50, width: 50),
                ),
                const SizedBox(height: 10), // Indentation under the button
                const Text("Property", style: TextStyle(fontSize: 20)),
              ],
            ),
            Spacer(), // Creates a free space between the buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.pushNamed(context, '/livestock');},
                  style: ElevatedButton.styleFrom(minimumSize: const Size(100, 60)),
                  child: Image.asset('/Users/anastasiakucumova/swp/zakatcalcteam55/flutter_app/2717675-200.png', height: 50, width: 50),
                ),
                const SizedBox(height: 10), // Indentation under the button
                const Text("Livestock", style: TextStyle(fontSize: 20)),
              ],
            ),
            Spacer(), // Creates a free space between the buttons
            Column(
              children:[
                ElevatedButton(
                onPressed:() {Navigator.pushNamed(context, '/ushr');},
                 style: ElevatedButton.styleFrom(minimumSize: const Size(100,60)),
                 child: Image.asset('/Users/anastasiakucumova/swp/zakatcalcteam55/flutter_app/1070430-200.png',height:50 ,width: 50),
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