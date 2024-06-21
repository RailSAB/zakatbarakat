class ZakatOnLivestockModel {
  int camels;
  int cows;
  int buffaloes;
  int sheep;
  int goats;
  int horses_value;
  bool isFemale;
  bool isForSale;
  int zakatForHorses = 0;
  List<Animal> animalsForZakat = [];

  ZakatOnLivestockModel({
    this.camels = 0,
    this.cows = 0,
    this.buffaloes = 0,
    this.sheep = 0,
    this.goats = 0,
    this.horses_value = 0,
    this.isFemale = false,
    this.isForSale = false
  });
}


class Animal {
  String type;
  int quantity;
  int? age; 

  Animal({
    required this.type,
    required this.quantity,
    this.age,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      type: json['type'],
      quantity: json['quantity'],
      age: json['age'], 
    );
  }
}