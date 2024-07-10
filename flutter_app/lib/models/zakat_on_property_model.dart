import 'package:flutter/material.dart';
import 'package:flutter_app/models/currency_model.dart';

class ZakatOnPropertyModel {
  final List<Map<String, dynamic>> cash;
  final List<Map<String, dynamic>> cashOnBankCards;
  final List<Map<String, dynamic>> goldJewellery;
  final List<Map<String, dynamic>> silverJewellery;
  final List<Map<String, dynamic>> purchasedProductForResaling;
  final List<Map<String, dynamic>> unfinishedProduct;
  final List<Map<String, dynamic>> producedProductForResaling;
  final List<Map<String, dynamic>> purchasedNotForResaling;
  final List<Map<String, dynamic>> usedAfterNisab;
  final List<Map<String, dynamic>> rentMoney;
  final List<Map<String, dynamic>> stocksForResaling;
  final List<Map<String, dynamic>> incomeFromStocks;
  final List<Map<String, dynamic>> taxesValue;
  final double zakatValue;
  final bool nisabStatus;

  ZakatOnPropertyModel({
    this.cash = const [],
    this.cashOnBankCards = const [],
    this.goldJewellery = const [],
    this.silverJewellery = const [],
    this.purchasedProductForResaling = const [],
    this.unfinishedProduct = const [],
    this.producedProductForResaling = const [],
    this.purchasedNotForResaling = const [],
    this.usedAfterNisab = const [],
    this.rentMoney = const [],
    this.stocksForResaling = const [],
    this.incomeFromStocks = const [],
    this.taxesValue = const [],
    this.zakatValue = 0,
    this.nisabStatus = false,
  });

  ZakatOnPropertyModel copyWith({
    List<Map<String, dynamic>>? cash,
    List<Map<String, dynamic>>? cashOnBankCards,
    List<Map<String, dynamic>>? goldJewellery,
    List<Map<String, dynamic>>? silverJewellery,
    List<Map<String, dynamic>>? purchasedProductForResaling,
    List<Map<String, dynamic>>? unfinishedProduct,
    List<Map<String, dynamic>>? producedProductForResaling,
    List<Map<String, dynamic>>? purchasedNotForResaling,
    List<Map<String, dynamic>>? usedAfterNisab,
    List<Map<String, dynamic>>? rentMoney,
    List<Map<String, dynamic>>? stocksForResaling,
    List<Map<String, dynamic>>? incomeFromStocks,
    List<Map<String, dynamic>>? taxesValue,
    double? zakatValue,
    bool? nisabStatus,
  }) {
    return ZakatOnPropertyModel(
      cash: cash ?? this.cash,
      cashOnBankCards: cashOnBankCards ?? this.cashOnBankCards,
      goldJewellery: goldJewellery ?? this.goldJewellery,
      silverJewellery: silverJewellery ?? this.silverJewellery,
      purchasedProductForResaling: purchasedProductForResaling ?? this.purchasedProductForResaling,
      unfinishedProduct: unfinishedProduct ?? this.unfinishedProduct,
      producedProductForResaling: producedProductForResaling ?? this.producedProductForResaling,
      purchasedNotForResaling: purchasedNotForResaling ?? this.purchasedNotForResaling,
      usedAfterNisab: usedAfterNisab ?? this.usedAfterNisab,
      rentMoney: rentMoney ?? this.rentMoney,
      stocksForResaling: stocksForResaling ?? this.stocksForResaling,
      incomeFromStocks: incomeFromStocks ?? this.incomeFromStocks,
      taxesValue: taxesValue ?? this.taxesValue,
      zakatValue: zakatValue ?? this.zakatValue,
      nisabStatus: nisabStatus ?? this.nisabStatus,
    );
  }
}

// class ZakatOnPropertyModel {
//   Map<String, List<ZakatOnPropertyItem>> _zakat_on_property_model;
//   int zakatValue = 0;
//   bool nisabStatus = false;


//   static const List<String> defaultKeys = [
//     'cash',
//     'cashOnBankCards',
//     'silverJewellery',
//     'goldJewellery',
//     'purchasedProductForResaling',
//     'unfinishedProduct',
//     'producedProductForResaling',
//     'purchasedNotForResaling',
//     'usedAfterNisab',
//     'rentMoney',
//     'stocksForResaling',
//     'incomeFromStocks',
//     'taxesValue'
//   ];

//   ZakatOnPropertyModel()
//       : _zakat_on_property_model = {
//           for (String key in defaultKeys) key: []
//         };

//   List<ZakatOnPropertyItem> get cash => _zakat_on_property_model['cash'] ?? [];

//   List<ZakatOnPropertyItem> get cashOnBankCards => _zakat_on_property_model['cashOnBankCards'] ?? [];

//   List<ZakatOnPropertyItem> get goldJewellery => _zakat_on_property_model['goldJewellery'] ?? [];

//   List<ZakatOnPropertyItem> get silverJewellery => _zakat_on_property_model['silverJewellery'] ?? [];

//   List<ZakatOnPropertyItem> get purchasedProductForResaling => _zakat_on_property_model['purchasedProductForResaling'] ?? [];

//   List<ZakatOnPropertyItem> get unfinishedProduct => _zakat_on_property_model['unfinishedProduct'] ?? [];

//   List<ZakatOnPropertyItem> get producedProductForResaling => _zakat_on_property_model['producedProductForResaling'] ?? [];

//   List<ZakatOnPropertyItem> get purchasedNotForResaling => _zakat_on_property_model['purchasedNotForResaling'] ?? [];

//   List<ZakatOnPropertyItem> get usedAfterNisab => _zakat_on_property_model['usedAfterNisab'] ?? [];

//   List<ZakatOnPropertyItem> get rentMoney => _zakat_on_property_model['rentMoney'] ?? [];

//   List<ZakatOnPropertyItem> get stocksForResaling => _zakat_on_property_model['stocksForResaling'] ?? [];

//   List<ZakatOnPropertyItem> get incomeFromStocks => _zakat_on_property_model['incomeFromStocks'] ?? [];

//   List<ZakatOnPropertyItem> get taxesValue => _zakat_on_property_model['taxesValue'] ?? [];




//   void addCash(int value, CurrencyModel currency) {
//     _zakat_on_property_model['cash']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setCash(List<TextEditingController> cuantity, List<CurrencyModel> currency) {
//     for (int i = 0; i < cuantity.length; i++) {
//       _zakat_on_property_model['cash']?.add(ZakatOnPropertyItem(currencyCode: currency[i].code, value: int.parse(cuantity[i].text)));
//     }
//   }

//   void addCashOnBankCards(int value, CurrencyModel currency) {
//     _zakat_on_property_model['cashOnBankCards']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setCashOnBankCards(List<TextEditingController> cuantity, List<CurrencyModel> currency) {
//     for (int i = 0; i < cuantity.length; i++) {
//       _zakat_on_property_model['cashOnBankCards']?.add(ZakatOnPropertyItem(currencyCode: currency[i].code, value: int.parse(cuantity[i].text)));
//     }
//   }

//   void addGoldJewellery(int value, CurrencyModel currency) {
//     _zakat_on_property_model['goldJewellery']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void addSilverJewellery(int value, CurrencyModel currency) {
//     _zakat_on_property_model['silverJewellery']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void addPurchasedProductForResaling(int value, CurrencyModel currency) {
//     _zakat_on_property_model['purchasedProductForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setPurchasedProductForResaling(List<TextEditingController> cuantity, List<CurrencyModel> currency) {
//     for (int i = 0; i < cuantity.length; i++) {
//       _zakat_on_property_model['purchasedProductForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency[i].code, value: int.parse(cuantity[i].text)));
//     }
//   }

//   void addUnfinishedProduct(int value, CurrencyModel currency) {
//     _zakat_on_property_model['unfinishedProduct']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setUnfinishedProduct(List<TextEditingController> cuantity, List<CurrencyModel> currency) {
//     for (int i = 0; i < cuantity.length; i++) {
//       _zakat_on_property_model['unfinishedProduct']?.add(ZakatOnPropertyItem(currencyCode: currency[i].code, value: int.parse(cuantity[i].text)));
//     }
//   }

//   void addProducedProductForResaling(int value, CurrencyModel currency) {
//     _zakat_on_property_model['producedProductForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setProducedProductForResaling(List<TextEditingController> cuantity, List<CurrencyModel> currency) {
//     for (int i = 0; i < cuantity.length; i++) {
//       _zakat_on_property_model['producedProductForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency[i].code, value: int.parse(cuantity[i].text)));
//     }
//   }

//   void addPurchasedNotForResaling(int value, CurrencyModel currency) {
//     _zakat_on_property_model['purchasedNotForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setPurchasedNotForResaling(List<TextEditingController> cuantity, List<CurrencyModel> currency) {
//     for (int i = 0; i < cuantity.length; i++) {
//       _zakat_on_property_model['purchasedNotForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency[i].code, value: int.parse(cuantity[i].text)));
//     }
//   }

//   void addUsedAfterNisab(int value, CurrencyModel currency) {
//     _zakat_on_property_model['usedAfterNisab']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void addRentMoney(int value, CurrencyModel currency) {
//     _zakat_on_property_model['rentMoney']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void addStocksForResaling(int value, CurrencyModel currency) {
//     _zakat_on_property_model['stocksForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void addIncomeFromStocks(int value, CurrencyModel currency) {
//     _zakat_on_property_model['incomeFromStocks']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void addTaxesValue(int value, CurrencyModel currency) {
//     _zakat_on_property_model['taxesValue']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
//   }

//   void setZakatValue({int value = 0}) {
//     zakatValue = value;
//   }

//   void setNisabStatus({bool status = false}) {
//     nisabStatus = status;
//   }

  
// }



// class ZakatOnPropertyItem{
//   String currencyCode;
//   int value;

//   ZakatOnPropertyItem({required this.currencyCode, required this.value});
// }
