import 'package:flutter/material.dart';

class CalculatePrice extends StatelessWidget {
  final String price;
  final String discount;
  const CalculatePrice({Key? key, required this.price, required this.discount})
      : super(key: key);

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
  Widget build(BuildContext context) {
    return widgetPrice(price, discount);
  }
}
