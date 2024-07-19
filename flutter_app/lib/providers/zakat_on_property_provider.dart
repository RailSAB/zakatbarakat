import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/models/zakat_on_property_model.dart';

final zakatOnPropertyProvider =
    StateNotifierProvider<ZakatOnPropertyNotifier, ZakatOnPropertyModel>(
        (ref) => ZakatOnPropertyNotifier());

class ZakatOnPropertyNotifier extends StateNotifier<ZakatOnPropertyModel> {
  ZakatOnPropertyNotifier() : super(ZakatOnPropertyModel());

  void setAny(String category, List<Map<String, dynamic>> data) {
    state = state.copyWith(
      cash: category == 'cash' ? data : state.cash,
      cashOnBankCards: category == 'cashOnBankCards' ? data : state.cashOnBankCards,
      goldJewellery: category == 'goldJewellery' ? data : state.goldJewellery,
      silverJewellery: category == 'silverJewellery' ? data : state.silverJewellery,
      purchasedProductForResaling: category == 'purchasedProductForResaling' ? data : state.purchasedProductForResaling,
      unfinishedProduct: category == 'unfinishedProduct' ? data : state.unfinishedProduct,
      producedProductForResaling: category == 'producedProductForResaling' ? data : state.producedProductForResaling,
      purchasedNotForResaling: category == 'purchasedNotForResaling' ? data : state.purchasedNotForResaling,
      usedAfterNisab: category == 'usedAfterNisab' ? data : state.usedAfterNisab,
      rentMoney: category == 'rentMoney' ? data : state.rentMoney,
      stocksForResaling: category == 'stocksForResaling' ? data : state.stocksForResaling,
      incomeFromStocks: category == 'incomeFromStocks' ? data : state.incomeFromStocks,
      taxesValue: category == 'taxesValue' ? data : state.taxesValue,
    );
  }

  void setZakatValue(double value) {
    state = state.copyWith(zakatValue: value);
  }

  void setNisabStatus(bool status) {
    state = state.copyWith(nisabStatus: status);
  }


  // getters

  List<Map<String, dynamic>> get getCash => state.cash;

  List<Map<String, dynamic>> get getCashOnBankCards => state.cashOnBankCards;

  List<Map<String, dynamic>> get getGoldJewellery => state.goldJewellery;

  List<Map<String, dynamic>> get getSilverJewellery => state.silverJewellery;

  List<Map<String, dynamic>> get getPurchasedProductForResaling => state.purchasedProductForResaling;

  List<Map<String, dynamic>> get getUnfinishedProduct => state.unfinishedProduct;

  List<Map<String, dynamic>> get getProducedProductForResaling => state.producedProductForResaling;

  List<Map<String, dynamic>> get getPurchasedNotForResaling => state.purchasedNotForResaling;

  List<Map<String, dynamic>> get getUsedAfterNisab => state.usedAfterNisab;

  List<Map<String, dynamic>> get getRentMoney => state.rentMoney;

  List<Map<String, dynamic>> get getStocksForResaling => state.stocksForResaling;

  List<Map<String, dynamic>> get getIncomeFromStocks => state.incomeFromStocks;

  List<Map<String, dynamic>> get getTaxesValue => state.taxesValue;



}
