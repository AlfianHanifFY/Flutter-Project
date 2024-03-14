class Menu {
  String name;

  double price;

  Menu(this.name, this.price);

  Menu.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        price = json['price'] as double;

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
      };
}
