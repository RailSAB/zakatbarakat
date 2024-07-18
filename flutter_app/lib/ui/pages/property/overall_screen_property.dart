import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_app/providers/zakat_on_property_provider.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

class PropertyOverallPage extends ConsumerStatefulWidget {
  const PropertyOverallPage({super.key});

  @override
  ConsumerState<PropertyOverallPage> createState() => _PropertyOverallState();
}

class _PropertyOverallState extends ConsumerState<PropertyOverallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          pageTitle: 'Overall on Property Zakat', appBarHeight: 70),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSummaryCard(),
            buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryCard() {
    final zakatValue = ref.watch(zakatOnPropertyProvider).zakatValue;
    final currencyCode = ref.watch(currencyProvider).code;

    return Center(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Overall:',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                "Overall: ${zakatValue.toStringAsFixed(3)} $currencyCode",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                      zakatValue > 0 ? FontWeight.w500 : FontWeight.w400,
                  color: zakatValue > 0 ? Colors.black87 : Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (zakatValue == 0)
                const Text(
                  "You don't have any zakat",
                  style: TextStyle(fontSize: 24, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(400, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      child: const Text(
        'Go to Home page',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}








// import 'package:flutter_app/providers/currency_provider.dart';
// import 'package:flutter_app/providers/zakat_on_property_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/ui/widgets/custom_app_bar.dart';

// class PropertyOverallPage extends ConsumerStatefulWidget {
//   const PropertyOverallPage({super.key});

//   @override
//   ConsumerState<PropertyOverallPage> createState() => _PropertyOverallState();
// }

// class _PropertyOverallState extends ConsumerState<PropertyOverallPage> {
//   final numberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(pageTitle: 'Overall on Property Zakat', appBarHeight: 70),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment
//               .spaceBetween, // This aligns items along the vertical axis
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: sum(ref.watch(zakatOnPropertyProvider).zakatValue),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: button(),
//             ),
//           ],
//         )));
//   }

//   Widget title() => const Text(
//         'Overall:',
//         style: TextStyle(fontSize: 30),
//       );

//   Widget sum(double number) {
//     if (number == 0) {
//       return const Text(
//         style: TextStyle(fontSize: 30),
//         "You don't have any zakat",
//         textAlign: TextAlign.center,
//       );
//     }
//     return Text(
//       style: const TextStyle(fontSize: 30),
//       "Overall: $number ${ref.watch(currencyProvider).code}",
//       textAlign: TextAlign.center,
//     );
//   }

//   Widget button() {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.pushNamed(context, '/home');
//       },
//       style: ElevatedButton.styleFrom(minimumSize: const Size(400, 60)),
//       child: const Text(
//         'Go to Home page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

