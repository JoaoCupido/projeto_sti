class ShoppingCard {
  final String name;
  final String brand;
  final String price;
  final String discount;
  final String review;
  final String image;
  int quantity;

  ShoppingCard(
      {required this.name,
      required this.brand,
      required this.price,
      required this.discount,
      required this.review,
      required this.image,
      required this.quantity});
}

ShoppingCard shoppingCard1 = ShoppingCard(
    name: "Biscoitos",
    brand: "Purina",
    price: "2.19",
    discount: "0",
    review: "3.9",
    image: "assets/images/prod-cao1.png",
    quantity: 3);
