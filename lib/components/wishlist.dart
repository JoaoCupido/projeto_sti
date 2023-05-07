import 'product.dart';

enum WishlistType { private, shared, public }

extension WishlistTypeExtension on WishlistType {
  String get name {
    switch (this) {
      case WishlistType.public:
        return 'Público';
      case WishlistType.private:
        return 'Privado';
      case WishlistType.shared:
        return 'Partilhado';
      default:
        return '';
    }
  }
}

class Wishlist {
  final int id;
  final String name;
  final List<Product> products;
  final WishlistType type;

  Wishlist({
    required this.id,
    required this.name,
    required this.products,
    required this.type,
  });

  Wishlist copyWith({
    String? name,
    List<Product>? products,
    WishlistType? type,
  }) {
    return Wishlist(
      id: id,
      name: name ?? this.name,
      products: products ?? this.products,
      type: type ?? this.type,
    );
  }
}

Wishlist myWishlist1 = Wishlist(
  id: 1,
  name: 'Lista de desejos 1',
  products: List.from(popularProducts),
  type: WishlistType.public,
);

Wishlist myWishlist2 = Wishlist(
  id: 2,
  name: 'Lista de desejos 2',
  products: List.from(popularProducts),
  type: WishlistType.private,
);

final wishlistList = [myWishlist1, myWishlist2];