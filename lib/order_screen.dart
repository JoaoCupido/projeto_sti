import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/billing.dart';
import 'components/credit_card.dart';
import 'components/order.dart';


class OrderScreen extends StatefulWidget {
  final String emailName;

  const OrderScreen({Key? key, required this.emailName}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState(emailName);
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  String emailName;
  _OrderScreenState(this.emailName);

  List<Order> _orderList = [];

  late Order _orderChosen;

  @override
  void initState() {
    super.initState();
    _orderList = List.of(orderList);
    _orderChosen = Order(id: 0, code: 0,
        dateCreated: '', dateEstimated: '',
        products: [],
        billing: Billing(owner: '',
            nif: 0, address: '', zipCode:
            '', city: '', phoneNumber: 0),
        payment: CreditCard(number: 0,
            cvv: 0, owner: '',
            dateExpiration: ''));
  }

  @override
  Widget build(BuildContext context) {
    if (emailName.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Text("As minhas encomendas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 8.0),
              Text("0 encomendas",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
              SvgPicture.asset(
                'assets/images/218-emptyOrder.svg',
                width: 250,
                height: 250,
              ),
              Text("Sem sessão iniciada",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    "Faça compras para depois serem entregues à sua porta. De momento, só é possível fazer compras e encomendas com sessão de conta iniciada.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text('Iniciar sessão'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (_orderList.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Text("As minhas encomendas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 8.0),
              Text("0 encomendas",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
              SvgPicture.asset(
                'assets/images/218-emptyOrder.svg',
                width: 250,
                height: 250,
              ),
              Text("Sem encomendas",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    "Faça compras para depois serem entregues à tua porta. Além disso, é notificado e atualizado constantemente o percurso da encomenda.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //Inserir caminho para o menu do carrinho de compras
                    },
                    child: const Text('O meu carrinho'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (_orderChosen.dateCreated.isNotEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32.0),

                  const SizedBox(height: 16.0),

                  const SizedBox(height: 24.0),
                  Text(
                    'O meu carrinho (${_orderChosen.products.length} ${_orderChosen.products.length == 1 ? 'artigo' : 'artigos'})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),

                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _orderChosen = Order(id: 0, code: 0,
                  dateCreated: '', dateEstimated: '',
                  products: [],
                  billing: Billing(owner: '',
                      nif: 0, address: '', zipCode:
                      '', city: '', phoneNumber: 0),
                  payment: CreditCard(number: 0,
                      cvv: 0, owner: '',
                      dateExpiration: ''));
            });
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32.0),
            Text(
              "As minhas encomendas",
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              "${_orderList.length} ${_orderList.length == 1 ? 'encomenda' : 'encomendas'}",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 300.0,
              child: DropdownButtonFormField(
                value: 'code_asc',
                decoration: InputDecoration(
                  labelText: 'Ordenar por',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'code_asc',
                    child: Text('Código (Menor-Maior)'),
                  ),
                  DropdownMenuItem(
                    value: 'code_desc',
                    child: Text('Código (Maior-Menor)'),
                  ),
                  DropdownMenuItem(
                    value: 'date_asc',
                    child: Text('Data criada (Antigo-Recente)'),
                  ),
                  DropdownMenuItem(
                    value: 'date_desc',
                    child: Text('Tipo (Recente-Antigo)'),
                  ),
                ],
                onChanged: (value) {
                  switch (value) {
                    case 'code_asc':
                      setState(() {
                        _orderList.sort((a, b) => a.code.compareTo(b.code));
                      });
                      break;
                    case 'code_desc':
                      setState(() {
                        _orderList.sort((a, b) => b.code.compareTo(a.code));
                      });
                      break;
                    case 'date_asc':
                      setState(() {
                        _orderList.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
                      });
                      break;
                    case 'date_desc':
                      setState(() {
                        _orderList.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
                      });
                      break;
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _orderList.length,
              itemBuilder: (context, index) {
                final order = _orderList[index];
                return Card(
                  child: ListTile(
                    title: Text('Encomenda #${order.code}'),
                    subtitle:
                    Text('Criada: ${order.dateCreated}\n'
                        '${order.products.length} ${order.products.length == 1 ? 'item' : 'itens'}\n'
                        'Estimada: ${order.dateEstimated}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _orderChosen = order;
                        });
                      },
                      child: const Text('Ver detalhes'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
