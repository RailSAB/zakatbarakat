import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/dynamic_table_property.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyPage extends ConsumerStatefulWidget {
  final List<CurrencyModel> selectedCurrencies;
  const PropertyPage({super.key, required this.selectedCurrencies});

  @override
  ConsumerState<PropertyPage> createState() => _PropertyState();
}

class _PropertyState extends ConsumerState<PropertyPage> {
  TextEditingController silverMeasuringUnitController = TextEditingController();
  TextEditingController goldMeasuringUnitController = TextEditingController();
  TextEditingController silverValueController = TextEditingController();
  TextEditingController goldValueController = TextEditingController();


  Map<String, List<Map<String, dynamic>>> categoryData = {};
  

   String selectedMeasuringUnitSilver = 'kg';
   String selectedMeasuringUnitGold = 'kg';


  void _saveAllData() {
  categoryData.forEach((category, data) {
    ref.read(zakatOnPropertyProvider.notifier).setAny(category, data);
  });
  }

  Future<void> calculateZakat() async {
    _saveAllData();

    final zakatData = ref.read(zakatOnPropertyProvider);
    const String apiUrl = 'https://weaviatetest.onrender.com/calculator/zakat-property';

    Map<String, dynamic> requestBody = {
      "cash": zakatData.cash.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "cash_on_bank_cards": zakatData.cashOnBankCards.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "silver_jewelry": {
        "measurement_unit": selectedMeasuringUnitSilver,
        "value": int.tryParse(silverValueController.text) ?? 0,
        "qarat": "999"
      },
      "gold_jewelry": {
        "measurement_unit": selectedMeasuringUnitGold,
        "value": int.tryParse(goldValueController.text) ?? 0,
        "qarat": "999"
      },
      "purchased_product_for_resaling": zakatData.purchasedProductForResaling.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "unfinished_product": zakatData.unfinishedProduct.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "produced_product_for_resaling": zakatData.producedProductForResaling.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "purchased_not_for_resaling": zakatData.purchasedNotForResaling.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "used_after_nisab": zakatData.usedAfterNisab.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "rent_money": zakatData.rentMoney.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "stocks_for_resaling": zakatData.stocksForResaling.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "income_from_stocks": zakatData.incomeFromStocks.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "taxes_value": zakatData.taxesValue.map((item) => {
        "currency_code": item['currency'].code,
        "value": item['quantity']
      }).toList(),
      "currency": ref.read(currencyProvider).code
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ref.read(zakatOnPropertyProvider.notifier).setZakatValue(jsonResponse['zakat_value']);
        ref.read(zakatOnPropertyProvider.notifier).setNisabStatus(jsonResponse['nisab_value']);
        Navigator.pushNamed(context, '/propertyoverall');
      } else {
        print('Failed to calculate zakat. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calculating zakat: $e');
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _saveAllData();
    goldMeasuringUnitController.dispose();
    goldValueController.dispose();
    silverMeasuringUnitController.dispose();
    silverValueController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(pageTitle: 'Zakat on Property', appBarHeight: 115),
        body: TabBarView(
          children: [
            _buildFinanceTab(),
            _buildRealEstateTab(),
            _buildOtherTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              calculateZakat();
            },
            child: const Icon(Icons.calculate),
          ),
      ),
      
    );
  }
  
  Widget _buildFinanceTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            _buildMoneySection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1', 
              category: 'cash', 
              currencies: widget.selectedCurrencies, 
              onDataChanged: (data){
                setState(() {
                  categoryData['cash'] = data;
                });
              },
              initialData: categoryData['cash']
            ),
            const SizedBox(height: 25),
            _buildDebtSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'taxesValue',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['taxesValue'],
              onDataChanged: (data){
                setState(() {
                  categoryData['taxesValue'] = data;
                });
              }
            ),
            const SizedBox(height: 25),
            _buildSharesSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'stocksForResaling',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['stocksForResaling'],
              onDataChanged: (data){
                setState(() {
                  categoryData['stocksForResaling'] = data;
                });
              }
            ),
            const SizedBox(height: 25),
            _buildIncomeSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'incomeFromStocks',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['incomeFromStocks'],
              onDataChanged: (data){
                setState(() {
                  categoryData['incomeFromStocks'] = data;
                });
              }
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMoneySection() {
    return Row(
      children: [
        const Text(
          'Money',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
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
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 128, 208),
                        ),
                      ),
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
      ],
    );
  }

  Widget _buildDebtSection() {
    return Row(
      children: [
        const Text(
          'Debt',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
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
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 128, 208),
                        ),
                      ),
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
      ],
    );
  }

  Widget _buildSharesSection() {
    return Row(
      children: [
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
      ],
    );
  }

  Widget _buildIncomeSection() {
    return Row(
      children: [
        const Text(
          'Income',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text('Income'),
                  content: const Text(
                    'Income from investments, if deferred in the form of savings',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 128, 208),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildRealEstateTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            _buildPropertyForSaleSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'purchasedNotForResaling',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['purchasedNotForResaling'],
              onDataChanged: (data){
                setState(() {
                  categoryData['purchasedNotForResaling'] = data;
                });
              }
            ),
            const SizedBox(height: 25),
            _buildSpentPropertySection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'usedAfterNisab',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['usedAfterNisab'],
              onDataChanged: (data){
                setState(() {
                  categoryData['usedAfterNisab'] = data;
                });
              }
            ),
            const SizedBox(height: 25),
            _buildIncomeFromRentSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'rentMoney',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['rentMoney'],
              onDataChanged: (data){
                setState(() {
                  categoryData['rentMoney'] = data;
                });
              }
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyForSaleSection() {
    return Row(
      children: [
        const Text(
          'Property for sale',
          style: TextStyle(fontSize: 30),
        ),
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
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Color(0xFF1E58D0)),
                      ),
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
      ],
    );
  }

  Widget _buildSpentPropertySection(){
    return Row(children: [
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
    ]);
  }

  Widget _buildIncomeFromRentSection() {
    return Row(
      children: [
        const Text(
          'Income from Rent',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Income from Rent'),
                  content: const Text(
                    'Income from premises for rent or sale',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 128, 208),
                        ),
                      ),
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
      ],
    );
  }

  Widget _buildOtherTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Silver',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                _buildSilverSection(),
                const SizedBox(height: 25),
                const Text('Gold',
                  style: TextStyle(
                    fontSize: 30,
                  )
                ),
                const SizedBox(height: 10),
                _buildGoldSection(),
                const SizedBox(height: 25),
                _buildPurchasedGoodsSection(),
                const SizedBox(height: 10),
                DynamicTable(
                  taskId: '1',
                  category: 'purchasedProductForResaling',
                  currencies: widget.selectedCurrencies,
                  initialData: categoryData['purchasedProductForResaling'],
                  onDataChanged: (data){
                    setState(() {
                      categoryData['purchasedProductForResaling'] = data;
                    });
                  }
                ),
                const SizedBox(height: 25),
                _buildUnfinishedProductsSection(),
                const SizedBox(height: 10),
                DynamicTable(
                  taskId: '1',
                  category: 'unfinishedProduct',
                  currencies: widget.selectedCurrencies,
                  initialData: categoryData['unfinishedProduct'],
                  onDataChanged: (data){
                    setState(() {
                      categoryData['unfinishedProduct'] = data;
                    });
                  }
                ),
                const SizedBox(height: 25),
                _buildProducedProductForResailingSection(),
                const SizedBox(height: 10),
                DynamicTable(
                  taskId: '1',
                  category: 'producedProductForResaling',
                  currencies: widget.selectedCurrencies,
                  initialData: categoryData['producedProductForResaling'],
                  onDataChanged: (data){
                    setState(() {
                      categoryData['producedProductForResaling'] = data;
                    });
                  }
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildSilverSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 220,
            height: 50,
            child: TextFormField(
              controller: silverValueController,
              validator: (value) {
                if (value!.isEmpty) return null;
                if (!RegExp(r'^[+-]?\d+$').hasMatch(value)) {
                  return 'Please enter only digits';
                }
                if (int.parse(value) <= 0) {
                  return 'Please enter a positive integer';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter value',
                labelStyle: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ),
        const SizedBox(width: 35),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 50,
            child: DropdownMenu<String>(
              menuHeight: 200,
              width: 300,
              initialSelection: selectedMeasuringUnitSilver,
              label: const Text('Measuring Unit'),
              onSelected: (value) {
                setState(() {
                  if (value != null) {
                    selectedMeasuringUnitSilver = value;
                    silverMeasuringUnitController.text = value;
                  }
                });
              },
              dropdownMenuEntries: const [
                'kg',
                'oz',
                'g',
              ].map<DropdownMenuEntry<String>>(
                (String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                    style: MenuItemButton.styleFrom(
                      foregroundColor: const Color.fromARGB(
                          255, 0, 0, 0),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildGoldSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 220,
            height: 50,
            child: TextFormField(
                controller: goldValueController,
                validator: (value) {
                  if (value!.isEmpty) return null;
                  if (!RegExp(r'^[+-]?[0-9]+$')
                          .hasMatch(value) &&
                      value.isNotEmpty) {
                    return 'Please enter only digits';
                  }
                  if (int.parse(value) <= 0 &&
                      value.isNotEmpty) {
                    return 'Please enter a positive integer';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter value',
                    labelStyle: TextStyle(fontSize: 13))),
          ),
        ),
        const SizedBox(width: 35),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 50,
            child: DropdownMenu<String>(
              menuHeight: 200,
              width: 300,
              initialSelection: selectedMeasuringUnitGold,
              requestFocusOnTap: true,
              label: const Text('Measuring Unit'),
              onSelected: (String? value) {
                setState(() {
                  if (value != null) {
                    selectedMeasuringUnitGold = value;
                    goldMeasuringUnitController.text =
                        value;
                  }
                });
              },
              dropdownMenuEntries: <String>[
                'kg',
                'oz',
                'g'
              ].map<DropdownMenuEntry<String>>(
                  (String value) {
                return DropdownMenuEntry<String>(
                  value: value,
                  label: value,
                  style: MenuItemButton.styleFrom(
                    foregroundColor: const Color.fromARGB(
                        255, 0, 0, 0),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurchasedGoodsSection(){
    return Row(children: [
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
    ]);
  }

  Widget _buildUnfinishedProductsSection() {
    return Row(
      children: [
        const Text(
          'Unfinished products',
          style: TextStyle(fontSize: 30),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text('Unfinished products'),
                  content: const Text(
                    'Not fully produced products at market price',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProducedProductForResailingSection() {
    return Row(
      children: [
        const Text(
          'Produced goods',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Produced goods'),
                  content: const Text(
                    'Goods produced for sale at production price',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 128, 208),
                        ),
                      ),
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
      ],
    );
  }
}