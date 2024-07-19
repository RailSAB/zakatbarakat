import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                            child: Image.network(
                                'https://raw.githubusercontent.com/meldilen/deploying/main/assets/images/currency.png'),
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
          ? PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue[50],
                  ),
                  child: TabBar(
                    labelStyle: TextStyle(fontSize: 15),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Color.fromRGBO(21, 101, 192, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    indicatorColor: Color.fromARGB(200, 153, 202, 255),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: <Widget>[
                      Tab(
                        text: "FINANCE",
                      ),
                      Tab(
                        text: "REAL ESTATE",
                      ),
                      Tab(text: "OTHER"),
                    ],
                  ),
                ),
              ))
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
