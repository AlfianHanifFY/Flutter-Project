import 'dart:ffi';

class Menu {
  String name;
  Int id;
  Int price;

  Menu(this.name, this.id, this.price);

  Menu.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        price = json['price'] as Int,
        id = json['id'] as Int;

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'id': id,
      };
}
