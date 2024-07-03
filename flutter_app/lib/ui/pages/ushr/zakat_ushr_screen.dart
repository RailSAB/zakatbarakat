import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_ushr_provider.dart';
import 'package:flutter_app/ui/widgets/dynamic_table_ushr.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class UshrPage extends ConsumerStatefulWidget {
  const UshrPage({super.key});

  @override
  ConsumerState<UshrPage> createState() => _UshrState();
}

class _UshrState extends ConsumerState<UshrPage> {
  final numberController = TextEditingController();

  bool isSwitched1 = false;
  bool isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      appBar: CustomAppBar(pageTitle: 'Zakat on Ushr', appBarHeight: 70),
      backgroundColor: const Color.fromARGB(104, 200, 215, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildIrrigatedSwitch(),
              const SizedBox(height: 20),
              _buildUshrLandSwitch(),
              const SizedBox(height: 20),
              _buildHarvestInputTitle(),
              const SizedBox(height: 20),
              _buildDynamicTableContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Zakat on Ushr',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('What is Ushr?'),
                  content: const Text(
                    'Ushr is a form of Zakat that needs to be paid based on agricultural produce. It is important to specify certain details about the land and harvest to calculate the correct amount.',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close',style: TextStyle(color: Color.fromARGB(255, 30, 128, 208))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildIrrigatedSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Is the land irrigated?',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Switch(
              value: isSwitched1,
              onChanged: (value) {
                setState(() {
                  isSwitched1 = value;
                  ref.read(zakatUshrProvider.notifier).setIrregated(value);
                });
              },
              activeColor: Colors.white,
              activeTrackColor: const Color.fromARGB(255, 125, 204, 246),
              inactiveThumbColor: const Color.fromARGB(60, 134, 132, 132),
              inactiveTrackColor: Colors.white,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Text(
            'The land is irrigated naturally (i.e. by rain or lies near a river)',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildUshrLandSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Is it Ushr land?',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Switch(
              value: isSwitched2,
              onChanged: (value) {
                setState(() {
                  isSwitched2 = value;
                  ref.read(zakatUshrProvider.notifier).setUshrLand(value);
                });
              },
               activeColor: Colors.white,
              activeTrackColor: const Color.fromARGB(255, 125, 204, 246),
              inactiveThumbColor: const Color.fromARGB(60, 134, 132, 132),
              inactiveTrackColor: Colors.white,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Text(
            'Ushr land refers to lands of Arabs/nations that profess Islam, distributed among Muslims',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildHarvestInputTitle() {
    return const Text(
      'Enter your harvest',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildDynamicTableContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const DynamicTable(taskId: '1'),
    );
  }
}


    