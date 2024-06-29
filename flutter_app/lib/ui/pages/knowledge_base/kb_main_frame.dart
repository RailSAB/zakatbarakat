import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/footer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/ui/widgets/article.dart';
import 'package:flutter_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_app/ui/pages/knowledge_base/json_item.dart';

class KBPage extends ConsumerStatefulWidget {
  const KBPage({super.key});

  @override
  ConsumerState<KBPage> createState() => _KBState();
}

class _KBState extends ConsumerState<KBPage> {
  late Future<List<Item>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getData(); // Fetch data once
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(pageTitle: 'Knowledge Base', appBarHeight: 70,),
    backgroundColor: const Color.fromARGB(104, 200, 215, 231),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  }
                  List<Item> items = snapshot.data?? []; // Use snapshot.data directly
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          const SizedBox(height: 5,),
                          Article(
                            id: items[index].id,
                            tags: items[index].tags,
                            title: items[index].title,
                            text: items[index].text,
                            content: items[index].content,
                          ),
                          const SizedBox(height: 5,),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
        ],
      ),
    ),
    bottomNavigationBar: const CustomBottomNavBar(index: 1),
  );
}

}
