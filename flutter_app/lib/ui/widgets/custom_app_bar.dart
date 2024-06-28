import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_app/providers/currency_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_picker/currency_picker.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String pageTitle;
  double appBarHeight;

  CustomAppBar(
      {super.key, required this.pageTitle, required this.appBarHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyProvider);

    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        pageTitle,
        textAlign: TextAlign.center,
        // style: const TextStyle(
        //   fontFamily: 'Inter',
        //   fontSize: 25,
        //   fontWeight: FontWeight.w400,
        // ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      onSelect: (Currency currency) {
                        ref
                            .read(currencyProvider.notifier)
                            .setCurrency(currency);
                      },
                      favorite: ['USD', 'RUB'],
                      currencyFilter: CurrencyModel.currencies.values.toList(),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Transform.scale(
                            scale: 0.7,
                            child: Image.asset('images/currency.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  currency.code,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 30),
          ],
        ),
      ],
      toolbarHeight: appBarHeight,
      bottom: pageTitle == "Zakat on Property"
          ? const TabBar(
              labelStyle: TextStyle(fontSize: 15),
              indicatorColor: Color.fromARGB(200, 153, 202, 255),
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  text: "FINANCE",
                ),
                Tab(
                  text: "PROPERTY",
                ),
                Tab(text: "OTHER"),
              ],
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}