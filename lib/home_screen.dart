import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:projeto_sti/components/product.dart';

import 'components/wishlist.dart';

class HomeScreen extends StatefulWidget {
  final String emailName;

  const HomeScreen({Key? key, required this.emailName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(emailName);
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

  List<Product>? _shuffledProducts;
  List<Wishlist> _wishlistList = [];

  void _shuffleProducts() {
    final random = Random();
    _shuffledProducts = List.of(popularProducts)..shuffle(random);
    _wishlistList = List.of(wishlistList);
  }

  @override
  void initState() {
    super.initState();
    _shuffleProducts();
  }

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
            _buildPopularProductsList(context, 'Produtos mais populares', emailName),
            const SizedBox(height: 8),
            _buildPopularProductsList(context, 'Produtos em destaque', emailName),
            const SizedBox(height: 8),
            _buildPopularProductsList(context, 'Produtos mais recentes', emailName),
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

  Widget _buildPopularProductsList(BuildContext context, String textLabel, String emailName) {
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
            itemCount: _shuffledProducts?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final popularProduct = _shuffledProducts![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    //TODO: Navigate to product details screen
                  },
                  child: SizedBox(
                    width: 150,
                    child: Card(
                      elevation: 4,
                      child: Stack(
                        children: [
                          Column(
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
                                              .titleMedium
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
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (emailName.isNotEmpty)
                            Positioned(
                              top: -5,
                              right: -5,
                              child: IconButton(
                                icon: Icon(
                                  popularProduct.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: popularProduct.isFavorite
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.outline,
                                ),
                                onPressed: () {
                                  if(!popularProduct.isFavorite) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Adicionar à lista'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                const Text(
                                                    'Escolhe a lista para adicionar o produto:'),
                                                ...List.generate(
                                                  _wishlistList.length,
                                                      (index) =>
                                                      RadioListTile(
                                                        title: Text(
                                                            _wishlistList[index]
                                                                .name),
                                                        value: _wishlistList[index]
                                                            .id,
                                                        groupValue: null,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            popularProduct
                                                                .isFavorite =
                                                            !popularProduct
                                                                .isFavorite;
                                                            _wishlistList[index]
                                                                .products.add(
                                                                popularProduct);
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  else {
                                    setState(() {
                                      popularProduct
                                          .isFavorite =
                                      !popularProduct
                                          .isFavorite;
                                      //TODO: Remove product from wishlist - backend
                                    });
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
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
