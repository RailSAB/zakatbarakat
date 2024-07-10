import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicTable extends ConsumerStatefulWidget {
  final String taskId;
  final String category;
  final List<CurrencyModel> currencies;
  final List<Map<String, dynamic>>? initialData;
  final Function(List<Map<String, dynamic>>) onDataChanged;

  const DynamicTable({
    super.key,
    required this.taskId,
    required this.category,
    required this.currencies,
    this.initialData,
    required this.onDataChanged,
  });

  @override
  ConsumerState<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends ConsumerState<DynamicTable> {
  late List<TextEditingController> _quantity;
  late List<CurrencyModel> _currency;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.initialData != null && widget.initialData!.isNotEmpty) {
      _quantity = widget.initialData!
          .map((data) => TextEditingController(text: data['quantity'].toString()))
          .toList();
      _currency = widget.initialData!
          .map((data) => data['currency'] as CurrencyModel)
          .toList();
    } else {
      _quantity = [TextEditingController()];
      _currency = [widget.currencies.first];
    }
  }

  void _addField() {
    setState(() {
      _quantity.add(TextEditingController());
      _currency.add(widget.currencies.first);
    });
    _updateData();
  }

  void _removeItem(int index) {
    setState(() {
      _quantity.removeAt(index);
      _currency.removeAt(index);
    });
    _updateData();
  }

  void _updateData() {
    if (_formKey.currentState!.validate()) {
      List<Map<String, dynamic>> data = [];
      for (int i = 0; i < _quantity.length; i++) {
        data.add({
          'quantity': int.tryParse(_quantity[i].text) ?? 0,
          'currency': _currency[i],
        });
      }
      widget.onDataChanged(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          for (int i = 0; i < _quantity.length; i++)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.remove_circle),
                      onTap: () => _removeItem(i),
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
                            if (!RegExp(r'^[+-]?[0-9]+$').hasMatch(value)) {
                              return 'Please enter only digits';
                            }
                            if (int.parse(value) <= 0) {
                              return 'Please enter a positive integer';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _updateData();
                          },
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
                        child: DropdownButton<CurrencyModel>(
                          value: _currency[i],
                          onChanged: (CurrencyModel? newValue) {
                            setState(() {
                              _currency[i] = newValue!;
                            });
                            _updateData();
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
                const Divider(thickness: 1),
              ],
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _addField,
                child: const Icon(Icons.add_circle),
              )
            ],
          ),
        ],
      ),
    );
  }
}