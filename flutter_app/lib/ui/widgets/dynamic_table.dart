import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//didn't understand why this needs taskID
class DynamicTable extends StatefulWidget {
  final String taskId;
  const DynamicTable({super.key, required this.taskId});

  @override
  State<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends State<DynamicTable> {
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

    FormData formData = FormData.fromMap({});

    // why not MapEntry(name.text, weight.text)?
    for (int i = 0; i < _name.length; i++) {
      formData.fields.add(MapEntry("name[]", _name[i].text));
      formData.fields.add(MapEntry("weight[]", _weight[i].text));
    }

/*
----------------------some kind of API----------------------
  networkRequest(
    context: context,
    requestType: "POST",
    url: "${Urls.billAdd}${widget.taskId}?jhhihu",
    data: formData,
    action: (r) {
      Navigator.pop(context, true);
    }
  );
--------------------------------------------------------------
*/

    return true;
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
                    Navigator.pushNamed(context, '/ushrOverall');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(400, 60),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
