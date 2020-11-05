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
      this.amount = 0,
      this.price,
      this.barCode,
      this.image,
      this.code,
      this.weight});

  double get total {
    return price * amount;
  }
}
