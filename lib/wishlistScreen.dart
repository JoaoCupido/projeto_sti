import 'package:flutter/material.dart';

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

class _WishlistScreenState extends State<WishlistScreen> {
  String _newWishlistName = "";
  List<WishlistItem> _wishlistItems = [];
  List<Map<String, dynamic>> _wishlists = [
    {
      "name": "My Wishlist",
      "items": [
        WishlistItem(
          name: "Item 1",
          imageUrl: "https://via.placeholder.com/150",
        ),
        WishlistItem(
          name: "Item 2",
          imageUrl: "https://via.placeholder.com/150",
        ),
        WishlistItem(
          name: "Item 3",
          imageUrl: "https://via.placeholder.com/150",
        ),
      ],
    },
  ];
  String _currentWishlistName = "My Wishlist";

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

  @override
  Widget build(BuildContext context) {
    if (_wishlists.isEmpty) {
      return Container();
    }
    return Container();
  }
}
