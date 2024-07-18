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
  TextEditingController cashController = TextEditingController();
  TextEditingController bankCardController = TextEditingController();
  TextEditingController silverMeasuringUnitController = TextEditingController();
  TextEditingController goldMeasuringUnitController = TextEditingController();
  TextEditingController silverValueController = TextEditingController();
  TextEditingController goldValueController = TextEditingController();
  TextEditingController silverSampleController = TextEditingController();
  TextEditingController goldSampleController = TextEditingController();



  Map<String, List<Map<String, dynamic>>> categoryData = {};
  

   String selectedMeasuringUnitSilver = 'kg';
   String selectedMeasuringUnitGold = 'kg';
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
            backgroundColor:  Colors.blue[800],
            shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), 
      ),
            label: const Text('Calculate', style: TextStyle(fontSize: 18,color: Colors.white)), 
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
              SizedBox(width: 8),  // Add some spacing between text and icon
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text( 'Debt'),
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
              SizedBox(width: 8),  // Add some spacing between text and icon
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text( 'Shares'),
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
              SizedBox(width: 8),  // Add some spacing between text and icon
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text( 'Income'),
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
                        title: const Text(  'Property for sale'),
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
                        title: const Text( 'Spent Property'),
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Enter value',
                  labelStyle: TextStyle(fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 50,
              child: DropdownButtonFormField<String>(
                value: selectedMeasuringUnitSilver,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  labelText: 'Measuring Unit',
                  labelStyle: TextStyle(fontSize: 16),
                ),
                items: ['kg', 'oz', 'g'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedMeasuringUnitSilver = value;
                      silverMeasuringUnitController.text = value;
                    }
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  selectSilverSample(value);
                  silverSampleController.text = value;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedSilverSample),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '999',
                  child: Text('999'),
                ),
                const PopupMenuItem<String>(
                  value: '925/900',
                  child: Text('925/900'),
                ),
                const PopupMenuItem<String>(
                  value: '875/884',
                  child: Text('875/884'),
                ),
                const PopupMenuItem<String>(
                  value: '800',
                  child: Text('800'),
                ),
                const PopupMenuItem<String>(
                  value: '750',
                  child: Text('750'),
                ),
                const PopupMenuItem<String>(
                  value: '600',
                  child: Text('600'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
      
Widget _buildGoldSection() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), 
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                if (!RegExp(r'^[+-]?\d+$').hasMatch(value)) {
                  return 'Please enter only digits';
                }
                if (int.parse(value) <= 0) {
                  return 'Please enter a positive integer';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Enter value',
                labelStyle: TextStyle(fontSize: 16),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 50,
            child: DropdownButtonFormField<String>(
              value: selectedMeasuringUnitGold,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                labelText: 'Measuring Unit',
                labelStyle: TextStyle(fontSize: 16),
              ),
              items: ['kg', 'oz', 'g'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    selectedMeasuringUnitGold = value;
                    goldMeasuringUnitController.text = value;
                  }
                });
              },
            ),
          ),
        ),
         const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  selectGoldSample(value);
                  silverSampleController.text = value;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedGoldSample),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '999/24K',
                  child: Text('999/24K',),
                ),
                const PopupMenuItem<String>(
                  value:  '958',
                  child: Text( '958'),
                ),
                const PopupMenuItem<String>(
                  value: '900/916/22K',
                  child: Text('900/916/22K'),
                ),
                const PopupMenuItem<String>(
                  value:   '850/21K',
                  child: Text(  '850/21K'),
                ),
                const PopupMenuItem<String>(
                  value: '750/18K',
                  child: Text('750/18K'),
                ),
                const PopupMenuItem<String>(
                  value:  '583/585/14K',
                  child: Text( '583/585/14K'),
                ),
                const PopupMenuItem<String>(
                  value:  '500/12K',
                  child: Text( '500/12K'),
                ),
                const PopupMenuItem<String>(
                  value:  '375/9K',
                  child: Text(  '375/9K'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
        
  

Widget _buildOtherTab() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                        title: const Text( 'Unfinished products'),
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