// import 'package:flutter/material.dart';
// import 'package:flutter_app/providers/zakat_on_property_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

// class Property2Page extends ConsumerStatefulWidget {
//   const Property2Page({super.key});

//   @override
//   ConsumerState<Property2Page> createState() => _Property2State();
// }

// class _Property2State extends ConsumerState<Property2Page> {
//   List <TextEditingController> controllers = [];
//   List <String> elemTitle = ["Goods purchased for sale\n at market price",
//   "Unfinished products\n at market price",
//   "Goods produced for sale\n at production price",
//   "Shares purchased for resale",
//   "Income from investments,\n if deferred in the form of savings"];

//   final numberController = TextEditingController();

//   @override
//   void initState(){
//     super.initState();
//     for (int i = 0; i < 5; i++) { 
//       controllers.add(TextEditingController());
//     }
//   }
  
//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(pageTitle: 'Zakat on Property'),
//       body: Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween, // This aligns items along the vertical axis
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: title(),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: body(),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: button(),
//         ),
//       ],
//     )
//     )
//     );
//   }

//   Widget title() => const Text('Zakat on Property', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);

//   Widget button(){
//     return ElevatedButton(onPressed: () {
//       ref.read(zakatOnPropertyProvider.notifier).setPurchasedProductForResaling(setValues(controllers[0].text));
//       ref.read(zakatOnPropertyProvider.notifier).setUnfinishedProduct(setValues(controllers[1].text));
//       ref.read(zakatOnPropertyProvider.notifier).setProducedProductForResaling(setValues(controllers[2].text));
//       ref.read(zakatOnPropertyProvider.notifier).setStocksForResaling(setValues(controllers[3].text));
//       ref.read(zakatOnPropertyProvider.notifier).setIncomeFromStocks(setValues(controllers[4].text));
//       Navigator.pushNamed(context, '/property3');
//       }, 
//     style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
//     child: const Text('Continue', style: TextStyle(fontSize: 24),),);
//   }

//   Widget body() {
//   return Column(
//     children: [
//       ...[
//         const Text('Product', style: TextStyle(fontSize: 24)),
//         const SizedBox(height: 20),
//         for (int i = 0; i < 3; i++)
//           enterField(controllers[i], elemTitle[i]),
//         const SizedBox(height: 40),
//         const Text('Stocks', style: TextStyle(fontSize: 24)),
//         const SizedBox(height: 20),
//         for (int i = 3; i < 5; i++)
//           enterField(controllers[i], elemTitle[i])
//       ], // Explicitly converting the Set to a List
//     ],
//   );
// }


//   Widget enterField(TextEditingController controller, String text) {
//   return Column(
//     children: [
//       const SizedBox(height: 10),
//       Row(
//         children: [
//           Text(text, style: const TextStyle(fontSize: 20),),
//           const SizedBox(width: 20),
//           Expanded(child: TextField(controller: controller, 
//           decoration: const InputDecoration(
//                       hintText: 'Enter value',
//                       border: OutlineInputBorder(),
//                       contentPadding: EdgeInsets.all(8),
//                     ),
//                     keyboardType: TextInputType.number,)), 
//         ],
//       ),
//       const SizedBox(height: 20,),
//     ],
//   );
// }

//   int setValues(String value){
//     if(value.isEmpty){
//       return 0;
//     }
//     return int.parse(value);
//   }
// }