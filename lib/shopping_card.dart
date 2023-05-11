import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/components/price.dart';
import 'package:projeto_sti/payment_screen.dart';
import 'buttons.dart';
import 'components/shopping_item.dart';

class ShoppingCartScreen extends StatefulWidget {
  final String emailName;
  final int number = 0;
  const ShoppingCartScreen({Key? key, required this.emailName})
      : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreen(emailName);

  static addItem(String name, String brand, String price, String discount,
      String review, String image) {
    _ShoppingCartScreen.addItem(name, brand, price, discount, review, image);
  }
}

class _ShoppingCartScreen extends State<ShoppingCartScreen>
    with SingleTickerProviderStateMixin {
  String emailName;

  static List<ShoppingCard> _shoppingList = [shoppingCard1];

  _ShoppingCartScreen(this.emailName);

  @override
  void initState() {
    super.initState();
  }

  void _incrementarContador(ShoppingCard shoppingCard) {
    setState(() {
      shoppingCard.quantity++;
    });
  }

  void _decrementarContador(ShoppingCard shoppingCard) {
    setState(() {
      if (shoppingCard.quantity > 1) {
        shoppingCard.quantity--;
      }
    });
  }

  List<ShoppingCard> getItems() {
    return _shoppingList;
  }

  static void addItem(String name, String brand, String price, String discount,
      String review, String image) {
    ShoppingCard shoppingCard = ShoppingCard(
        name: name,
        brand: brand,
        price: price,
        discount: discount,
        review: review,
        image: image,
        quantity: 1);
    _shoppingList.add(shoppingCard);
  }

  double calculateTotal() {
    double total = 0;
    for (var item in _shoppingList) {
      total += (double.parse(item.price) - double.parse(item.discount)) *
          item.quantity;
    }
    return total;
  }

  Widget _emptyShoppingCard(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20),
            alignment: Alignment.topLeft,
            child: Text("O meu carrinho",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 2.0, left: 20.0),
            alignment: Alignment.topLeft,
            child: Text("0 artigos",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center),
          ),
          SvgPicture.asset(
            'assets/images/shoppingCard/336.svg',
            width: 250,
            height: 250,
          ),
          Container(
            alignment: Alignment.center,
            child: Text("Carrinho Vazio",
                style: Theme.of(context).textTheme.displayMedium),
          ),
          Container(
            padding: const EdgeInsets.only(right: 30, left: 30),
            alignment: Alignment.center,
            child: Text(
                "Navegue na nossa loja, descubra a nossa lista de produtos disponíveis para si e adiciona-as ao carrinho de compras",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return _shoppingList.isEmpty
        ? _emptyShoppingCard(context)
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "O meu carrinho",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${_shoppingList.length} artigos",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            children: _shoppingList
                                .map(
                                  (item) => Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 20),
                                    height: screenHeight * 0.2,
                                    width: screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: const EdgeInsets.only(
                                              left: 5, top: 5),
                                          child: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Expanded(
                                            child: SvgPicture.asset(
                                              item.image,
                                              width: screenWidth * 0.24,
                                              height: screenHeight * 0.11,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: screenHeight * 0.2,
                                    width: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 3,
                                      ),
                                    ),
                                    child: Column(children: [
                                      Container(
                                        alignment:
                                        AlignmentDirectional.topStart,
                                        child: Text(
                                          item.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        alignment:
                                        AlignmentDirectional.topStart,
                                        child: Row(children: [
                                          Text(item.brand,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 70),
                                            child: Text(item.review,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                          ),
                                          const Icon(
                                            Icons.star_half,
                                            size: 15,
                                          ),
                                        ]),
                                      ),
                                      Container(
                                        height: screenHeight * 0.04,
                                        alignment:
                                        AlignmentDirectional.bottomCenter,
                                        child: CalculatePrice(
                                            price: item.price,
                                            discount: item.discount,
                                            quantity: item.quantity),
                                      ),
                                      Container(
                                        margin:
                                        const EdgeInsets.only(top: 20),
                                        height: screenHeight * 0.05,
                                        width: screenWidth * 0.28,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(children: [
                                          InkWell(
                                            onTap: () =>
                                                _decrementarContador(item),
                                            child: Container(
                                              margin: const EdgeInsets.all(6),
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.08,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.orange,
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color: Theme.of(context).colorScheme.surface,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: screenWidth * 0.04,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  item.quantity.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              )),
                                          InkWell(
                                            onTap: () =>
                                                _incrementarContador(item),
                                            child: Container(
                                              margin: const EdgeInsets.all(6),
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.08,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.orange,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: Theme.of(context).colorScheme.surface,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            )
                                .toList())),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
              Buttons(
                  movement: 30,
                  textLeft: RichText(
                      text: TextSpan(
                    text: "Total: €${calculateTotal().toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  )),
                  textRight: "Comprar",
                  icon: Icons.shopping_cart,
                  onPress: () {
                    if( emailName.isNotEmpty)
                      {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                  PaymentScreen(args: {
                                    'items': getItems(),
                                    'total': calculateTotal(),
                                    'emailName': emailName,
                                  })
                            )
                        );
                      }
                    else
                      {
                        Navigator.of(context).pushReplacementNamed('/login');
                      }
                  })
            ]));
  }
}
