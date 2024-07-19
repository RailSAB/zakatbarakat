import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/models/zakat_on_property_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

class PropertyOverallPage extends ConsumerStatefulWidget {
  const PropertyOverallPage({super.key});

  @override
  ConsumerState<PropertyOverallPage> createState() => _PropertyOverallState();
}

class _PropertyOverallState extends ConsumerState<PropertyOverallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          pageTitle: 'Overall on Property Zakat', appBarHeight: 70),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSummaryCard(),
            buildZakatTotal(),
            buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryCard() {
    final zakatData = ref.watch(zakatOnPropertyProvider);

    return Center(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary of Selected Items:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...buildSummaryItems(zakatData),
              const SizedBox(height: 20),
              if (zakatData.zakatValue == 0)
                const Text(
                  "You don't have any zakat",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildSummaryItems(ZakatOnPropertyModel zakatData) {
  List<Widget> summaryItems = [];

  if (zakatData.cash.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Money', zakatData.cash));
  }
  if (zakatData.goldJewellery.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Gold', zakatData.goldJewellery, isGold: true));
  }

  if (zakatData.silverJewellery.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Silver', zakatData.silverJewellery, isGold: true));
  }

  if (zakatData.purchasedProductForResaling.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Purchased goods', zakatData.purchasedProductForResaling));
  }

  if (zakatData.unfinishedProduct.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Unfinished products', zakatData.unfinishedProduct));
  }

  if (zakatData.producedProductForResaling.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Produced goods', zakatData.producedProductForResaling));
  }

  if (zakatData.purchasedNotForResaling.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Property for sale', zakatData.purchasedNotForResaling));
  }

  if (zakatData.usedAfterNisab.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Spent Property', zakatData.usedAfterNisab));
  }

  if (zakatData.rentMoney.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Income from Rent', zakatData.rentMoney));
  }

  if (zakatData.stocksForResaling.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Shares', zakatData.stocksForResaling));
  }

  if (zakatData.incomeFromStocks.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Income from Stocks', zakatData.incomeFromStocks));
  }

  if (zakatData.taxesValue.isNotEmpty) {
    summaryItems.add(buildCategoryCard('Debt', zakatData.taxesValue));
  }

  return summaryItems;
}

Widget buildCategoryCard(String title, List<Map<String, dynamic>> items, {bool isGold = false}) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            buildItemDetails(items, isGold),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

String buildItemDetails(List<Map<String, dynamic>> items, bool isGold) {
  if(isGold){
    return items.map((item) {
      return "${item['quantity']} ${item['measurement_unit']}, ${item['qarat']}";
    }).join(',\n');
  }
  return items.map((item) {
      return "${item['quantity']} ${(item['currency'] as CurrencyModel).code}";
  }).join(',\n');
}


  Widget buildZakatTotal() {
    final zakatValue = ref.watch(zakatOnPropertyProvider).zakatValue;
    final currencyCode = ref.watch(currencyProvider).code;

    return Center(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Overall Zakat Total:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "${zakatValue.toStringAsFixed(3)} $currencyCode",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: zakatValue > 0 ? FontWeight.w500 : FontWeight.w400,
                  color: zakatValue > 0 ? Colors.black87 : Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(400, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      child: const Text(
        'Go to Home page',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}









// import 'package:flutter_app/providers/currency_provider.dart';
// import 'package:flutter_app/providers/zakat_on_property_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

// class PropertyOverallPage extends ConsumerStatefulWidget {
//   const PropertyOverallPage({super.key});

//   @override
//   ConsumerState<PropertyOverallPage> createState() => _PropertyOverallState();
// }

// class _PropertyOverallState extends ConsumerState<PropertyOverallPage> {
//   final numberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(pageTitle: 'Overall on Property Zakat', appBarHeight: 70),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment
//               .spaceBetween, // This aligns items along the vertical axis
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: sum(ref.watch(zakatOnPropertyProvider).zakatValue),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: button(),
//             ),
//           ],
//         )));
//   }

//   Widget title() => const Text(
//         'Overall:',
//         style: TextStyle(fontSize: 30),
//       );

//   Widget sum(double number) {
//     if (number == 0) {
//       return const Text(
//         style: TextStyle(fontSize: 30),
//         "You don't have any zakat",
//         textAlign: TextAlign.center,
//       );
//     }
//     return Text(
//       style: const TextStyle(fontSize: 30),
//       "Overall: $number ${ref.watch(currencyProvider).code}",
//       textAlign: TextAlign.center,
//     );
//   }

//   Widget button() {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.pushNamed(context, '/home');
//       },
//       style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
//       child: const Text(
//         'Go to Home page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

