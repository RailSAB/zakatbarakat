import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_on_livestock_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class LivestockPage extends ConsumerStatefulWidget {
  const LivestockPage({super.key});

  @override
  ConsumerState<LivestockPage> createState() => _LivestockState();
}

class _LivestockState extends ConsumerState<LivestockPage> {
  final List<TextEditingController> controllers = [];
  final List<String> elemTitle = ["Sheep/Rams", "Cows/Bulls", "Goats"];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(104, 200, 215, 231),
      appBar: CustomAppBar(pageTitle: 'Zakat on Livestock', appBarHeight: 70),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // This aligns items along the vertical axis
            children: <Widget>[
              const SizedBox(height: 20),
              title(),
              const SizedBox(height: 20),
              notificationBox(),
              const SizedBox(height: 20),
              body(),
              const SizedBox(height: 20),
              button(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
    );
  }

  Widget title() => const Text(
        'Zakat on Livestock',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

  Widget notificationBox() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 176, 216, 253),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          "It does not count if the livestock is used for work, riding; "
          "the animal was harmed; the owner has NOT fed the herd on his own for more than 7 months",
          style: TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ref
              .read(zakatOnLivestockProvider.notifier)
              .setSheep(setValues(controllers[0].text));
          ref
              .read(zakatOnLivestockProvider.notifier)
              .setCows(setValues(controllers[1].text));
          ref
              .read(zakatOnLivestockProvider.notifier)
              .setGoats(setValues(controllers[2].text));
          Navigator.pushNamed(context, '/livestock2');
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(400, 60),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        for (int i = 0; i < controllers.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: enterField(controllers[i], elemTitle[i], elemTitle[i]),
          )
      ],
    );
  }

  Widget enterField(
      TextEditingController controller, String text, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) return null;
            if (!RegExp(r'^[+-]?[0-9]+$').hasMatch(value) && value.isNotEmpty) {
              return 'Please enter only digits';
            }
            if (int.parse(value) <= 0 && value.isNotEmpty) {
              return 'Please enter a positive integer';
            }
            if (type == "Sheep/Rams" && int.parse(value) > 588) {
              return 'Maximum number of sheep is 588';
            }
            if (type == "Cows/Bulls" && int.parse(value) > 109) {
              return 'Maximum number of cows is 109';
            }
            if (type == "Goats" && int.parse(value) > 588) {
              return 'Maximum number of goats is 588';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Enter value',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  int setValues(String value) {
    if (value.isEmpty) {
      return 0;
    }
    return int.parse(value);
  }
}
