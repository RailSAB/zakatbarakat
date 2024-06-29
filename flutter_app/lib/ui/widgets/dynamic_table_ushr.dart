import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:flutter_app/models/zakat_ushr_model.dart';
import 'package:flutter_app/providers/zakat_ushr_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

//didn't understand why this needs taskID
class DynamicTable extends ConsumerStatefulWidget {
  final String taskId;
  const DynamicTable({super.key, required this.taskId});

  @override
  ConsumerState<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends ConsumerState<DynamicTable> {
  final List<TextEditingController> _name = [];
  final List<TextEditingController> _weight = [];

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

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _addField() {
    setState(() {
      _name.add(TextEditingController());
      _weight.add(TextEditingController());
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _removeItem(int index) {
    setState(() {
      _name.removeAt(index);
      _weight.removeAt(index);
    });
  }

  bool _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();

    // FormData formData = FormData.fromMap({});

    // why not MapEntry(name.text, weight.text)?
    for (int i = 0; i < _name.length; i++) {
      // formData.fields.add(MapEntry("name[]", _name[i].text));
      // formData.fields.add(MapEntry("weight[]", _weight[i].text));
      ref.read(zakatUshrProvider.notifier).addCrop(Crop(type: _name[i].text, quantity: int.parse(_weight[i].text)));
    }

    return true;
  }


  Future<void> performPostRequest() async {

    final url = Uri.parse('http://158.160.153.243:8000/calculator/zakat-ushr');
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "crops": ref.read(zakatUshrProvider).crops.map((crop) => crop.toJson()).toList(),
      "is_ushr_land": ref.read(zakatUshrProvider).isUshrLand,
      "is_irrigated": ref.read(zakatUshrProvider).isIrregated,
    }); 

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        List<dynamic> crops = parsedJson['zakat_ushr_value'];
        List<Crop> cropList = crops.map((json) {
          return Crop(
            type: json['type'],
            quantity: json['quantity'].round(),
          );
        }).toList();
        ref.read(zakatUshrProvider.notifier).setCrops(cropList);
      } else {
        print('Request failed with status: ${response.statusCode}.'); 
      }
      Navigator.pushNamed(context, '/ushrOverall');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            for (int i = 0; i < _name.length; i++)
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
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
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(inputFieldPadding),
                        child: TextFormField(
                          controller: _name[i],
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter some text';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(textFieldRounded),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            
                            labelText: 'Name',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(inputFieldPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _weight[i],
                          validator: (value) {
                            if (value == '' || value == "0") {
                              return 'Required';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(textFieldRounded),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            labelText: 'Weight',
                            
                          ),
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
                InkWell(
                  onTap: () {
                    _addField();
                  },
                  child: const Icon(Icons.add_circle),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    performPostRequest();
                  }
                },
                style: ButtonStyle(
                   minimumSize: MaterialStateProperty.all(Size(400, 60)), 
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 24,color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
