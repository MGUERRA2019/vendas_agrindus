import '../data_helper.dart';

class CartItem {
  String name;
  int amount;
  double price;
  String barCode;
  String image;
  String code;
  String weight;
  int packageWeight;
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
      this.packageWeight,
      this.group,
      this.unity});

  removeCartItem() {
    //Função para diminuir quantidade de determinado Produto produto no carrinho
    //Se a quantidade chegar a zero o item será removido do carrinho
    if (amount > 0) {
      amount--;
    }
  }

  addCartItem() {
    //Função para aumentar quantidade de determinado Produto produto no carrinhoø
    amount++;
  }

  addNumberedCartAmount(int newAmount) {
    amount = newAmount;
  }

  double get total {
    return price * amount;
  }

  double get pesoUnitario {
    double peso = DataHelper.brNumber.parse(weight);
    return peso * packageWeight;
  }

  double get pesoTotal {
    double peso = DataHelper.brNumber.parse(weight);
    return peso * amount * packageWeight;
  }
}
