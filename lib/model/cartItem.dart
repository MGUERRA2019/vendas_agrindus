import '../data_helper.dart';

class CartItem {
  String name;
  int amount;
  double price;
  String barCode;
  String image;
  String code;
  String weight;

  CartItem(
      {this.name,
      this.amount = 1,
      this.price,
      this.barCode,
      this.image,
      this.code,
      this.weight});

  double get total {
    // double preco = DataHelper.brNumber.parse(price);
    return price * amount;
  }

  double get pesoTotal {
    double peso = DataHelper.brNumber.parse(weight);
    return peso * amount;
  }
}
