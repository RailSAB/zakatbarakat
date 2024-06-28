import 'package:flutter_app/models/currency_model.dart';

class ZakatOnPropertyModel {
  Map<String, Map<CurrencyModel, int>> _zakat_on_property_model;

  static const List<String> defaultKeys = [
    'cash',
    'cashOnBankCards',
    'goldJewellery',
    'silverJewellery',
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
          for (String key in defaultKeys) key: {},
          'zakatValue': {},
          'nisabValue': {},
        };

  int get zakatValue => _zakat_on_property_model['zakatValue']?['USD'] ?? 0;
  int get nisabValue => _zakat_on_property_model['nisabValue']?['USD'] ?? 0;

  void setZakatValue(CurrencyModel currency, {int zakat = 0}) {
    _zakat_on_property_model['zakatValue']?[currency] = zakat;
  }

  void setNisabValue(CurrencyModel currency, {int nisab = 0}) {
    _zakat_on_property_model['nisabValue']?[currency] = nisab;
  }

  int getValue(String category, CurrencyModel currency) {
    return _zakat_on_property_model[category]?[currency] ?? 0;
  }

  void setValue(String category, CurrencyModel currency, int value) {
    _zakat_on_property_model[category]?[currency] = value;
  }
}
