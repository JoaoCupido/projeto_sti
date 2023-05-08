import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/components/search_bar.dart';

import 'bottom_nav_bar_screen.dart';
import 'components/category.dart';
import 'components/product.dart';
import 'components/wishlist.dart';

class SearchResultsScreen extends StatefulWidget {
  final Map args;

  const SearchResultsScreen({Key? key, required this.args}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState(args);
}

class _SearchResultsScreenState extends State<SearchResultsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map args;
  _SearchResultsScreenState(this.args);

  late String emailName = '';
  late String query = '';

  List<Wishlist> _wishlistList = [];

  List<Product> _productsList = [];

  final List<String> _animalList = animalCategories.toList();
  String? _selectedAnimal = animalCategories.first;
  final List<String> _categoryList = categories.map((category) => category.name).toList();
  String? _selectedCategory = categories.first.name;
  final List<String> _brandList = [
    'Avizoon',
    'CaniAmigo',
    'Dingo',
    'Equilíbrio',
    'Friskies',
    'Hill\'s',
    'Pedigree',
    'Purina',
    'Royal Canin',
    'Whiskas',
  ];
  String? _selectedBrand;
  RangeValues _selectedPriceRange = const RangeValues(0, 1000);
  final double _minPrice = 0;
  final double _maxPrice = 1000;
  final List<double> _ratingList = [0, 1, 2, 3, 4];
  double? _selectedRating;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _wishlistList = List.of(wishlistList);
    _productsList = List.of(popularProducts);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailName = args['emailName'];
    query = args['query'];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleTabTap(int index) {
    Navigator.popUntil(context, (route) => !Navigator.canPop(context));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                BottomNavBarScreen(
                    args: {'index': index, 'emailName': emailName}
                )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    if (_productsList.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: SearchBar(emailName: emailName, query: query),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 54.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Mostrar ${_productsList.length} resultados para "$query"',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 8.0),
              SvgPicture.asset(
                'assets/images/458-error404.svg',
                width: 300,
                height: 300,
              ),
              Center(
                child: Text("Sem resultados",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    "Verifica a ortografia das palavras inseridas, introduz uma outra nova palavra-chave ou introduz palavras-chave mais gerais.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
            tabs: const [
              Tab(icon: Icon(Icons.home_outlined)),
              Tab(icon: Icon(Icons.menu_outlined)),
              Tab(icon: Icon(Icons.shopping_cart_outlined)),
              Tab(icon: Icon(Icons.favorite_outline)),
              Tab(icon: Icon(Icons.delivery_dining_outlined)),
            ],
            onTap: handleTabTap,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: SearchBar(emailName: emailName, query: query),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  const _SearchPill(text: 'Cão'),
                  const SizedBox(width: 8),
                  const _SearchPill(text: 'Alimentos'),
                  //const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Limpar tudo',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Mostrar ${_productsList.length} resultados para "$query"',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _productsList.length,
              itemBuilder: (context, index) {
                final popularProduct = _productsList[index];
                return GestureDetector(
                  onTap: () {
                    //TODO: Navigate to product details screen
                  },
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                    popularProduct.imageUrl,
                                  ),
                                ),
                                if (emailName.isNotEmpty)
                                  Positioned(
                                    top: 0,
                                    right: 0,
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
                                            //Remove product from wishlist - backend
                                          });
                                        }
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
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
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.compare_arrows_outlined),
                                        onPressed: () {
                                          //TODO: Implement compare functionality
                                        },
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      //const Spacer(),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          //TODO: Implement buy functionality
                                        },
                                        icon: const Icon(Icons.shopping_cart_outlined),
                                        label: const Text('Comprar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          textStyle: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 72.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        icon: const Icon(Icons.filter_list),
        label: const Text("Filtrar e ordenar"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Ordenar por",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField(
                          value: "default",
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "default",
                              child: Text("Relevância"),
                            ),
                            DropdownMenuItem(
                              value: "price_asc",
                              child: Text("Preço: Menor para Maior"),
                            ),
                            DropdownMenuItem(
                              value: "price_desc",
                              child: Text("Preço: Maior para Menor"),
                            ),
                            DropdownMenuItem(
                              value: "rating_desc",
                              child: Text("Avaliação: Mais alta para mais baixa"),
                            ),
                            DropdownMenuItem(
                              value: "rating_asc",
                              child: Text("Avaliação: Mais baixa para mais alta"),
                            ),
                          ],
                          onChanged: (value) {
                            switch (value) {
                              case "price_asc":
                                setState(() {
                                  _productsList.sort((a, b) =>
                                      a.price.compareTo(b.price));
                                });
                                break;
                              case "price_desc":
                                setState(() {
                                  _productsList.sort((a, b) => b.price.compareTo(a.price));
                                });
                                break;
                              case "rating_asc":
                                setState(() {
                                  _productsList.sort((a, b) => a.rating.compareTo(b.rating));
                                });
                                break;
                              case "rating_desc":
                                setState(() {
                                  _productsList.sort((a, b) => b.rating.compareTo(a.rating));
                                });
                                break;
                              default:
                                //do not sort at all
                                break;
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Filtrar por",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Animal",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField(
                          value: _selectedAnimal,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          items: _animalList
                              .map(
                                (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedAnimal = value;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Categoria",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          items: _categoryList
                              .map(
                                (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Marca",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8,
                          children: _brandList.map(
                                (brand) => ChoiceChip(
                              label: Text(
                                brand,
                                style: TextStyle(
                                  color: _selectedBrand == brand ?
                                  Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              selectedColor: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context).colorScheme.onPrimary,
                              selected: _selectedBrand == brand,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedBrand = selected ? brand : null;
                                });
                              },
                            ),
                          ).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                        Text(
                          "Preço",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        RangeSlider(
                          values: _selectedPriceRange,
                          min: _minPrice,
                          max: _maxPrice,
                          divisions: 100,
                          onChanged: (values) {
                            setState(() {
                              _selectedPriceRange = values;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "€${_selectedPriceRange.start.round()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "€${_selectedPriceRange.end.round()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Avaliação",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                              spacing: 8,
                              children: _ratingList
                                  .map(
                                    (rating) => ChoiceChip(
                                  label: Text('${rating.toString()} ou mais',
                                    style: TextStyle(
                                      color: _selectedRating == rating ?
                                      Theme.of(context).colorScheme.onPrimary
                                          : Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  selected: _selectedRating == rating,
                                  selectedColor: Theme.of(context).colorScheme.primary,
                                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                                  onSelected: (selected) {
                                    setState(()
                                    {
                                      _selectedRating = selected ? rating : null;
                                    });
                                  },
                                ),
                              )
                                  .toList(),
                            ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // apply filters
                            Navigator.pop(context);
                          },
                          child: Text("Aplicar filtros"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined)),
            Tab(icon: Icon(Icons.menu_outlined)),
            Tab(icon: Icon(Icons.shopping_cart_outlined)),
            Tab(icon: Icon(Icons.favorite_outline)),
            Tab(icon: Icon(Icons.delivery_dining_outlined)),
          ],
          onTap: handleTabTap,
        ),
      ),
    );
  }
}

class _SearchPill extends StatelessWidget {
  final String text;

  const _SearchPill({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.highlight_remove_outlined,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}