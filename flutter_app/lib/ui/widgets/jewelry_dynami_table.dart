import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicTableJewelry extends ConsumerStatefulWidget {
  final String category; // 'gold' or 'silver'
  final List<Map<String, dynamic>>? initialData;
  final Function(List<Map<String, dynamic>>) onDataChanged;

  const DynamicTableJewelry({
    super.key,
    required this.category,
    this.initialData,
    required this.onDataChanged,
  });

  @override
  ConsumerState<DynamicTableJewelry> createState() => _DynamicTableJewelryState();
}

class _DynamicTableJewelryState extends ConsumerState<DynamicTableJewelry> {
  late List<TextEditingController> _quantityControllers;
  late List<String> _measurementUnits;
  late List<String> _qaratValues;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.initialData != null && widget.initialData!.isNotEmpty) {
      _quantityControllers = widget.initialData!
          .map((data) => TextEditingController(text: data['quantity'].toString()))
          .toList();
      _measurementUnits = widget.initialData!
          .map((data) => data['measurement_unit'] as String)
          .toList();
      _qaratValues = widget.initialData!
          .map((data) => data['qarat'] as String)
          .toList();
    } else {
      _quantityControllers = [TextEditingController()];
      _measurementUnits = ['g']; 
      _qaratValues = [widget.category == 'gold' ? '999/24K' : '999']; 
    }
  }

  void _addField() {
    setState(() {
      _quantityControllers.add(TextEditingController());
      _measurementUnits.add('g');
      _qaratValues.add(widget.category == 'gold' ? '999/24K' : '999');
    });
    _updateData();
  }

  void _removeItem(int index) {
    setState(() {
      _quantityControllers.removeAt(index);
      _measurementUnits.removeAt(index);
      _qaratValues.removeAt(index);
    });
    _updateData();
  }

  void _updateData() {
    if (_formKey.currentState!.validate()) {
      List<Map<String, dynamic>> data = [];
      for (int i = 0; i < _quantityControllers.length; i++) {
        data.add({
          'quantity': int.tryParse(_quantityControllers[i].text) ?? 0,
          'measurement_unit': _measurementUnits[i],
          'qarat': _qaratValues[i],
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
          for (int i = 0; i < _quantityControllers.length; i++)
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
                          controller: _quantityControllers[i],
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
                            labelText: 'Enter quantity',
                            labelStyle: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 35),
                    Expanded(
                      flex: 1,
                      child: DropdownButton<String>(
                        value: _measurementUnits[i],
                        onChanged: (String? newValue) {
                          setState(() {
                            _measurementUnits[i] = newValue!;
                          });
                          _updateData();
                        },
                        items: ['g', 'kg', 'oz'].map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 35),
                    Expanded(
                      flex: 1,
                      child: DropdownButton<String>(
                        value: _qaratValues[i],
                        onChanged: (String? newValue) {
                          setState(() {
                            _qaratValues[i] = newValue!;
                          });
                          _updateData();
                        },
                        items: (widget.category == 'gold'
                            ? ['999/24K', '958', '900/916/22K','850/21K', '750/18K','583/585/14K', '500/12K','375/9K'] 
                            : ['999','925/900', '875/884', '800','750', '600']).map((String qarat) {
                          return DropdownMenuItem<String>(
                            value: qarat,
                            child: Text(qarat),
                          );
                        }).toList(), 
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

