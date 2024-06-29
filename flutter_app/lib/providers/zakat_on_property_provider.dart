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
      state.addCash(value, currency); //1

  void addCashOnBankCards(int value, CurrencyModel currency) =>
      state.addCashOnBankCards(value, currency);

  void addGoldJewellery(int value, CurrencyModel currency) =>
      state.addGoldJewellery(value, currency); //3

  void addSilverJewellery(int value, CurrencyModel currency) =>
      state.addSilverJewellery(value, currency); //4
  void addPurchasedProductForResaling(int value, CurrencyModel currency) =>
      state.addPurchasedProductForResaling(value, currency); //5
  void addUnfinishedProduct(int value, CurrencyModel currency) =>
      state.addUnfinishedProduct(value, currency); //6
  void addProducedProductForResaling(int value, CurrencyModel currency) =>
      state.addProducedProductForResaling(value, currency); //7
  void addPurchasedNotForResaling(int value, CurrencyModel currency) =>
      state.addPurchasedNotForResaling(value, currency); //8

  void addUsedAfterNisab(int value, CurrencyModel currency) =>
      state.addUsedAfterNisab(value, currency); //9

  void addRentMoney(int value, CurrencyModel currency) =>
      state.addRentMoney(value, currency); //10
  void addStocksForResaling(int value, CurrencyModel currency) =>
      state.addStocksForResaling(value, currency); //11
  void addIncomeFromStocks(int value, CurrencyModel currency) =>
      state.addIncomeFromStocks(value, currency); //12
  void addTaxesValue(int value, CurrencyModel currency) =>
      state.addTaxesValue(value, currency); //13

  void setZakatValue(int value) => state.setZakatValue(value: value);
  void setNisabStatus(bool status) => state.setNisabStatus(status: status);

  // int getZakatValue() =>
  //     state.getValue('zakatValue', currency);

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
        setZakatValue(value);
        break;
      // case 'nisabValue':
      //   setNisabValue(currency);
      //   break;
      default:
        break;
    }
  }
}
