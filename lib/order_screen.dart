import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/billing.dart';
import 'components/credit_card.dart';
import 'components/order.dart';
import 'components/order_progress_bar.dart';
import 'item_screen.dart';


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
  final List<String> _textSteps = ['Confirmada', 'A preparar', 'A ser entregue', 'Entregue'];

  @override
  void initState() {
    super.initState();
    _orderList = List.of(orderList);
    _orderChosen = orderDebug;
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
                  Text("Encomenda #${_orderChosen.code}",
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16.0),
                  Text(
                    'Criada: ${_orderChosen.dateCreated}\nEstimada: ${_orderChosen.dateEstimated}',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  OrderProgress(textSteps: _textSteps,
                      currentStep: _orderChosen.stageProgress ?? 0),
                  const SizedBox(height: 24.0),
                  Text(
                    'Detalhes da encomenda',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  _buildOrderProductsList(context,
                      'O meu carrinho (${_orderChosen.products.length} ${_orderChosen.products.length == 1 ? 'artigo' : 'artigos'})'),
                  const SizedBox(height: 8.0),
                  _buildBillingRectangle(context, 'Dados de faturação'),
                  const SizedBox(height: 8.0),
                  _buildPaymentRectangle(context, 'Método de pagamento'),
                  if (_orderChosen.isGift != null)
                    Column(
                      children: [
                        const SizedBox(height: 8.0),
                        _buildGiftRectangle(context, 'Presente'),
                      ],
                    ),
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _orderChosen = orderDebug;
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

  Widget _buildOrderProductsList(BuildContext context, String textLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            textLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 225,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _orderChosen.products.length,
            itemBuilder: (BuildContext context, int index) {
              final popularProduct = _orderChosen.products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    //TODO: Navigate to product details screen
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemScreen(
                                    args: {'query': '', 'emailName': emailName, 'itemTitle': 'Biscoito para cão Biscrok'}
                                )
                        )
                    );
                  },
                  child: SizedBox(
                    width: 150,
                    child: Card(
                      elevation: 4,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    popularProduct.imageUrl,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      popularProduct.title,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      popularProduct.brand,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          '€${popularProduct.price}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        if (popularProduct.discountPrice != null)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: Text(
                                              '€${popularProduct.discountPrice}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                decoration:
                                                TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceVariant,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${popularProduct.rating}',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Quantidade: 1',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBillingRectangle(BuildContext context, String textLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            textLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Detalhes:', textAlign: TextAlign.center),
            subtitle:
              Text('Nome e Apelido: ${_orderChosen.billing.owner}\n'
                'NIF: ${_orderChosen.billing.nif}\n'
                'Morada: ${_orderChosen.billing.address}\n'
                '${_orderChosen.billing.zipCode} ${_orderChosen.billing.city} - ${_orderChosen.billing.country}\n'
                'Telemóvel: ${_orderChosen.billing.phoneNumber}',
                textAlign: TextAlign.center
              ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRectangle(BuildContext context, String textLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            textLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Detalhes:', textAlign: TextAlign.center),
            subtitle:
            Text('Método: Cartão de Crédito\n'
                'Nome do titular: ${_orderChosen.payment.owner}\n'
                'Número do cartão: ${_orderChosen.payment.number}',
                textAlign: TextAlign.center
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGiftRectangle(BuildContext context, String textLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            textLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Detalhes:', textAlign: TextAlign.center),
            subtitle:
            Text('Mensagem: ${_orderChosen.giftDescription}\n'
                'Destinatário: ${_orderChosen.giftEmail}',
                textAlign: TextAlign.center
            ),
          ),
        ),
      ],
    );
  }
}
