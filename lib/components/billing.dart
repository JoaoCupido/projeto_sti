class Billing {
  final String owner;
  final int nif;
  final String address;
  final String zipCode;
  final String city;
  final String country;
  final int phoneNumber;

  Billing({
    required this.owner,
    required this.nif,
    required this.address,
    required this.zipCode,
    required this.city,
    this.country = 'Portugal',
    required this.phoneNumber,
  });
}

Billing billing1 = Billing(owner: 'Fulano de Tal', nif: 123456789, address: 'Apart 2º nº34 Rua Este 1', zipCode: '9000-890', city: 'Lisboa', phoneNumber: 123456789);