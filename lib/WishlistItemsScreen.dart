import 'package:flutter/material.dart';

class WishlistItemsScreen extends StatelessWidget {
  final Map<String, String> wishlistItems1;

  WishlistItemsScreen({required this.wishlistItems1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Items'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems1.length,
        itemBuilder: (context, index) {
          final itemName = wishlistItems1.keys.elementAt(index);
          final itemImageUrl = wishlistItems1[itemName];

          return ListTile(
            title: Text(itemName),
            leading: Image.network(itemImageUrl!),
          );
        },
      ),
    );
  }
}

class WishlistItem {
  final String name;
  final String imageUrl;

  WishlistItem({required this.name, required this.imageUrl});
}
