import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/components/credit_card.dart';
import 'package:projeto_sti/components/price.dart';

import 'bottom_nav_bar_screen.dart';
import 'buttons.dart';
import 'components/billing.dart';
import 'components/search_bar.dart';
import 'components/shopping_item.dart';

class PaymentScreen extends StatefulWidget {
  final Map args;
  PaymentScreen({Key? key, required this.args}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(args);
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  Map args;
  int _currentStep = 0;
  int _selectedCard = 0;
  int _selectedAddress = 0;
  int _isPresent = 0;
  String _presentMessage = "";
  String _presentRecipient = "";
  List<Step> _steps = [];
  List<CreditCard> _creditsCards = [creditCard1, creditCard2];
  List<Billing> _billings = [billing1];
  _PaymentScreenState(this.args);

  late TabController _tabController;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cardController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  TextEditingController _presentMessageController = TextEditingController();
  TextEditingController _presentRecipientController = TextEditingController();

  bool availableData = false;
  late List<ShoppingCard> items = [];
  late double total = 0;

  late String emailName = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _tabController = TabController(length: 5, vsync: this);
    _controller.addListener((_handleTabSelection));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailName = args['emailName'];
    items = args['items'];
    total = args['total'];
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {});
    }
  }

  void handleTabTap(int index) {
    Navigator.popUntil(context, (route) => !Navigator.canPop(context));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BottomNavBarScreen(
            args: {'index': index, 'emailName': emailName})));
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _cardController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Widget emptySelectPayment() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/billingPayment/128.svg',
          width: 250,
          height: 250,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Lista de Cartões Vazia",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(right: 40, left: 40),
          child: Text(
            "Não tem nenhum cartão de credito salvo. Por favor adicione um novo cartão de credito na sua conta",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'Adicionar cartão',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget emptySelectAddress() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(top: 20, left: 20),
        alignment: Alignment.topLeft,
        child: Text("Dados de faturação",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.start),
      ),
      SvgPicture.asset(
        'assets/images/billingPayment/128.svg',
        width: 250,
        height: 250,
      ),
      Container(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Dados de Faturação Vazia",
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 40, left: 40),
        child: Text(
          "Não tem nenhum cartão de credito salvo. Por favor, adicione um novo cartão de credito na sua conta",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Adicionar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    ]);
  }

  Widget selectAdress() {
    return _billings.isEmpty
        ? emptySelectAddress()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 5),
                alignment: Alignment.topLeft,
                child: const Text("Dados de faturação",
                    style: TextStyle(fontSize: 30, color: Colors.black87),
                    textAlign: TextAlign.start),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5, left: 5, bottom: 30),
                alignment: Alignment.topLeft,
                child: const Text("Escolhe um dos dados de faturação",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.start),
              ),
              for (int i = 0; i < _billings.length; i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: RadioListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_billings[i].owner),
                          Text(_billings[i].phoneNumber.toString()),
                          Text(_billings[i].address)
                        ]),
                    value: i,
                    groupValue: _selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddress = value!;
                      });
                    },
                  ),
                )
            ],
          );
  }

  Widget selectPayment() {
    return _creditsCards.isEmpty
        ? emptySelectPayment()
        : Column(
            children: [
              for (int i = 0; i < _creditsCards.length; i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: RadioListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: Row(children: [
                      Expanded(
                          child: Text("${_creditsCards[i].number}  -  Visa")),
                      const Icon(Icons.credit_card)
                    ]),
                    value: i,
                    groupValue: _selectedCard,
                    onChanged: (value) {
                      setState(() {
                        _selectedCard = value!;
                      });
                    },
                  ),
                )
            ],
          );
  }

  Widget insertCard() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/billingPayment/82-1.svg',
          width: 120,
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: _cardController,
                decoration: InputDecoration(
                  labelText: 'Número do cartão de crédito',
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
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome do titular',
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
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(flex: 2, child: _buildDateInput(context)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _creditsCards.add(CreditCard(
                        number: _cardController.text.toString(),
                        cvv: int.parse(_cvvController.text.toString()),
                        owner: _nameController.text.toString(),
                        dateExpiration: _selectedDate.toString()));
                    _controller.animateTo(0);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget isNotPresent() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.surface,
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: RadioListTile(
        activeColor: Theme.of(context).colorScheme.primary,
        title: Row(children: const [
          Expanded(child: Text("Não é um presente")),
          Icon(Icons.card_giftcard)
        ]),
        value: 0,
        groupValue: _isPresent,
        onChanged: (value) {
          setState(() {
            _isPresent = value!;
          });
        },
      ),
    );
  }

  Widget isPresent() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(children: [
          RadioListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            title: Row(children: const [
              Expanded(child: Text("É um presente")),
              Icon(Icons.card_giftcard)
            ]),
            value: 1,
            groupValue: _isPresent,
            onChanged: (value) {
              setState(() {
                _isPresent = value!;
              });
            },
          ),
          const Divider(
            color: Colors.black87,
          ),
          Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, left: 20, right: 20, top: 10),
              child: TextField(
                controller: _presentMessageController,
                decoration: InputDecoration(
                  labelText: 'Mensagem - Máximo de 100 carateres',
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
              )),
          Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, left: 20, right: 20, top: 10),
              child: TextField(
                controller: _presentRecipientController,
                decoration: InputDecoration(
                  labelText: 'Destinatário do presente',
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
              ))
        ]));
  }

  Widget selectPresent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 5),
          alignment: Alignment.topLeft,
          child: const Text("Presente",
              style: TextStyle(fontSize: 30, color: Colors.black87),
              textAlign: TextAlign.start),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5, left: 5, bottom: 30),
          alignment: Alignment.topLeft,
          child: const Text("Escolhe a opção do tipo de encomenda",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.start),
        ),
        isNotPresent(),
        isPresent()
      ],
    );
  }

  Widget confirmBuy() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 5),
          alignment: Alignment.topLeft,
          child: const Text("Confirmar Encomenda",
              style: TextStyle(fontSize: 30, color: Colors.black87),
              textAlign: TextAlign.start),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 5),
          alignment: Alignment.topLeft,
          child: Text("Total:  €$total",
              style: const TextStyle(fontSize: 20, color: Colors.black87),
              textAlign: TextAlign.start),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
          alignment: Alignment.topLeft,
          child: Text("${"O meu carrinho - ${items.length}"} artigos",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.start),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 10, left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: items
                    .map((item) => Container(
                          width: screenWidth * 0.35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 5),
                                  child: SvgPicture.asset(
                                    item.image,
                                    width: screenWidth * 0.1,
                                    height: screenHeight * 0.1,
                                  )),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.brand,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: CalculatePrice(
                                              price: item.price,
                                              discount: item.discount))),
                                  Row(children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(item.review,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blueGrey)))),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        ))
                                  ])
                                ],
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
          alignment: Alignment.topLeft,
          child: const Text("Dados de faturação",
              style: TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.start),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surface,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: RadioListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            title: Row(children: [
              Expanded(
                  child:
                      Text("${_creditsCards[_selectedCard].number}  -  Visa")),
              const Icon(Icons.credit_card)
            ]),
            value: 0,
            groupValue: _selectedCard,
            onChanged: (value) {
              setState(() {
                _selectedCard = value!;
              });
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          alignment: Alignment.topLeft,
          child: const Text("Método de pagamento",
              style: TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.start),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surface,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: RadioListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_billings[_selectedAddress].owner),
              Text(_billings[_selectedAddress].phoneNumber.toString()),
              Text(_billings[_selectedAddress].address)
            ]),
            value: 0,
            groupValue: _selectedAddress,
            onChanged: (value) {
              setState(() {
                _selectedAddress = value!;
              });
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          alignment: Alignment.topLeft,
          child: const Text("Presente",
              style: TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.start),
        ),
        _isPresent == 0 ? isNotPresent() : isPresent(),
        const SizedBox(
          height: 100,
        )
      ],
    ));
  }

  Widget _buildDropdownButton(
    String label,
    List<dynamic> items,
    dynamic value,
    ValueChanged<dynamic> onChanged,
  ) {
    return Expanded(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
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
        value: value,
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item.toString()),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  List<int> _years() {
    var currentYear = DateTime.now().year;
    return List.generate(120, (index) => currentYear - index);
  }

  List<int> _months() {
    return List.generate(12, (index) => index + 1);
  }

  Widget _buildDateInput(BuildContext context) {
    return Row(
      children: [
        _buildDropdownButton(
          'Mês',
          _months(),
          _months()[_selectedDate.month - 1],
          (value) {
            setState(() {
              _selectedDate = DateTime(_selectedDate.year,
                  _months().indexOf(value) + 1, _selectedDate.day);
            });
          },
        ),
        const SizedBox(width: 10),
        _buildDropdownButton(
          'Ano',
          _years(),
          _selectedDate.year,
          (value) {
            setState(() {
              _selectedDate =
                  DateTime(value, _selectedDate.month, _selectedDate.day);
            });
          },
        ),
      ],
    );
  }

  Widget _firstStep() {
    return Container(
      height: 500,
      child: selectAdress(),
    );
  }

  Widget _secondStep() {
    return Container(
        height: 500,
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: SafeArea(
                  child: AppBar(
                title: TabBar(
                  controller: _controller,
                  tabs: const [
                    Tab(text: "Selecionar Cartão"),
                    Tab(text: "Inserir Cartão"),
                  ],
                  labelColor: Theme.of(context).colorScheme.primary,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.blueGrey,
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
              ))),
          Expanded(
              child: SingleChildScrollView(
                  child: Center(
            child: [selectPayment(), insertCard()][_controller.index],
          )))
        ]));
  }

  Widget _thirdStep() {
    return Container(height: 500, child: selectPresent());
  }

  Widget _fourStep() {
    return Container(height: 500, child: confirmBuy());
  }

  Widget _encommended() {
    return Stack(children: [
      Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20),
          alignment: Alignment.topLeft,
          child: Text("Encomenda confirmada",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.start),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20),
          alignment: Alignment.topLeft,
          child: Text("Obrigado/a por fazer uma encomenda!",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.start),
        ),
        SvgPicture.asset(
          'assets/images/billingPayment/127-1.svg',
          width: 200,
          height: 200,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Encomenda #1234567890",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(right: 40, left: 40),
          child: Text(
            "Vai ser enviado um email de confirmação a johndoe@gmail.com",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        )
      ]),
      Buttons(
          textLeft: RichText(
              text: TextSpan(
                  text: "Total: €$total",
                  style: const TextStyle(color: Colors.black87))),
          textRight: "Concluir",
          movement: 40,
          onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBarScreen(
                      args: {'index': 0, 'emailName': emailName}),
                ),
              ))
    ]);
  }

  bool isCompleted = false;
  bool back = false;
  String textNext = "Seguinte";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    _steps = [
      Step(
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 0,
        title: Text(''),
        content: _firstStep(),
      ),
      Step(
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 1,
        title: Text(''),
        content: _secondStep(),
      ),
      Step(
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 2,
        title: Text(''),
        content: _thirdStep(),
      ),
      Step(
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 3,
        title: Text(''),
        content: _fourStep(),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      appBar: SearchBar(
        emailName: emailName,
        query: '',
      ),
      body: isCompleted == false
          ? Stack(children: [
              Stepper(
                type: StepperType.horizontal,
                currentStep: _currentStep,
                steps: _steps,
                onStepTapped: (index) {
                  setState(() => _currentStep = index);
                },
                controlsBuilder: (context, details) {
                  return const SizedBox.shrink();
                },
              ),
              Positioned(
                  bottom: 15,
                  left: screenWidth / 2 - 130,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Visibility(
                            visible: back,
                            child: Container(
                                width: screenWidth * 0.25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_currentStep != 0) {
                                        setState(() {
                                          _currentStep--;
                                          textNext = "Seguinte";
                                          if (_currentStep == 0) {
                                            back = false;
                                          }
                                        });
                                      }
                                    },
                                    child: const Text("Atrás")))),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        Container(
                            margin: back == false
                                ? EdgeInsets.only(left: screenWidth * 0.1)
                                : null,
                            width: screenWidth * 0.25,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_currentStep != 3) {
                                    setState(() {
                                      _currentStep++;
                                      back = true;
                                      if (_currentStep == 3) {
                                        textNext = "Confirmar";
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      isCompleted = true;
                                    });
                                  }
                                },
                                child: Text(textNext)))
                      ],
                    ),
                  ))
            ])
          : _encommended(),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Theme.of(context).colorScheme.onSurface,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined)),
            Tab(icon: Icon(Icons.menu_outlined)),
            Tab(icon: Icon(Icons.shopping_cart_outlined)),
            Tab(icon: Icon(Icons.favorite_outline)),
            Tab(icon: Icon(Icons.delivery_dining_outlined)),
          ],
          onTap: handleTabTap,
        ),
      ),
    );
  }
}

class ItemShopping {
  final String itemTitle;
  final String itemBrand;
  final String itemPrice;
  final String itemDiscount;
  final String itemImage;
  final String itemReview;

  ItemShopping(
      {required this.itemTitle,
      required this.itemBrand,
      required this.itemPrice,
      required this.itemDiscount,
      required this.itemImage,
      required this.itemReview});
}
