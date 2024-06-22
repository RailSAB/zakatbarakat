import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_app/models/currency_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currencyProvider = StateNotifierProvider<CurrencyNotifier, CurrencyModel>((ref) => CurrencyNotifier());

class CurrencyNotifier extends StateNotifier<CurrencyModel> {
  CurrencyNotifier() : super(CurrencyModel(name: 'RUB', code: 'RUB'));

  final CurrencyModel _model = CurrencyModel(name: 'RUB', code: 'RUB');


  void setCurrency(Currency currency) => state = CurrencyModel(name: currency.name, code: currency.code);

}