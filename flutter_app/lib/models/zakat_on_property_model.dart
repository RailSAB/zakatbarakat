

class ZakatOnPropertyModel {
  int cash;
  int cashOnBankCards;
  int goldJewellery;
  int silverJewellery;
  int purchasedProductForResaling;
  int unfinishedProduct;
  int producedProductForResaling;
  int purchasedNotForResaling;
  int usedAfterNisab;
  int rentMoney;
  int stocksForResaling;
  int incomeFromStocks;
  int taxesValue;

  int zakatValue;

  ZakatOnPropertyModel({
    this.cash = 0,
    this.cashOnBankCards = 0,
    this.goldJewellery = 0,
    this.silverJewellery = 0,
    this.purchasedProductForResaling = 0,
    this.unfinishedProduct = 0,
    this.producedProductForResaling = 0,
    this.purchasedNotForResaling = 0,
    this.usedAfterNisab = 0,
    this.rentMoney = 0,
    this.stocksForResaling = 0,
    this.incomeFromStocks = 0,
    this.taxesValue = 0,
    this.zakatValue = 0
  });

  ZakatOnPropertyModel copyWith({required int cash, required int cashOnBankCards}) {
    return ZakatOnPropertyModel(
      cash: cash,
      cashOnBankCards: cashOnBankCards,
      goldJewellery: goldJewellery,
      silverJewellery: silverJewellery,
      purchasedProductForResaling: purchasedProductForResaling,
      unfinishedProduct: unfinishedProduct,
      producedProductForResaling: producedProductForResaling,
      purchasedNotForResaling: purchasedNotForResaling,
      usedAfterNisab: usedAfterNisab,
      rentMoney: rentMoney,
      stocksForResaling: stocksForResaling,
      incomeFromStocks: incomeFromStocks,
      taxesValue: taxesValue,
      zakatValue: zakatValue
    );
  }


}
  