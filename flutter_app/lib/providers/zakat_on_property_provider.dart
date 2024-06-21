import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/models/zakat_on_property_model.dart';


final zakatOnPropertyProvider = StateNotifierProvider<ZakatOnPropertyNotifier, ZakatOnPropertyModel>((ref) => ZakatOnPropertyNotifier());
class ZakatOnPropertyNotifier extends StateNotifier<ZakatOnPropertyModel> {
  
  ZakatOnPropertyNotifier() : super(ZakatOnPropertyModel());

  ZakatOnPropertyModel _model = ZakatOnPropertyModel();


  void setCash(int value) => state.cash = value;//1

  void setCashOnBankCards(int value) => state.cashOnBankCards = value;//2

  void setGoldJewellery(int value) => state.goldJewellery = value;//3

  void setSilverJewellery(int value) => state.silverJewellery = value;//4

  void setPurchasedProductForResaling(int value) => state.purchasedProductForResaling = value;//5

  void setUnfinishedProduct(int value) => state.unfinishedProduct = value;//6

  void setProducedProductForResaling(int value) => state.producedProductForResaling = value;//7

  void setPurchasedNotForResaling(int value) => state.purchasedNotForResaling = value;//10

  void setUsedAfterNisab(int value) => state.usedAfterNisab = value;//11

  void setRentMoney(int value) => state.rentMoney = value;//12

  void setStocksForResaling(int value) => state.stocksForResaling = value;//8

  void setIncomeFromStocks(int value) => state.incomeFromStocks = value;//9

  void setTaxesValue(int value) => state.taxesValue = value;//13

  void setNisabValue(int value) => state.nisabValue = value;

  void setZakatValue(int value){
    state.zakatValue = value;//14
  }

  int getZakatValue() => state.zakatValue;
}