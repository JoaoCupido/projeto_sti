import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  final String emailName;

  const HomeScreen({Key? key, required this.emailName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(emailName);
}

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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  CarouselController carouselController = CarouselController();

  String emailName;
  _HomeScreenState(this.emailName);

  final featuredImages = [
    'assets/images/campanha1.png',
    'assets/images/campanha2.png',
    'assets/images/campanha3.png'
  ];

  List<Product> popularProducts = [
    const Product(
      title: 'Biscoitos para cão Biscrok',
      brand: 'Pedigree',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      price: 3.99,
      discountPrice: 4.99,
      imageUrl: 'assets/images/150x150placeholder.png',
      rating: 4.7,
    ),
    const Product(
      title: 'Comida húmida para cão',
      brand: 'Royal Canin',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      price: 1.99,
      imageUrl: 'assets/images/150x150placeholder.png',
      rating: 4.2,
    ),
    const Product(
      title: 'Ração para gato',
      brand: 'Purina',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      price: 5.99,
      discountPrice: 7.99,
      imageUrl: 'assets/images/150x150placeholder.png',
      rating: 4.9,
    ),
    const Product(
      title: 'Comida húmida para gato',
      brand: 'Whiskas',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      price: 0.99,
      imageUrl: 'assets/images/150x150placeholder.png',
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //print(emailName);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPromotionCarousel(context),
            _buildPopularProductsList(context, 'Produtos mais populares'),
            const SizedBox(height: 8),
            _buildPopularProductsList(context, 'Produtos em destaque'),
            const SizedBox(height: 8),
            _buildPopularProductsList(context, 'Produtos mais recentes'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCarousel(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 450,
        height: 221,
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController, // Give the controller
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                pauseAutoPlayOnTouch: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.9,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
              items: featuredImages.map((featuredImage) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(featuredImage),
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  // Use the controller to change the current page
                  carouselController.previousPage();
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  // Use the controller to change the current page
                  carouselController.nextPage();
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularProductsList(BuildContext context, String textLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            textLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 225,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularProducts.length,
            itemBuilder: (BuildContext context, int index) {
              final popularProduct = popularProducts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: 150,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              popularProduct.imageUrl,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popularProduct.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                popularProduct.brand,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '€${popularProduct.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  if (popularProduct.discountPrice != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        '€${popularProduct.discountPrice}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${popularProduct.rating}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
