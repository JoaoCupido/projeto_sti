import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WishlistItem {
  final String name;
  final String imageUrl;

  WishlistItem({required this.name, required this.imageUrl});
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _newWishlistName = "";
  List<WishlistItem> _wishlistItems = [];
  List<Map<String, dynamic>> _wishlists = [];
  String _currentWishlistName = "My Wishlist";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _createNewWishlist(String name) {
    setState(() {
      _wishlistItems = [];
      _newWishlistName = name;
    });
  }

  void _confirmNewWishlist() {
    setState(() {
      _wishlists.add({
        "name": _newWishlistName,
        "items": _wishlistItems,
      });
      _newWishlistName = "";
      _wishlistItems = [];
    });
  }

  void handleTabTap(int index) {
    switch (index) {
      case 0:
        // First tab (index 0) - Home icon clicked
        // Handle accordingly
        break;
      case 1:
        // Second tab (index 1) - Category icon clicked
        // Handle accordingly
        break;
      case 2:
        // Third tab (index 2) - Cart icon clicked
        // Handle accordingly
        break;
      case 3:
        // Fourth tab (index 3) - Favorite icon clicked
        // Handle accordingly
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishlistScreen()),
        );
        break;
      case 4:
        // Fifth tab (index 4) - Delivery icon clicked
        // Handle accordingly
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_wishlists.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Pesquisar...',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
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
              prefixIcon: const Icon(Icons.search),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  // TODO: Implementar ação de conta do usuário
                },
                icon: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("As minhas listas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left),
              Text("0 listas",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left),
              SvgPicture.asset(
                'assets/images/271-Wishlist.svg',
                width: 350,
                height: 350,
              ),
              Text("Sem listas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              Text(
                  "Adicine listas de artigos favoritos e/ou\nque futuramente queira adquirir.\nCrie listas e adicione artigos favoritos.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
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
              Tab(icon: Icon(Icons.category_outlined)),
              Tab(icon: Icon(Icons.shopping_cart_outlined)),
              Tab(icon: Icon(Icons.favorite_outline)),
              Tab(icon: Icon(Icons.delivery_dining_outlined)),
            ],
            onTap: handleTabTap,
          ),
        ),
      );
    }
    return Scaffold();
  }
}
