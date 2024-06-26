import 'package:flutter/material.dart';
import 'package:flutter_app/providers/zakat_ushr_provider.dart';
import 'package:flutter_app/ui/widgets/dynamic_table.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        appBar: const CustomAppBar(pageTitle: 'Zakat on Ushr'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: title(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'The land is irrigated',
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 20),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'The land is irrigated naturally (i.e. by rain or lies near a river)',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Ushr land',
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 20),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Lands of Arabs/nations that profess Islam, distributed among Muslims',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Enter your harvest',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // get request to api that dysplays table
              // initial table is empty with 1 row
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: DynamicTable(
                  taskId: '1',
                ), // Include DynamicTable
              ),
            ],
          ),
        ));
  }

  Widget title() => const Text(
        'Zakat on Ushr',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      );

  Widget switcher() {
    bool isSwitched = false;
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
    );
  }
}
