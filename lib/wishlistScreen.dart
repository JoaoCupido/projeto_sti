import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'WishlistItemsScreen.dart';
import 'wishlist_item.dart';

class WishlistScreen extends StatefulWidget {
  final String emailName;

  const WishlistScreen({Key? key, required this.emailName}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState(emailName);
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  String emailName;
  _WishlistScreenState(this.emailName);

  String _newWishlistName = "Lista pré-definida";
  List<WishlistItem> _wishlistItems = [];
  List<Map<String, dynamic>> _wishlists = [
    {
      'name': 'Wishlist 1',
      'items': [
        {'name': 'Item 1', 'imageUrl': 'image1.jpg'},
        {'name': 'Item 2', 'imageUrl': 'image2.jpg'},
      ],
    },
    {
      'name': 'Wishlist 2',
      'items': [
        {'name': 'Item 3', 'imageUrl': 'image3.jpg'},
        {'name': 'Item 4', 'imageUrl': 'image4.jpg'},
        {'name': 'Item 5', 'imageUrl': 'image5.jpg'},
      ],
    },
  ];
  String _currentWishlistName = "My Wishlist";

  void _confirmNewWishlist(String name) {
    setState(() {
      _wishlists.add({
        "name": _newWishlistName,
        "items": _wishlistItems,
      });
      _newWishlistName = name;
      _wishlistItems = [];
    });
  }

  void _deleteWishlist(int index) {
    setState(() {
      _wishlists.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_wishlists.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // implementar função de alterar senha - backend
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                          child: AlertDialog(
                            title: const Text('Sucesso!'),
                            content: const Text('A lista foi criada.'),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _confirmNewWishlist("My Wishlist");
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacementNamed(
                                        '/WishlistScreen');
                                  },
                                  child: const Text('Continuar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text('Adicionar lista'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "As minhas listas",
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.left,
            ),
            Text(
              "${_wishlists.length} listas",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _wishlists.length,
              itemBuilder: (context, index) {
                final wishlist = _wishlists[index];
                final wishlistItemsData =
                    wishlist['items'] as List<Map<String, String>>;
                final wishlistName = wishlist['name'] as String;
                final wishlistItems = wishlistItemsData.map((itemData) {
                  return WishlistItem(
                    name: itemData['name']!,
                    imageUrl: itemData['imageUrl']!,
                  );
                }).toList();

                return Card(
                  child: ListTile(
                    title: Text(wishlistName),
                    subtitle:
                        Text('Quantidade de itens: ${wishlistItems.length}'),
                    onTap: () {
                      // Handle list tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WishlistItemsScreen(wishlistItems: wishlistItems),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Center(
                            child: AlertDialog(
                              title: const Text('Delete Wishlist'),
                              content: Text(
                                  'Are you sure you want to delete this wishlist?'),
                              actions: [
                                // Dialog actions will be added
                                ElevatedButton(
                                  onPressed: () {
                                    _deleteWishlist(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                        child: AlertDialog(
                          title: const Text('Create New Wishlist'),
                          content: TextField(
                            onChanged: (value) {
                              _newWishlistName = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Wishlist Name',
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                _confirmNewWishlist(_newWishlistName);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Create'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Create Wishlist'),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
