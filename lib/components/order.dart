import 'billing.dart';
import 'credit_card.dart';
import 'product.dart';

class Order {
  final int id;
  final int code;
  final String dateCreated;
  final String dateEstimated;
  final List<Product> products;
  final Billing billing;
  final CreditCard payment;
  final bool? isGift;
  final String? giftDescription;
  final String? giftEmail;

  Order({
    required this.id,
    required this.code,
    required this.dateCreated,
    required this.dateEstimated,
    required this.products,
    required this.billing,
    required this.payment,
    this.isGift,
    this.giftDescription,
    this.giftEmail,
  });
}

Order order1 = Order(id: 1, code: 123456,
    dateCreated: '13-04-2023', dateEstimated: '30-04-2023',
    products: List.from(popularProducts), billing: billing1,
    payment: creditCard1);
Order order2 = Order(id: 2, code: 123457,
    dateCreated: '13-04-2023', dateEstimated: '29-04-2023',
    products: List.from(popularProducts), billing: billing1,
    payment: creditCard2);
Order order3 = Order(id: 3, code: 123459,
    dateCreated: '14-04-2023', dateEstimated: '01-05-2023',
    products: List.from(popularProducts), billing: billing1,
    payment: creditCard1, isGift: true, giftDescription: 'Parabéns!', giftEmail: 'ben@ga.com');

final orderList = [order1, order2, order3];