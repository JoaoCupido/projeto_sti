class Product {
  final String title;
  final String brand;
  final String imageUrl;
  final double price;
  final double? discountPrice;
  final String description;
  final double rating;

  const Product({
    required this.title,
    required this.brand,
    required this.imageUrl,
    required this.price,
    this.discountPrice,
    required this.description,
    required this.rating,
  });
}

final popularProducts = [
  const Product(
    title: 'Biscoitos para cão Biscrok',
    brand: 'Pedigree',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    price: 3.99,
    discountPrice: 4.99,
    imageUrl: 'assets/images/prod-cao1.png',
    rating: 4.7,
  ),
  const Product(
    title: 'Party Mix 60 GR Felix',
    brand: 'Purina',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    price: 1.99,
    imageUrl: 'assets/images/prod-gato1.png',
    rating: 4.2,
  ),
  const Product(
    title: 'Friskies Puppy Biscuit',
    brand: 'Purina',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    price: 5.99,
    discountPrice: 7.99,
    imageUrl: 'assets/images/prod-cao2.png',
    rating: 4.9,
  ),
  const Product(
    title: 'Friskies Petiscos Sabor a Frango para gatos',
    brand: 'Purina',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    price: 0.99,
    imageUrl: 'assets/images/prod-gato2.png',
    rating: 4.5,
  ),
];
