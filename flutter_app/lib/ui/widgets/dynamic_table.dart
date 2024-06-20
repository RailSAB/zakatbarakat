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

//style
double textFieldBottomPadding = 15,
    textFieldRounded = 10,
    inputFieldPadding = 2;

final _formKey = GlobalKey<FormState>();

@override
void initState(){
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    _addField();
  }
  );
}

_addField(){
  setState(() {
    _name.add(TextEditingController());
    _weight.add(TextEditingController());
  });
}

_removeItem(int index){
  setState(() {
    _name.removeAt(index);
    _weight.removeAt(index);
  });
}

bool _submit(){
  final isValid = _formKey.currentState!.validate();
  if(!isValid){
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("add Harvest items"),
        backgroundColor: Colors.deepPurple,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(30),
        //   )
        // )
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(onTap: () {_addField();},
              child: const Icon(Icons.add_circle),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                for(int i = 0; i < _name.length; i++)
                  Column( children: [
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
                Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(inputFieldPadding),
                      child: TextFormField(
                        controller: _name[i],
                        validator: (value) {
                          if (value == ''){
                            return 'Please enter some text';
                          } else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              textFieldRounded),),
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
                        if (value == '' || value == "0"){
                          return 'Required';
                        } else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            textFieldRounded),),
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
                ]
                  )
        ],
        ),
      ),
      MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
        color: Colors.deepPurple,
        onPressed: (){
          if(_submit()){
            Navigator.pushNamed(context, '/ushr');
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10),
              Text("Save",
               style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          )
    ),
      ), ],
  ),
    ),
    );
  }
}