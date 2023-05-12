import 'dart:async';
import 'package:synchronized/synchronized.dart';
import 'package:projeto_sti/components/shopping_item.dart';

class ShoppingList {
  static final lock = Lock();
  static final List<ShoppingCard> _shoppingList = [shoppingCard1];

  static Future<void> addItem(String name, String brand, String price,
      String discount, String review, String image) async {
    lock.synchronized(() {
      ShoppingCard shoppingCard = ShoppingCard(
          name: name,
          brand: brand,
          price: price,
          discount: discount,
          review: review,
          image: image,
          quantity: 1);
      _shoppingList.add(shoppingCard);
    });
  }

  static void removeItem(ShoppingCard shoppingCard) {
    lock.synchronized(() {
      _shoppingList.remove(shoppingCard);
    });
  }

  static List<ShoppingCard> getItems() {
    return _shoppingList;
  }
}
