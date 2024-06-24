


import 'package:flutter_app/models/zakat_ushr_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final zakatUshrProvider = StateNotifierProvider<ZakatUshrNotifier, ZakatUshrModel>((ref) => ZakatUshrNotifier());

class ZakatUshrNotifier extends StateNotifier<ZakatUshrModel> {
  ZakatUshrNotifier() : super(ZakatUshrModel(isIrregated: false, isUshrLand: false, crops: []));


  void setIrregated(bool value) => state.isIrregated = value;

  void setUshrLand(bool value) => state.isUshrLand = value;

  void setCrops(List<Crop> value) => state.crops = value;

  void addCrop(Crop crop) => state.crops.add(crop);

}