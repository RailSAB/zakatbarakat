

class ZakatUshrModel {
  bool isIrregated;
  bool isUshrLand;
  List<Crop> crops;

  ZakatUshrModel({required this.isIrregated, required this.isUshrLand, required this.crops});
}


class Crop{
  String type;
  int quantity;

  Crop({required this.type, required this.quantity});

  Map<String, dynamic> toJson() => {
    'type': type,
    'quantity': quantity,
  };
}