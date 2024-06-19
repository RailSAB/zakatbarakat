import 'package:flutter/material.dart';

class LivestockPage extends StatefulWidget {
  const LivestockPage({super.key});

  @override
  State<LivestockPage> createState() => _LivestockState();
}

class _LivestockState extends State<LivestockPage> {

  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livestock Page'),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // This aligns items along the vertical axis
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: title(),
        ),
        //body
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: button(),
        ),
      ],
    )
    )
    );
  }

  Widget title() => const Text('Zakat on Livestock', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

  Widget notificationBox(){
    return Container(
      width: 324,
      height: 84,
      decoration: BoxDecoration(
              color: Colors.grey, 
              borderRadius: BorderRadius.circular(20), 
            ),
      child: const Center(
        child: 
            Text("It does not count if the livestock is used for work, riding; "
            "the animal was harmed; the owner has NOT fed the herd on his own for more than 7 months",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,),
            )
      );

  }

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/livestock2');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Continue', style: TextStyle(fontSize: 24),),);
  }

  /*
----------------------------------- body methods that don't yet work ---------------------------------------------

 Widget body(){
    return Column(
      children: [enterField('Sheep/Rams', 40), enterField('Cows/Bulls', 30), enterField('Goats', 40)]
    );
  }

  Widget enterField(String title, int nisab){
    return Column(
      children: [ 
        Text(title),
        Text('Nisab $nisab heads'),
        Row(children: [const Text('Amount'), textField()],)]
          );
      
  }

  Widget textField(){
    return TextField(
      controller: numberController,
      decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Enter amount'),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
    );
  }

------------------------------------------------------------------------------------------------------------------
  */
}