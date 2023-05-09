import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillingDataPage extends StatefulWidget {
  @override
  _BillingDataPageState createState() => _BillingDataPageState();
}

class _BillingDataPageState extends State<BillingDataPage> {
  // Sample list of predefined methods of faturação
  final List<MethodOfFaturacao> predefinedMethodsOfFaturacao = [
    MethodOfFaturacao('Method 1', '123456789', 'Billing Address 1'),
    MethodOfFaturacao('Method 2', '987654321', 'Billing Address 2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de faturação'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.0),
          if (predefinedMethodsOfFaturacao.isEmpty)
            Column(
              children: [
                SvgPicture.asset(
                  'assets/imagens/128-error.svg',
                  width: 350,
                  height: 350,
                ),
                Text(
                  'Dados de faturação vazia',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                Text('Adicione um método de faturação'),
                ElevatedButton(
                  child: Text('Adicionar método de faturação'),
                  onPressed: () {
                    // Add method of faturação logic here
                    Navigator.of(context).pushNamed('/dados_faturação2');
                  },
                ),
              ],
            )
          else
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: predefinedMethodsOfFaturacao.length + 1,
                itemBuilder: (context, index) {
                  if (index == predefinedMethodsOfFaturacao.length) {
                    // Render the button to create another method
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        child: Text('Criar outro método de faturação'),
                        onPressed: () {
                          // Add logic to create another method of faturação
                          Navigator.of(context).pushNamed('/dados_faturação2');
                        },
                      ),
                    );
                  } else {
                    final method = predefinedMethodsOfFaturacao[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: ListTile(
                        title: Text(method.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NIF: ${method.nif}'),
                            Text(
                                'Morada de faturação: ${method.billingAddress}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Edit method of faturação logic here
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                // Delete method of faturação logic here
                                setState(() {
                                  predefinedMethodsOfFaturacao.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

class MethodOfFaturacao {
  final String name;
  final String nif;
  final String billingAddress;

  MethodOfFaturacao(this.name, this.nif, this.billingAddress);
}
