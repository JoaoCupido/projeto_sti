class CreditCard {
  final int number;
  final int cvv;
  final String owner;
  final String dateExpiration;

  CreditCard({
    required this.number,
    required this.cvv,
    required this.owner,
    required this.dateExpiration,
  });
}

CreditCard creditCard1 = CreditCard(number: 1234123412341234, cvv: 1234, owner: 'Fulano de Tal', dateExpiration: '10-2026');
CreditCard creditCard2 = CreditCard(number: 5687568678658676, cvv: 6789, owner: 'Fulano de Tal', dateExpiration: '05-2028');