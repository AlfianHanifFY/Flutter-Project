class Menu {
  String name;
  double id;
  double price;

  Menu(this.name, this.id, this.price);

  Menu.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        price = json['price'] as double,
        id = json['id'] as double;

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'id': id,
      };
}
