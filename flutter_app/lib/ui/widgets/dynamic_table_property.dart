// import 'dart:convert';
// import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

class DynamicTable extends ConsumerStatefulWidget {
  final String taskId;
  final String category;
  final List<CurrencyModel> currencies;
  const DynamicTable(
      {super.key,
      required this.taskId,
      required this.category,
      required this.currencies});

  @override
  ConsumerState<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends ConsumerState<DynamicTable> {
  final List<TextEditingController> _quantity = [];
  final List<CurrencyModel> _currency = [];

  final _formKey = GlobalKey<FormState>();

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

  _addField() {
    setState(() {
      _quantity.add(TextEditingController());
      _currency.add(widget.currencies.first);
    });
  }

  _removeItem(int index) {
    setState(() {
      _quantity.removeAt(index);
      _currency.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                            if (value!.isEmpty) return null;
                            if (!RegExp(r'^[+-]?[0-9]+$').hasMatch(value) &&
                                value.isNotEmpty) {
                              return 'Please enter only digits';
                            }
                            if (int.parse(value) <= 0 && value.isNotEmpty) {
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
                      child: DropdownButton<CurrencyModel>(
                        value: _currency[i],
                        onChanged: (CurrencyModel? newValue) {
                          setState(() {
                            _currency[i] = newValue!;
                          });
                        },
                        items: widget.currencies.map((CurrencyModel currency) {
                          return DropdownMenuItem<CurrencyModel>(
                            value: currency,
                            child: Text(currency.code),
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
    );
  }
}
