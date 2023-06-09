import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  List<List<String>> paymentMethodLists = [
    [
      '**** 4444 - Visa',
      '**** 5555 - Mastercard',
      '**** 7777 - American Express'
    ],
    ['45378475373456', '87346793457656'],
    ['Paypal1', 'paypal2'],
    ['123456789'],
  ];
  bool showItems = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Métodos de pagamento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < paymentMethodLists.length; i++)
              PaymentMethodList(
                title: getPaymentMethodTitle(i),
                predefinedItems: paymentMethodLists[i],
                onDeleteItem: (index) {
                  setState(() {
                    paymentMethodLists[i].removeAt(index);
                  });
                },
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Criar'),
              onPressed: () {
                // Add logic to create a new payment method
                Navigator.of(context).pushNamed('/metodos_pagamento2');
              },
            ),
          ],
        ),
      ),
    );
  }

  String getPaymentMethodTitle(int index) {
    switch (index) {
      case 0:
        return 'Cartão de crédito';
      case 1:
        return 'Referência Multibanco';
      case 2:
        return 'PayPal';
      case 3:
        return 'MBWay';
      default:
        return '';
    }
  }
}

class PaymentMethodList extends StatefulWidget {
  final String title;
  final List<String> predefinedItems;
  final Function(int) onDeleteItem;

  const PaymentMethodList({
    Key? key,
    required this.title,
    required this.predefinedItems,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  _PaymentMethodListState createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  bool showItems = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            ElevatedButton(
              child: Text(showItems ? 'Esconder itens' : 'Mostrar itens'),
              onPressed: () {
                setState(() {
                  showItems = !showItems;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 8.0),
        if (showItems)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < widget.predefinedItems.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.predefinedItems[i]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        widget.onDeleteItem(i);
                      },
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}
