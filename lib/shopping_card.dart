import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/components/price.dart';

import 'buttons.dart';
import 'components/shopping_item.dart';

class ShoppingCartScreen extends StatefulWidget {
  final String emailName;
  final int number = 0;
  const ShoppingCartScreen({Key? key, required this.emailName})
      : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreen(emailName);
}

class _ShoppingCartScreen extends State<ShoppingCartScreen>
    with SingleTickerProviderStateMixin {
  String emailName;
  List<ShoppingCard> _shoppingList = [shoppingCard1];
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
      if (shoppingCard.quantity > 0) {
        shoppingCard.quantity--;
      }
    });
  }

  List<ShoppingCard> getItems() {
    return _shoppingList;
  }

  ShoppingCard searchItem(dynamic data, String item) {
    return ShoppingCard(
        name: data[item]["itemTitle"],
        brand: data[item]["itemBrand"],
        price: data[item]["itemPrice"],
        discount: data[item]["itemDiscount"],
        review: data[item]["itemReview"],
        image: data[item]["itemImages"][0],
        quantity: 0);
  }

  void addItem(String item) {
    final String response =
        rootBundle.loadString('assets/produtos.json') as String;
    setState(() {
      final data = json.decode(response);
      ShoppingCard shoppingCard = searchItem(data, item);
      _shoppingList.add(shoppingCard);
    });
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
              SingleChildScrollView(
                child: Column(
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
                    Column(
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
                                        Container(
                                          height: screenHeight * 0.2,
                                          width: screenWidth * 0.4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                      AssetImage(item.image))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: screenHeight * 0.2,
                                    width: screenWidth * 0.4,
                                    decoration: BoxDecoration(
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
                                            padding:
                                                const EdgeInsets.only(left: 70),
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
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Row(children: [
                                          CalculatePrice(
                                              price: item.price,
                                              discount: item.discount,
                                              quantity: item.quantity),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text("7̶.̶9̶9̶€̶",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium)),
                                        ]),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        height: screenHeight * 0.05,
                                        width: screenWidth * 0.27,
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
                                              child: const Icon(
                                                Icons.remove,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            item.quantity.toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
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
                                              child: const Icon(
                                                Icons.add,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 1),
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
                            .toList())
                  ],
                ),
              ),
              Buttons(
                  textLeft:
                      RichText(text: TextSpan(text: calculateTotal.toString())),
                  textRight: "Comprar",
                  icon: Icons.shopping_cart,
                  onPress: () => {})
            ]));
  }
}
