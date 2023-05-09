import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CompareItemScreen extends StatefulWidget {
  final String itemTitle;

  const CompareItemScreen({Key? key, required this.itemTitle})
      : super(key: key);

  @override
  _CompareItemScreenState createState() => _CompareItemScreenState(itemTitle);
}

class _CompareItemScreenState extends State<CompareItemScreen>
    with SingleTickerProviderStateMixin {
  String itemTitle;
  List<CompareItem> _compareItems = [];
  bool availableData = false;
  _CompareItemScreenState(this.itemTitle);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/produtos.json');

    setState(() {
      final data = json.decode(response);
      _compareItems.add(searchItem(data, itemTitle));
      for (var item in data[itemTitle]["comparableItems"]) {
        _compareItems.add(searchItem(data, item));
      }
      availableData = true;
    });
  }

  CompareItem searchItem(dynamic data, String item) {
    return CompareItem(
        name: data[item]["itemTitle"],
        brand: data[item]["itemBrand"],
        price: data[item]["itemPrice"],
        discount: data[item]["itemDiscount"],
        review: data[item]["itemReview"],
        image: data[item]["itemImages"][0]);
  }

  Widget widgetPrice(String price, String discount) {
    if (discount != "0") {
      return RichText(
        text: TextSpan(style: const TextStyle(fontSize: 16), children: [
          TextSpan(
            style: const TextStyle(color: Colors.black87),
            text: "€${double.parse(price) - double.parse(discount)}",
          ),
          const TextSpan(text: "  "),
          TextSpan(
            text: "€$price",
            style: const TextStyle(
                decoration: TextDecoration.lineThrough, color: Colors.grey),
          )
        ]),
      );
    } else {
      return RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          text: "€${double.parse(price) - double.parse(discount)}",
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !availableData
        ? const CircularProgressIndicator()
        : Column(
            children: [
              const Text("Comparar produtos",
                  style: TextStyle(fontSize: 40, color: Colors.black87)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _compareItems
                            .map((item) => Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 15, top: 20),
                                child: Column(children: [
                                  Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () {
                                                      // TODO: Implementar ação de conta do usuário
                                                      if (itemTitle.isEmpty) {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/login');
                                                      } else {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/login');
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove_circle,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ))),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: SvgPicture.asset(
                                                    item.image,
                                                    width: 130,
                                                    height: 130)),
                                            const Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Icon(
                                                        Icons.favorite_border,
                                                        size: 30)))
                                          ],
                                        )
                                      ])),
                                  Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Column(children: [
                                        Container(
                                            child: Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black87),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                fixedSize: const Size(120,
                                                    30), // El color de fondo del botón
                                              ),
                                              onPressed: () {
                                                // Acción del botón
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.white,
                                                  ), // El icono del botón
                                                  SizedBox(
                                                      width:
                                                          5), // Un pequeño espacio entre el icono y el texto
                                                  Text(
                                                    'Carrinho',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ), // El texto del botón
                                                ],
                                              ),
                                            ))
                                      ])),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 40, bottom: 40),
                                    width: 250,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 212, 212, 212),
                                          child: const Text(
                                            "Preço",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: widgetPrice(
                                                item.price, item.discount)),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 212, 212, 212),
                                          child: const Text(
                                            "Avaliação",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(item.review,
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 16)),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 20,
                                                )
                                              ],
                                            )),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 212, 212, 212),
                                          child: const Text(
                                            "Marca",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.all(5),
                                          color: Colors.white,
                                          child: Text(
                                            item.brand,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          color: const Color.fromARGB(
                                              255, 212, 212, 212),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "Mais Informação",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(Icons.keyboard_arrow_down)
                                              ]),
                                        ),
                                      ],
                                    ),
                                  )
                                ])))
                            .toList(),
                      )))
            ],
          );
  }
}

class CompareItem {
  final String name;
  final String brand;
  final String price;
  final String discount;
  final String review;
  final String image;

  CompareItem(
      {required this.name,
      required this.brand,
      required this.price,
      required this.discount,
      required this.review,
      required this.image});
}
