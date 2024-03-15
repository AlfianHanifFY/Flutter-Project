import 'package:flutter_app/models/menu.dart';

class Order {
  final List<Menu> order;

  Order(this.order);

  double getTotalPrice() {
    double total = 0.0;
    for (var item in order) {
      total += item.price;
    }
    return total;
  }
}
