import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';


class CurrencySelectionScreen extends StatefulWidget {
  final Function(List<String>) onCurrencySelected;

  const CurrencySelectionScreen({super.key, required this.onCurrencySelected});

  @override
  State<CurrencySelectionScreen> createState() =>
      _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
  List<CurrencyModel> selectedCurrencies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageTitle: "Select Currencies", appBarHeight: 70),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for currency',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: CurrencyModel.currencies.length,
              itemBuilder: (context, index) {
                final currencyName =
                    CurrencyModel.currencies.keys.elementAt(index);
                final currencyCode =
                    CurrencyModel.currencies.values.elementAt(index);
                if (_searchController.text.isEmpty ||
                    currencyName
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase())) {
                  return CheckboxListTile(
                    title: Text(currencyName),
                    value: selectedCurrencies.any((currency) {
                      return currency.name == currencyName;
                    }),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedCurrencies.add(CurrencyModel(
                              name: currencyName, code: currencyCode));
                        } else {
                          selectedCurrencies.removeWhere((currency) {
                            return currency.name == currencyName;
                          });
                        }
                      });
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/property',
                    arguments: selectedCurrencies);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 50),
                padding: EdgeInsets.all(0), 
                backgroundColor: const Color.fromARGB(255, 176, 216, 253),
              ),
              child: Container(
                width: 200, 
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'SAVE',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/currency_model.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';


// class CurrencySelectionScreen extends StatefulWidget {
//   final Function(List<String>) onCurrencySelected;

//   const CurrencySelectionScreen({super.key, required this.onCurrencySelected});

//   @override
//   State<CurrencySelectionScreen> createState() =>
//       _CurrencySelectionScreenState();
// }

// class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
//   List<CurrencyModel> selectedCurrencies = [];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(pageTitle: "Select Currencies", appBarHeight: 70),
//       backgroundColor:  Colors.grey[200],

//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search for currency',
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: (value) {
//                 setState(() {});
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: CurrencyModel.currencies.length,
//               itemBuilder: (context, index) {
//                 final currencyName =
//                     CurrencyModel.currencies.keys.elementAt(index);
//                 final currencyCode =
//                     CurrencyModel.currencies.values.elementAt(index);
//                 if (_searchController.text.isEmpty ||
//                     currencyName
//                         .toLowerCase()
//                         .contains(_searchController.text.toLowerCase())) {
//                   return CheckboxListTile(
//                     title: Text(currencyName),
//                     value: selectedCurrencies.any((currency) {
//                       return currency.name == currencyName;
//                     }),
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == true) {
//                           selectedCurrencies.add(CurrencyModel(
//                               name: currencyName, code: currencyCode));
//                         } else {
//                           selectedCurrencies.removeWhere((currency) {
//                             return currency.name == currencyName;
//                           });
//                         }
//                       });
//                     },
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: ElevatedButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/property',
//               arguments: selectedCurrencies);
//         },

//         style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(50, 50),
//                 padding: EdgeInsets.all(0), 
//                 backgroundColor: const Color.fromARGB(255, 176, 216, 253),
//               ),
//               child: Container(
//                 width: 200, 
//                 height: 50,
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'SAVE',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//       ),
//         );
//       }
// }
