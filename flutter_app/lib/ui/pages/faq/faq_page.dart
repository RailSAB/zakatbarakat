import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_app/ui/widgets/footer.dart';

class FAQPage extends ConsumerStatefulWidget {
  const FAQPage({super.key});

  @override
  ConsumerState<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends ConsumerState<FAQPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(child:Text('Q&A Page')),
            ElevatedButton(
              onPressed: (){
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (Currency currency) {
                    ref.read(currencyProvider.notifier).setCurrency(currency);
                  },
                  favorite: ['USD', 'RUB'],
                  currencyFilter: CurrencyModel.currencies.values.toList(),
                );
              }, 
              child: const Text('Choose Currency'),

              )
          ],
        ),
      ),
      ),
      // body:
      bottomNavigationBar: const CustomBottomNavBar(index: 2,),
    );
  }

}