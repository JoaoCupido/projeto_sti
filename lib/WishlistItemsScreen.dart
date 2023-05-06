import 'package:flutter/material.dart';
import 'wishlist_item.dart';

class WishlistItemsScreen extends StatelessWidget {
  final List<WishlistItem> wishlistItems;

  WishlistItemsScreen({required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Items'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return ListTile(
            title: Text(item.name),
            leading: Image.network(item.imageUrl),
          );
        },
      ),
    );
  }
}
