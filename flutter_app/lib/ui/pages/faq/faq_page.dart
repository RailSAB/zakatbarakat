// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/itemkb_model.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';
// import 'package:http/http.dart' as http;

// class FAQPage extends ConsumerStatefulWidget {
//   const FAQPage({super.key});

//   @override
//   ConsumerState<FAQPage> createState() => _FAQPageState();
// }

// class _FAQPageState extends ConsumerState<FAQPage> {

//   Future getQuestions() async {
//   final List<QA> _questions = [];
//   final response = await http.get(Uri.parse('http://158.160.153.243:8000/qna/get-questions'));
//   try {
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);

//       for (var item in jsonData) {
//         String headerText = item["question"];
//         String expandedText = item["answer"];

//         _questions.add(QA(
//           headerText: headerText,
//           expandedText: expandedText,
//         ));
//       }
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(pageTitle: 'Frequently Asked Questions', appBarHeight: 70),
//       backgroundColor: const Color.fromARGB(104, 200, 215, 231),
//        body: Padding(
//         padding: const EdgeInsets.all(16.0), // Adjust the padding value as needed
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Aligns the title to the start
//           children: <Widget>[
//             const Text(
//               'Questions and Answers', // Body title
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 30), // Adds some space between the title and the list
//             Expanded(
//               child: FutureBuilder(
//                 future: getData(),
//                 builder: (context, snapshot) {
//                   if(snapshot.connectionState == ConnectionState.done) {
//                     return ListView.builder(
//                       itemCount: _questions.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ExpansionTile(
//                         title: Text(_questions[index].headerText),
//                         children: <Widget>[
//                           ListTile(
//                           title: Text(_questions[index].expandedText),
//                         ),
//                       ],
//                   );
//                   },
//                   );
//                   }
//                   else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 }) 
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(index: 2,),
//     );
//   }


//   Future getData() async {
//     final response = await http.get(Uri.parse('http://158.160.153.243:8000/qna/get-questions'));
//     try {
//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);

//         for (var item in jsonData) {
//           String headerText = item["question"];
//           String expandedText = item["answer"];

//           _data.add(Item(
//             headerText: headerText,
//             expandedText: expandedText,
//           ));
//         }
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(pageTitle: 'Frequently Asked Questions', appBarHeight: 70),
//       backgroundColor: const Color.fromARGB(255, 240, 245, 251),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text(
//               'Questions and Answers',
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 45, 56, 70)),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: FutureBuilder(
//                   future: getData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       if (_data.isEmpty) {
//                         return const Center(child: Text('No FAQ data available.'));
//                       }
//                       return ListView.builder(
//                         itemCount: _data.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Card(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             elevation: 2,
//                             child: ExpansionTile(
//                               title: Text(
//                                 _data[index].headerText,
//                                 style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 47, 61)),
//                               ),
//                               children: <Widget>[
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                                   decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 227, 236, 248),
//                                     borderRadius: BorderRadius.circular(8)
//                                   ),
//                                   child: Text(_data[index].expandedText, style: TextStyle(color: Color.fromARGB(255, 54, 69, 79))),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   }),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(index: 2),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/currency_model.dart';
// import 'package:flutter_app/providers/currency_provider.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:currency_picker/currency_picker.dart';
// import 'package:flutter_app/ui/widgets/footer.dart';
// import 'package:http/http.dart' as http;

// class Item {
//   Item({
//     required this.headerText,
//     required this.expandedText,
//     this.isExpanded = false,
//   });

//   String headerText;
//   String expandedText;
//   bool isExpanded;
// }

// class FAQPage extends ConsumerStatefulWidget {
//   const FAQPage({super.key});

//   @override
//   ConsumerState<FAQPage> createState() => _FAQPageState();
// }

// class _FAQPageState extends ConsumerState<FAQPage> {
//   final List<Item> _data = [];

//   Future getData() async {
//   final response = await http.get(Uri.parse('http://158.160.153.243:8000/qna/get-questions'));
//   try {
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);

//       for (var item in jsonData) {
//         String headerText = item["question"];
//         String expandedText = item["answer"];

//         _data.add(Item(
//           headerText: headerText,
//           expandedText: expandedText,
//         ));
//       }
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(pageTitle: 'Frequently Asked Questions', appBarHeight: 70),
//       backgroundColor: const Color.fromARGB(104, 200, 215, 231),
//        body: Padding(
//         padding: const EdgeInsets.all(16.0), // Adjust the padding value as needed
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Aligns the title to the start
//           children: <Widget>[
//             const Text(
//               'Questions and Answers', // Body title
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 30), // Adds some space between the title and the list
//             Expanded(
//               child: FutureBuilder(
//                 future: getData(),
//                 builder: (context, snapshot) {
//                   if(snapshot.connectionState == ConnectionState.done) {
//                     return ListView.builder(
//                       itemCount: _data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ExpansionTile(
//                         title: Text(_data[index].headerText),
//                         children: <Widget>[
//                           ListTile(
//                           title: Text(_data[index].expandedText),
//                         ),
//                       ],
//                   );
//                   },
//                   );
//                   }
//                   else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 }) 
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(index: 2,),
//     );
//   }
// }