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
      _currency.add(CurrencyModel(name: 'Russian Ruble', code: "RUB"));
    });
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

  @override
  Widget build(BuildContext context) {
    return Form(
      // return Container(
      //   padding: const EdgeInsets.all(16.0),
      //   height: 155,
      //   decoration: BoxDecoration(
      //     color: const Color.fromARGB(126, 224, 224, 224),
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   child: Form(
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
                        child: DropdownMenu<String>(
                          initialSelection: _currency[i].code,
                          onSelected: (String? value) {
                            setState(() {
                              if (value != null) {
                                _currency[i] = CurrencyModel(
                                    name: _currency[i].name, code: value);
                              }
                            });
                          },
                          dropdownMenuEntries:
                              CurrencyModel.currencies.entries.map((entry) {
                            return DropdownMenuEntry<String>(
                              value: entry.key,
                              label: entry.value,
                            );
                          }).toList(),
                        )
                        // child: DropdownMenu<CurrencyModel>(
                        //   initialSelection: _currency[i],
                        //   onSelected: (CurrencyModel? value) {
                        //     setState(() {
                        //       if (value != null) {
                        //         _currency[i] = value;
                        //       }
                        //     });
                        //   },
                        //   dropdownMenuEntries:
                        //       CurrencyModel.currencies.entries.map((entry) {
                        //     return DropdownMenuEntry<CurrencyModel>(
                        //       value: CurrencyModel(
                        //           name: entry.key, code: entry.value),
                        //       label: entry.value,
                        //     );
                        //   }).toList(),
                        // ),
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
        // ),
      ),
    );
  }
}
