import '../data_helper.dart';

class CartItem {
  String name;
  int amount;
  double price;
  String barCode;
  String image;
  String code;
  String weight;
  String group;
  String unity;

  CartItem(
      {this.name,
      this.amount = 1,
      this.price,
      this.barCode,
      this.image,
      this.code,
      this.weight,
      this.group,
      this.unity});

  double get total {
    return price * amount;
  }

  double get pesoTotal {
    double peso = DataHelper.brNumber.parse(weight);
    return peso * amount;
  }
}
