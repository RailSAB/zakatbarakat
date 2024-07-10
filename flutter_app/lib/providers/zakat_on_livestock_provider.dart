import 'package:flutter_app/models/zakat_on_livestock_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final zakatOnLivestockProvider = StateNotifierProvider<ZakatOnLivestockNotifier, ZakatOnLivestockModel>((ref) => ZakatOnLivestockNotifier());

class ZakatOnLivestockNotifier extends StateNotifier<ZakatOnLivestockModel> {
  
  ZakatOnLivestockNotifier() : super(ZakatOnLivestockModel());


  void setSheep(int value) => state.sheep = value;//1
  void setCows(int value) => state.cows = value;//2
  void setGoats(int value) => state.goats = value;//3
  void setForSale(bool value) => state.isForSale = value;//4
  void setFemale(bool value) => state.isFemale = value;//5

  void setHorsesValue(int value) => state.horses_value = value;//6
  void setBuffaloes(int value) => state.buffaloes = value;//7
  void setCamels(int value) => state.camels = value;//8
  void setZakatForHorses(int value) => state.zakatForHorses = value;//9
  void setAnimalsForZakat(List<Animal> value) => state.animalsForZakat = value;//10

}