import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  List<ShoppingCartScreen> _shoppingList = [];
  int _number = 0;
  _ShoppingCartScreen(this.emailName);

  @override
  void initState() {
    super.initState();
    _number = widget.number;
  }

  void _incrementarContador() {
    setState(() {
      _number++;
    });
  }

  void _decrementarContador() {
    setState(() {
      if (_number > 0) {
        _number--;
      }
    });
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

    return emailName.isEmpty
        ? _emptyShoppingCard(context)
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SingleChildScrollView(
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
                      "2 artigos",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 20),
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
                              margin: const EdgeInsets.only(left: 5, top: 5),
                              child: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.4,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/prod-cao1.png"))),
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
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              "Biscoito para cão Biscrok",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Row(children: [
                              Text("Biscrok",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: Text("4.7",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                              const Icon(
                                Icons.star_half,
                                size: 15,
                              ),
                            ]),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(children: [
                              Text("5.99€",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Padding(
                                  padding: const EdgeInsets.only(left: 5),
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
                                onTap: _decrementarContador,
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
                                    color: Color.fromARGB(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                              Text(
                                '$_number',
                                style: const TextStyle(fontSize: 20),
                              ),
                              InkWell(
                                onTap: _incrementarContador,
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
                                    color: Color.fromARGB(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

class ShoppingCard {
  final String name;
  final String brand;
  final String price;
  final String discount;
  final String review;
  final String image;

  ShoppingCard(
      {required this.name,
      required this.brand,
      required this.price,
      required this.discount,
      required this.review,
      required this.image});
}
