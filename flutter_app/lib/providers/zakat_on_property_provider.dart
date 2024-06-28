import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/models/zakat_on_property_model.dart';

final zakatOnPropertyProvider =
    StateNotifierProvider<ZakatOnPropertyNotifier, ZakatOnPropertyModel>(
        (ref) => ZakatOnPropertyNotifier());

class ZakatOnPropertyNotifier extends StateNotifier<ZakatOnPropertyModel> {
  ZakatOnPropertyNotifier() : super(ZakatOnPropertyModel());

  final ZakatOnPropertyModel _model = ZakatOnPropertyModel();

  void addCash(int value, CurrencyModel currency) =>
      state.setValue('cash', currency, value); //1

  void addCashOnBankCards(int value, CurrencyModel currency) =>
      state.setValue('cashOnBankCards', currency, value); //2

  void addGoldJewellery(int value, CurrencyModel currency) =>
      state.setValue('goldJewellery', currency, value); //3

  void addSilverJewellery(int value, CurrencyModel currency) =>
      state.setValue('silverJewellery', currency, value); //4
  void addPurchasedProductForResaling(int value, CurrencyModel currency) =>
      state.setValue('purchasedProductForResaling', currency, value); //5
  void addUnfinishedProduct(int value, CurrencyModel currency) =>
      state.setValue('unfinishedProduct', currency, value); //6
  void addProducedProductForResaling(int value, CurrencyModel currency) =>
      state.setValue('producedProductForResaling', currency, value); //7
  void addPurchasedNotForResaling(int value, CurrencyModel currency) =>
      state.setValue('purchasedNotForResaling', currency, value); //8

  void addUsedAfterNisab(int value, CurrencyModel currency) =>
      state.setValue('usedAfterNisab', currency, value); //9

  void addRentMoney(int value, CurrencyModel currency) =>
      state.setValue('rentMoney', currency, value); //10
  void addStocksForResaling(int value, CurrencyModel currency) =>
      state.setValue('stocksForResaling', currency, value); //11
  void addIncomeFromStocks(int value, CurrencyModel currency) =>
      state.setValue('incomeFromStocks', currency, value); //12
  void addTaxesValue(int value, CurrencyModel currency) =>
      state.setValue('taxesValue', currency, value); //13

  void setNisabValue(CurrencyModel currency) => state.setNisabValue(currency);

  void setZakatValue(CurrencyModel currency) => state.setZakatValue(currency);

  int getZakatValue(CurrencyModel currency) =>
      state.getValue('zakatValue', currency);

  void add(String category, CurrencyModel currency, int value) {
    switch (category) {
      case 'cash':
        addCash(value, currency);
        break;
      case 'cashOnBankCards':
        addCashOnBankCards(value, currency);
        break;
      case 'goldJewellery':
        addGoldJewellery(value, currency);
        break;
      case 'silverJewellery':
        addSilverJewellery(value, currency);
        break;
      case 'purchasedProductForResaling':
        addPurchasedProductForResaling(value, currency);
        break;
      case 'unfinishedProduct':
        addUnfinishedProduct(value, currency);
        break;
      case 'producedProductForResaling':
        addProducedProductForResaling(value, currency);
        break;
      case 'purchasedNotForResaling':
        addPurchasedNotForResaling(value, currency);
        break;
      case 'usedAfterNisab':
        addUsedAfterNisab(value, currency);
        break;
      case 'rentMoney':
        addRentMoney(value, currency);
        break;
      case 'stocksForResaling':
        addStocksForResaling(value, currency);
        break;
      case 'incomeFromStocks':
        addIncomeFromStocks(value, currency);
        break;
      case 'taxesValue':
        addTaxesValue(value, currency);
        break;
      case 'zakatValue':
        setZakatValue(currency);
        break;
      case 'nisabValue':
        setNisabValue(currency);
        break;
      default:
        break;
    }
  }
}
