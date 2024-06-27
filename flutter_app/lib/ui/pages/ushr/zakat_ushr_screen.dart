import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_ushr_provider.dart';
import 'package:flutter_app/ui/widgets/dynamic_table.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class UshrPage extends ConsumerStatefulWidget {
  const UshrPage({Key? key}) : super(key: key);

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
      appBar: const CustomAppBar(pageTitle: 'Zakat on Ushr'),
      backgroundColor: Color.fromARGB(104, 200, 215, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
                                child: const Text('Close'),
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
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              const Text(
                'Enter your harvest',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const DynamicTable(taskId: '1'),
              ),
              const SizedBox(height: 20),
            
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
    );
  }
}

