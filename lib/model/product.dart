class Product {
  final int id; 
  final double price;
  final String title, description, image;

  Product({this.id, this.price, this.title, this.description, this.image});
}

// list of products
// for our demo
List<Product> products = [

  Product(
    id: 12,
    price: 6.30,
    title: "Leite Integral 1L",
    image: "assets/images/Item_4.png",
    description:
        "1 ingrediente e mais nada: leite fresco proveniente apenas de vacas A2A2, 100% produzido na Fazenda Agrindus com todas as propriedades nutricionais. Validade de 15 dias. Embalagem PET, totalmente reciclável.",
  ),

  Product(
    id: 13,
    price: 6.30,
    title: "Leite Desnatado 1L",
    image: "assets/images/Item_5.png",
    description:
        "1 ingrediente e mais nada: leite fresco proveniente apenas de vacas A2A2, 100% produzido na Fazenda Agrindus com 0% de gordura e 0% de colesterol. Validade de 15 dias. Embalagem PET, totalmente reciclável.",
  ),

  Product(
    id: 1,
    price: 8.30,
    title: "Leite Fermentado Lettico 1L",
    image: "assets/images/Item_1.png",
    description:
        "– Feito com leite Tipo A – Apenas vacas A2A2 – 100% produzido na Fazenda Agrindus – 0% de gordura e 0% lactose – Validade de 54 dias – Este produto não tem selo BDK",
  ),
  Product(
    id: 4,
    price: 18.70,
    title: "Creme de Leite 550g",
    image: "assets/images/Item_2.png",
    description:
        "Creme de leite fresco feito com 1 ingrediente e mais nada: leite tipo A proveniente apenas de vacas A2A2, 100% produzido na Fazenda Agrindus. Ideal para alcançar o ponto certo nas suas receitas.Validade de 30 dias.",
  ),
  Product(
    id: 9,
    price: 8.60,
    title: "Coalhada Integral 600g",
    image: "assets/images/Item_3.png",
    description:
        "Coalhada integral fresca feita com leite tipo A proveniente de vacas A2A2 e fermento lácteo e mais nada. 100% produzida na Fazenda Agrindus. Validade de 54 dias.",
  ),
];
