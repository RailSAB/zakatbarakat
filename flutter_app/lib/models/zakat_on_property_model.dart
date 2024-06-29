import 'package:flutter_app/models/currency_model.dart';

class ZakatOnPropertyModel {
  Map<String, List<ZakatOnPropertyItem>> _zakat_on_property_model;
  int zakatValue = 0;
  bool nisabStatus = false;


  static const List<String> defaultKeys = [
    'cash',
    'cashOnBankCards',
    'silverJewellery',
    'goldJewellery',
    'purchasedProductForResaling',
    'unfinishedProduct',
    'producedProductForResaling',
    'purchasedNotForResaling',
    'usedAfterNisab',
    'rentMoney',
    'stocksForResaling',
    'incomeFromStocks',
    'taxesValue'
  ];

  ZakatOnPropertyModel()
      : _zakat_on_property_model = {
          for (String key in defaultKeys) key: []
        };

  List<ZakatOnPropertyItem> get cash => _zakat_on_property_model['cash'] ?? [];

  List<ZakatOnPropertyItem> get cashOnBankCards => _zakat_on_property_model['cashOnBankCards'] ?? [];

  List<ZakatOnPropertyItem> get goldJewellery => _zakat_on_property_model['goldJewellery'] ?? [];

  List<ZakatOnPropertyItem> get silverJewellery => _zakat_on_property_model['silverJewellery'] ?? [];

  List<ZakatOnPropertyItem> get purchasedProductForResaling => _zakat_on_property_model['purchasedProductForResaling'] ?? [];

  List<ZakatOnPropertyItem> get unfinishedProduct => _zakat_on_property_model['unfinishedProduct'] ?? [];

  List<ZakatOnPropertyItem> get producedProductForResaling => _zakat_on_property_model['producedProductForResaling'] ?? [];

  List<ZakatOnPropertyItem> get purchasedNotForResaling => _zakat_on_property_model['purchasedNotForResaling'] ?? [];

  List<ZakatOnPropertyItem> get usedAfterNisab => _zakat_on_property_model['usedAfterNisab'] ?? [];

  List<ZakatOnPropertyItem> get rentMoney => _zakat_on_property_model['rentMoney'] ?? [];

  List<ZakatOnPropertyItem> get stocksForResaling => _zakat_on_property_model['stocksForResaling'] ?? [];

  List<ZakatOnPropertyItem> get incomeFromStocks => _zakat_on_property_model['incomeFromStocks'] ?? [];

  List<ZakatOnPropertyItem> get taxesValue => _zakat_on_property_model['taxesValue'] ?? [];




  void addCash(int value, CurrencyModel currency) {
    _zakat_on_property_model['cash']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addCashOnBankCards(int value, CurrencyModel currency) {
    _zakat_on_property_model['cashOnBankCards']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addGoldJewellery(int value, CurrencyModel currency) {
    _zakat_on_property_model['goldJewellery']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addSilverJewellery(int value, CurrencyModel currency) {
    _zakat_on_property_model['silverJewellery']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addPurchasedProductForResaling(int value, CurrencyModel currency) {
    _zakat_on_property_model['purchasedProductForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addUnfinishedProduct(int value, CurrencyModel currency) {
    _zakat_on_property_model['unfinishedProduct']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addProducedProductForResaling(int value, CurrencyModel currency) {
    _zakat_on_property_model['producedProductForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addPurchasedNotForResaling(int value, CurrencyModel currency) {
    _zakat_on_property_model['purchasedNotForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addUsedAfterNisab(int value, CurrencyModel currency) {
    _zakat_on_property_model['usedAfterNisab']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addRentMoney(int value, CurrencyModel currency) {
    _zakat_on_property_model['rentMoney']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addStocksForResaling(int value, CurrencyModel currency) {
    _zakat_on_property_model['stocksForResaling']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addIncomeFromStocks(int value, CurrencyModel currency) {
    _zakat_on_property_model['incomeFromStocks']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void addTaxesValue(int value, CurrencyModel currency) {
    _zakat_on_property_model['taxesValue']?.add(ZakatOnPropertyItem(currencyCode: currency.code, value: value));
  }

  void setZakatValue({int value = 0}) {
    zakatValue = value;
  }

  void setNisabStatus({bool status = false}) {
    nisabStatus = status;
  }

  // int get zakatValue => _zakat_on_property_model['zakatValue']?['USD'] ?? 0;

  // void setZakatValue(CurrencyModel currency, {int zakat = 0}) {
  //   _zakat_on_property_model['zakatValue']?[] = zakat;
  // }

  // void setNisabValue(CurrencyModel currency, {int nisab = 0}) {
  //   _zakat_on_property_model['nisabValue']?[currency] = nisab;
  // }

  // int getValue(String category, CurrencyModel currency) {
  //   return _zakat_on_property_model[category]?[currency] ?? 0;
  // }

  // void setValue(String category, CurrencyModel currency, int value) {
  //   _zakat_on_property_model[category]?[currency] = value;
  // }
}


class ZakatOnPropertyItem{
  String currencyCode;
  int value;

  ZakatOnPropertyItem({required this.currencyCode, required this.value});
}
