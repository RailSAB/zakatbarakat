import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_picker/currency_picker.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String pageTitle;

  const CustomAppBar({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyProvider);

    return AppBar(
      backgroundColor: Colors.white,
      title: Text(pageTitle),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
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
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ClipOval(
                      child: Transform.scale(
                        scale: 0.7,
                        child: Image.asset('currency.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 15),
            Text(currency.code),
            const SizedBox(width: 30),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
