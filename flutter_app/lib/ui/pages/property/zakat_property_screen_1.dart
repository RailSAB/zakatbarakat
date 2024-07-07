import 'dart:convert';
import 'package:flutter/material.dart';
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
  }

  @override
  void dispose() {
    gold_controller.dispose();
    cash_controller.dispose();
    bank_card_controller.dispose();
    silver_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(pageTitle: 'Zakat on Property', appBarHeight: 115),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.calculate),
        ),
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
                        Row(children: [
                          const Text('Money',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Money'),
                                    content: const Text(
                                      'Specify your savings on bank cards, in cash, in cryptocurrency',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'cash',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Debt',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Debt'),
                                    content: const Text(
                                      'Debts are deducted from the property if they have to be paid within the next 12 months',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'taxesValue',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Shares',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Shares'),
                                    content: const Text(
                                      'Shares purchased for resale',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'stocksForResaling',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Income',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Income'),
                                    content: const Text(
                                      'Income from investments, if deferred in the form of savings',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'incomeFromStocks',
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //________________________PROPERTY________________________
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Property for sale',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Property for sale'),
                                    content: const Text(
                                      'Bought without the intention of resale, but the first steps towards this have been taken',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'purchasedNotForResaling',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Spent Property',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Spent property'),
                                    content: const Text(
                                      'Was used or spent after payment of zakat became obligatory.\n\nDO NOT COUNT, if stolen or lost',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'usedAfterNisab',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Income',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Income'),
                                    content: const Text(
                                      'Income from premises for rent or sale',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'rentMoney',
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
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
                        const Text('Silver',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'silverJewellery',
                        ),
                        const SizedBox(height: 25),
                        const Text('Gold',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'goldJewellery',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Purchased goods',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Purchased goods'),
                                    content: const Text(
                                      'Goods purchased for sale at market price',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'purchasedProductForResaling',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Unfinished products',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Unfinished products'),
                                    content: const Text(
                                      'Not fully produced products at market price',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'unfinishedProduct',
                        ),
                        const SizedBox(height: 25),
                        Row(children: [
                          const Text('Produced goods',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Produced goods'),
                                    content: const Text(
                                      'Goods produced for sale at production price',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 30, 128, 208))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                        const SizedBox(height: 10),
                        const DynamicTable(
                          taskId: '1',
                          category: 'producedProductForResaling',
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
        "purchased_product_for_resaling":
            ref.read(zakatOnPropertyProvider).purchasedProductForResaling,
        "unfinished_product":
            ref.read(zakatOnPropertyProvider).unfinishedProduct,
        "produced_product_for_resaling":
            ref.read(zakatOnPropertyProvider).producedProductForResaling,
        "purchased_not_for_resaling":
            ref.read(zakatOnPropertyProvider).purchasedNotForResaling,
        "used_after_nisab": ref.read(zakatOnPropertyProvider).usedAfterNisab,
        "rent_money": ref.read(zakatOnPropertyProvider).rentMoney,
        "stocks_for_resaling":
            ref.read(zakatOnPropertyProvider).stocksForResaling,
        "income_from_stocks":
            ref.read(zakatOnPropertyProvider).incomeFromStocks,
        "taxes_value": ref.read(zakatOnPropertyProvider).taxesValue,
        "currency": ref.read(currencyProvider).code,
      }),
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        ref
            .read(zakatOnPropertyProvider.notifier)
            .setZakatValue(jsonResponse['zakat_value']);
        ref
            .read(zakatOnPropertyProvider.notifier)
            .setNisabStatus(jsonResponse['nisab_value']);
        // swap to overall page
      });
    }
  }
}
