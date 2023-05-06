import 'package:flutter/material.dart';
import 'classes/wishlist.dart';

class WishlistItemsScreen extends StatelessWidget {

  final Wishlist wishlist;
  WishlistItemsScreen({Key? key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wishlist.name),
      ),
      body: ListView.builder(
        itemCount: wishlist.products.length,
        itemBuilder: (context, index) {
          final item = wishlist.products[index];
          return ListTile(
            title: Text(item.title),
            leading: Image.asset(item.imageUrl),
          );
        },
      ),
    );
  }
}
