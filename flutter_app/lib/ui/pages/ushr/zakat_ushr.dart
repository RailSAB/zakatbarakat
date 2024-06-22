import 'package:flutter/material.dart';

class UshrPage extends StatefulWidget {
  const UshrPage({super.key});

  @override
  State<UshrPage> createState() => _UshrState();
}

class _UshrState extends State<UshrPage> {
final numberController = TextEditingController();

bool isSwitched1 = false;
bool isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ushr Page'),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // This aligns items along the vertical axis
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: title(),
        ),
        // get request to api that dysplays table
        // initial table is empty with 1 row
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: addHarvest(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column( 
            children:[ 
              Row( children: [
              const Text('The land is irrigated', style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
              const SizedBox(width: 20),
              Switch(value: isSwitched1,
                 onChanged: (value) {
                  setState(() {
                  isSwitched1 = value;
                });
              },),
              ],
             ),
             const SizedBox(
              height: 20,
             )
            ,
            const Text('The land is irrigated naturally (i.e. by rain or lies near a river)', style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
          ],
        ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column( 
            children:[ 
              Row( children: [
              const Text('Ushr land', style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
              const SizedBox(width: 20),
              Switch(value: isSwitched2,
                 onChanged: (value) {
                  setState(() {
                  isSwitched2 = value;
                });
              },),
              ],
             ),
             const SizedBox(
              height: 20,
             )
            ,
            const Text('Lands of Arabs/nations that profess Islam, distributed among Muslims', style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
          ],
        ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: button(),
        ),

      ],
    )
    )
    );
  }

  Widget title() => const Text('Zakat on Ushr', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

  Widget button(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/ushrOverall');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Calculate', style: TextStyle(fontSize: 24),),);
  }

  Widget addHarvest(){
    return ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/harvestTable');}, 
    style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
    child: const Text('Edit Harvest', style: TextStyle(fontSize: 24),),);
  }

  Widget switcher(){
    bool isSwitched = false;
    return Switch(value: isSwitched,
     onChanged: (value) {
      setState(() {
        isSwitched = value;
      });
     },);
  }
}