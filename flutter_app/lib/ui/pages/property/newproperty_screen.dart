import 'dart:convert';
import 'package:flutter_app/ui/widgets/jewelry_dynami_table.dart';
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
  TextEditingController cashController = TextEditingController();
  TextEditingController bankCardController = TextEditingController();
  TextEditingController silverMeasuringUnitController = TextEditingController();
  TextEditingController goldMeasuringUnitController = TextEditingController();
  TextEditingController silverValueController = TextEditingController();
  TextEditingController goldValueController = TextEditingController();
  TextEditingController silverSampleController = TextEditingController();
  TextEditingController goldSampleController = TextEditingController();

  Map<String, List<Map<String, dynamic>>> categoryData = {};

  String selectedMeasuringUnitSilver = 'g';
  String selectedMeasuringUnitGold = 'g';
  String selectedSilverSample = '999';
  String selectedGoldSample = '999';
  void selectSilverSample(String unit) {
    setState(() {
      selectedSilverSample = unit;
    });
  }

  void _saveAllData() {
    categoryData.forEach((category, data) {
      ref.read(zakatOnPropertyProvider.notifier).setAny(category, data);
    });
  }

  void selectGoldSample(String unit) {
    setState(() {
      selectedGoldSample = unit;
    });
  }

  Future<void> calculateZakat() async {
    _saveAllData();

    final zakatData = ref.read(zakatOnPropertyProvider);
    const String apiUrl =
        'https://weaviatetest.onrender.com/calculator/zakat-property';

    Map<String, dynamic> requestBody = {
      "cash": zakatData.cash
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "cash_on_bank_cards": zakatData.cashOnBankCards
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "silver_jewelry": zakatData.silverJewellery.map((item) => {
        "measurement_unit": item['measurement_unit'],
        "value": item['quantity'],
        "qarat": item['qarat'],
      }).toList()
      ,
      "gold_jewelry": zakatData.goldJewellery.map((item) => {
        "measurement_unit": item['measurement_unit'],
        "value": item['quantity'],
        "qarat": item['qarat'],
      }).toList()
      ,
      "purchased_product_for_resaling": zakatData.purchasedProductForResaling
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "unfinished_product": zakatData.unfinishedProduct
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "produced_product_for_resaling": zakatData.producedProductForResaling
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "purchased_not_for_resaling": zakatData.purchasedNotForResaling
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "used_after_nisab": zakatData.usedAfterNisab
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "rent_money": zakatData.rentMoney
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "stocks_for_resaling": zakatData.stocksForResaling
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "income_from_stocks": zakatData.incomeFromStocks
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
      "taxes_value": zakatData.taxesValue
          .map((item) => {
                "currency_code": item['currency'].code,
                "value": item['quantity']
              })
          .toList(),
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
        ref
            .read(zakatOnPropertyProvider.notifier)
            .setZakatValue(jsonResponse['zakat_value']);
        ref
            .read(zakatOnPropertyProvider.notifier)
            .setNisabStatus(jsonResponse['nisab_value']);
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
        appBar: CustomAppBar(pageTitle: 'Zakat on Property', appBarHeight: 155),
        backgroundColor: Colors.grey[200],
        body: TabBarView(
          children: [
            _buildFinanceTab(),
            _buildRealEstateTab(),
            _buildOtherTab(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: 200,
            child: FloatingActionButton.extended(
              onPressed: () {
                calculateZakat();
              },
              backgroundColor: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              label: const Text('Calculate',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
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
                onDataChanged: (data) {
                  setState(() {
                    categoryData['cash'] = data;
                  });
                },
                initialData: categoryData['cash']),
            const SizedBox(height: 25),
            _buildDebtSection(),
            const SizedBox(height: 10),
            DynamicTable(
                taskId: '1',
                category: 'taxesValue',
                currencies: widget.selectedCurrencies,
                initialData: categoryData['taxesValue'],
                onDataChanged: (data) {
                  setState(() {
                    categoryData['taxesValue'] = data;
                  });
                }),
            const SizedBox(height: 25),
            _buildSharesSection(),
            const SizedBox(height: 10),
            DynamicTable(
                taskId: '1',
                category: 'stocksForResaling',
                currencies: widget.selectedCurrencies,
                initialData: categoryData['stocksForResaling'],
                onDataChanged: (data) {
                  setState(() {
                    categoryData['stocksForResaling'] = data;
                  });
                }),
            const SizedBox(height: 25),
            _buildIncomeSection(),
            const SizedBox(height: 10),
            DynamicTable(
                taskId: '1',
                category: 'incomeFromStocks',
                currencies: widget.selectedCurrencies,
                initialData: categoryData['incomeFromStocks'],
                onDataChanged: (data) {
                  setState(() {
                    categoryData['incomeFromStocks'] = data;
                  });
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMoneySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Money',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Money'),
                          content: const Text(
                            'Specify your savings on bank cards, in cash, in cryptocurrency',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Debt',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8), // Add some spacing between text and icon
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Debt'),
                          content: const Text(
                            'Debts are deducted from the property if they have to be paid within the next 12 months',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Shares',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8), // Add some spacing between text and icon
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Shares'),
                          content: const Text(
                            'Shares purchased for resale',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Income',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8), // Add some spacing between text and icon
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Income'),
                          content: const Text(
                            'Income from investments, if deferred in the form of savings',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                onDataChanged: (data) {
                  setState(() {
                    categoryData['purchasedNotForResaling'] = data;
                  });
                }),
            const SizedBox(height: 25),
            _buildSpentPropertySection(),
            const SizedBox(height: 10),
            DynamicTable(
                taskId: '1',
                category: 'usedAfterNisab',
                currencies: widget.selectedCurrencies,
                initialData: categoryData['usedAfterNisab'],
                onDataChanged: (data) {
                  setState(() {
                    categoryData['usedAfterNisab'] = data;
                  });
                }),
            const SizedBox(height: 25),
            _buildIncomeFromRentSection(),
            const SizedBox(height: 10),
            DynamicTable(
                taskId: '1',
                category: 'rentMoney',
                currencies: widget.selectedCurrencies,
                initialData: categoryData['rentMoney'],
                onDataChanged: (data) {
                  setState(() {
                    categoryData['rentMoney'] = data;
                  });
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyForSaleSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Property for sale',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Property for sale'),
                          content: const Text(
                            'Bought without the intention of resale, but the first steps towards this have been taken',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpentPropertySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Spent Property',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Spent Property'),
                          content: const Text(
                            'Was used or spent after payment of zakat became obligatory.\n\nDO NOT COUNT, if stolen or lost',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeFromRentSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Income from Rent',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Income from Rent'),
                          content: const Text(
                            'Income from premises for rent or sale',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSilverSection() {
    return DynamicTableJewelry(
      category: 'silver',
      initialData: categoryData['silverJewellery'],
      onDataChanged: (data) {
       setState(() {
          categoryData['silverJewellery'] = data;
        });
      },
    );
  }

  Widget _buildGoldSection() {
    return DynamicTableJewelry(
      category: 'gold',
      initialData: categoryData['goldJewellery'],
      onDataChanged: (data) {
        setState(() {
          categoryData['goldJewellery'] = data;
        });
      },
    );
  }

  Widget _buildOtherTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Silver',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSilverSection(),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Gold',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              onDataChanged: (data) {
                setState(() {
                  categoryData['purchasedProductForResaling'] = data;
                });
              },
            ),
            const SizedBox(height: 25),
            _buildUnfinishedProductsSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'unfinishedProduct',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['unfinishedProduct'],
              onDataChanged: (data) {
                setState(() {
                  categoryData['unfinishedProduct'] = data;
                });
              },
            ),
            const SizedBox(height: 25),
            _buildProducedProductForResailingSection(),
            const SizedBox(height: 10),
            DynamicTable(
              taskId: '1',
              category: 'producedProductForResaling',
              currencies: widget.selectedCurrencies,
              initialData: categoryData['producedProductForResaling'],
              onDataChanged: (data) {
                setState(() {
                  categoryData['producedProductForResaling'] = data;
                });
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchasedGoodsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Purchased goods',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Purchased goods'),
                          content: const Text(
                            'Goods purchased for sale at market price',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnfinishedProductsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Unfinished products',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Unfinished products'),
                          content: const Text(
                            'Not fully produced products at market price',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProducedProductForResailingSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Produced goods',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Produced goods'),
                          content: const Text(
                            'Goods produced for sale at production price',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 30, 128, 208),
                                  fontWeight: FontWeight.w600,
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
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
