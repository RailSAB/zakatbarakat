import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/dynamic_table_property.dart';
import 'package:http/http.dart' as http;

class PropertyPage extends ConsumerStatefulWidget {
  const PropertyPage({super.key});

  @override
  ConsumerState<PropertyPage> createState() => _PropertyState();
}

class _PropertyState extends ConsumerState<PropertyPage> {
  TextEditingController cash_controller = TextEditingController();
  TextEditingController bank_card_controller = TextEditingController();
  TextEditingController silver_controller = TextEditingController();
  TextEditingController gold_controller = TextEditingController();

  List<String> elemTitle = ["Cash", "Bank card", "Silver", "Gold"];
  final numberController = TextEditingController();
  


  @override
  void initState() {
    super.initState();
    // for (int i = 0; i < 4; i++) {
    //   controllers.add(TextEditingController());
    // }
    
  }

  @override
  void dispose() {
    gold_controller.dispose();
    cash_controller.dispose();
    bank_card_controller.dispose();
    silver_controller.dispose();
    // for (var controller in controllers) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(pageTitle: 'Zakat on Property', appBarHeight: 115),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: const Icon(Icons.calculate),
        )
        ,
        body: TabBarView(
          children: <Widget>[
            //________________________FINANCE________________________
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        const Text('MONEY',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text("Cash",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'cash',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text("Bank card",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'cashOnBankCards',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text('DEPT',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text(
                                    "Debts are deducted from the property if they have to be paid within the next 12 months.",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'taxesValue',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text('STOCKS',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text("Shares purchased for resale",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'stocksForResaling',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text(
                                    "Income from investments, if deferred in the form of savings",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'incomeFromStocks',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //________________________PROPERTY________________________
            Stack(
              children: [
                Positioned(
                  left: 50,
                  right: 50,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 155,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(126, 224, 224, 224),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Text(
                                  "Bought without the intention of resale, but the first steps towards this have been taken",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(width: 33),
                            Expanded(
                              child: DynamicTable(
                                taskId: '1',
                                category: 'purchasedNotForResaling',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 155,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(126, 224, 224, 224),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                      "Was used or spent after payment of zakat became obligatory",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 10),
                                  Text(
                                    "(if stolen or lost, do not count)",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 33),
                            Expanded(
                              child: DynamicTable(
                                taskId: '1',
                                category: 'usedAfterNisab',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 155,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(126, 224, 224, 224),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Text(
                                  "Income from premises for rent or sale",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(width: 33),
                            Expanded(
                              child: DynamicTable(
                                taskId: '1',
                                category: 'rentMoney',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //________________________OTHER________________________
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        const Text('JEWELLERY',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text("Silver",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'silverJewellery',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text("Gold",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'goldJewellery',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text('PRODUCT',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text(
                                    "Goods purchased for sale at market price",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'purchasedProductForResaling',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text(
                                    "Unfinished products at market price",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'unfinishedProduct',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 155,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(126, 224, 224, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Text(
                                    "Goods produced for sale at production price",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(width: 33),
                              Expanded(
                                child: DynamicTable(
                                  taskId: '1',
                                  category: 'producedProductForResaling',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> calculateZakat() async {
    final response = await http.post(
      Uri.parse("http://158.160.153.243:8000/calculator/zakat-property"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "cash": ref.read(zakatOnPropertyProvider).cash,
        "cash_on_bank_cards": ref.read(zakatOnPropertyProvider).cashOnBankCards,
        "silver_jewelry": ref.read(zakatOnPropertyProvider).silverJewellery,
        "gold_jewelry": ref.read(zakatOnPropertyProvider).goldJewellery,
        "purchased_product_for_resaling": ref
            .read(zakatOnPropertyProvider)
            .purchasedProductForResaling,
        "unfinished_product": ref.read(zakatOnPropertyProvider).unfinishedProduct,
        "produced_product_for_resaling": ref
            .read(zakatOnPropertyProvider)
            .producedProductForResaling,
        "purchased_not_for_resaling": ref
            .read(zakatOnPropertyProvider)
            .purchasedNotForResaling,
        "used_after_nisab": ref.read(zakatOnPropertyProvider).usedAfterNisab,
        "rent_money": ref.read(zakatOnPropertyProvider).rentMoney,
        "stocks_for_resaling": ref
            .read(zakatOnPropertyProvider)
            .stocksForResaling,
        "income_from_stocks": ref
            .read(zakatOnPropertyProvider)
            .incomeFromStocks,
        "taxes_value": ref.read(zakatOnPropertyProvider).taxesValue,
        "currency": ref.read(currencyProvider).code,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        ref.read(zakatOnPropertyProvider.notifier).setZakatValue(jsonResponse['zakat_value']);
        ref.read(zakatOnPropertyProvider.notifier).setNisabStatus(jsonResponse['nisab_value']);
        // swap to overall page
      });
    }
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: const Color.fromARGB(104, 200, 215, 231),
  //       appBar: const CustomAppBar(pageTitle: 'Zakat on Property'),
  //       body: SafeArea(
  //           child: Column(children: [
  //         const Padding(
  //           padding: EdgeInsets.all(100.0),
  //           child: Column(children: [
  //             Text('ZAKAT',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 24,
  //                   shadows: <Shadow>[
  //                     Shadow(
  //                       offset: Offset(2.0, 2.0),
  //                       blurRadius: 2.0,
  //                       color: Colors.grey,
  //                     ),
  //                   ],
  //                 )),
  //             Text('on property',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                 )),
  //           ]),
  //         ),
  //         Expanded(
  //             child: Column(
  //           children: [

  //           ],
  //         ))
  //       ]))

  //       // body: Center(
  //       //     child: Column(
  //       //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       //   children: <Widget>[
  //       //     Padding(
  //       //       padding: const EdgeInsets.all(16.0),
  //       //       child: body(),
  //       //     ),
  //       //     Padding(
  //       //       padding: const EdgeInsets.all(16.0),
  //       //       child: button(),
  //       //     ),
  //       //   ],
  //       // )
  //       // )
  //       // body: ,
  //       );
  // }

//   Widget button() {
//     return ElevatedButton(
//       onPressed: () {
//         ref
//             .read(zakatOnPropertyProvider.notifier)
//             .setCash(setValues(controllers[0].text));
//         ref
//             .read(zakatOnPropertyProvider.notifier)
//             .setCashOnBankCards(setValues(controllers[1].text));
//         ref
//             .read(zakatOnPropertyProvider.notifier)
//             .setGoldJewellery(setValues(controllers[3].text));
//         ref
//             .read(zakatOnPropertyProvider.notifier)
//             .setSilverJewellery(setValues(controllers[2].text));

//         Navigator.pushNamed(context, '/property2');
//       },
//       style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
//       child: const Text(
//         'Continue',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }

//   Widget body() {
//     return Column(
//       children: [
//         ...[
//           const Text('Money', style: TextStyle(fontSize: 24)),
//           const SizedBox(height: 20),
//           for (int i = 0; i < 2; i++) enterField(controllers[i], elemTitle[i]),
//           const SizedBox(height: 40),
//           const Text('Jewlery', style: TextStyle(fontSize: 24)),
//           const SizedBox(height: 20),
//           for (int i = 2; i < 4; i++) enterField(controllers[i], elemTitle[i])
//         ], // Explicitly converting the Set to a List
//       ],
//     );
//   }

//   Widget enterField(TextEditingController controller, String text) {
//     return Column(
//       children: [
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               text,
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//                 child: TextField(
//               controller: controller,
//               decoration: const InputDecoration(
//                 hintText: 'Enter value',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(8),
//               ),
//               keyboardType: TextInputType.number,
//             )),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }

//   int setValues(String value) {
//     if (value.isEmpty) {
//       return 0;
//     }
//     return int.parse(value);
//   }
// }
}
