// import 'dart:convert';
// import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

class DynamicTable extends ConsumerStatefulWidget {
  final String taskId;
  final String category;
  const DynamicTable({super.key, required this.taskId, required this.category});

  @override
  ConsumerState<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends ConsumerState<DynamicTable> {
  final List<TextEditingController> _quantity = [];
  final List<CurrencyModel> _currency = [];

  final _formKey = GlobalKey<FormState>();

  final _scrollController = ScrollController();

  //style
  double textFieldBottomPadding = 15,
      textFieldRounded = 10,
      inputFieldPadding = 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addField();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _addField() {
    setState(() {
      _quantity.add(TextEditingController());
      _currency.add(CurrencyModel(name: 'Russian Ruble', code: "RUB"));
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _removeItem(int index) {
    setState(() {
      _quantity.removeAt(index);
      _currency.removeAt(index);
    });
  }

  bool _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();

    for (int i = 0; i < _quantity.length; i++) {
      ref
          .read(zakatOnPropertyProvider.notifier)
          .add(widget.category, _currency[i], int.parse(_quantity[i].text));
    }

    return true;
  }

  Future<void> performPostRequest() async {
    // final url = Uri.parse('http://158.160.153.243:8000/calculator/zakat-ushr');
    // final headers = {'Content-Type': 'application/json'};

    // final body = jsonEncode({
    //   "crops": ref.read(zakatUshrProvider).crops.map((crop) => crop.toJson()).toList(),
    //   "is_ushr_land": ref.read(zakatUshrProvider).isUshrLand,
    //   "is_irrigated": ref.read(zakatUshrProvider).isIrregated,
    // });

    // try {
    //   final response = await http.post(url, headers: headers, body: body);

    //   if (response.statusCode == 200) {
    //     Map<String, dynamic> parsedJson = jsonDecode(response.body);
    //     List<dynamic> crops = parsedJson['zakat_ushr_value'];
    //     List<Crop> cropList = crops.map((json) {
    //       return Crop(
    //         type: json['type'],
    //         quantity: json['quantity'].round(),
    //       );
    //     }).toList();
    //     ref.read(zakatUshrProvider.notifier).setCrops(cropList);
    //   } else {
    //     print('Request failed with status: ${response.statusCode}.');
    //   }
    //   Navigator.pushNamed(context, '/ushrOverall');
    // } catch (e) {
    //   print('Error: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            for (int i = 0; i < _quantity.length; i++)
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.remove_circle),
                      onTap: () {
                        _removeItem(i);
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 220,
                        height: 50,
                        child: TextFormField(
                            controller: _quantity[i],
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter value';
                              } else {
                                return null;
                              }
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
                        child: DropdownMenu<CurrencyModel>(
                          initialSelection: _currency[i],
                          onSelected: (CurrencyModel? value) {
                            setState(() {
                              if (value != null) {
                                _currency[i] = value;
                              }
                            });
                          },
                          dropdownMenuEntries:
                              CurrencyModel.currencies.entries.map((entry) {
                            return DropdownMenuEntry<CurrencyModel>(
                              value: CurrencyModel(
                                  name: entry.key, code: entry.value),
                              label: entry.value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                )
              ]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _addField();
                  },
                  child: const Icon(Icons.add_circle),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
