import 'package:flutter/material.dart';

class BillingDataPage2 extends StatefulWidget {
  @override
  _BillingDataPage2State createState() => _BillingDataPage2State();
}

class _BillingDataPage2State extends State<BillingDataPage2> {
  final TextEditingController nomeApelidoController = TextEditingController();
  final TextEditingController nifController = TextEditingController();
  final TextEditingController moradaController = TextEditingController();
  final TextEditingController codigoPostalController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController telemovelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de Faturação'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nomeApelidoController,
                decoration: InputDecoration(
                  labelText: 'Nome e Apelido',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: nifController,
                decoration: InputDecoration(
                  labelText: 'NIF',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: moradaController,
                decoration: InputDecoration(
                  labelText: 'Morada',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: codigoPostalController,
                decoration: InputDecoration(
                  labelText: 'Código Postal',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: cidadeController,
                decoration: InputDecoration(
                  labelText: 'Cidade',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: paisController,
                decoration: InputDecoration(
                  labelText: 'País',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: telemovelController,
                decoration: InputDecoration(
                  labelText: 'Telemovel',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Salvar e Sair'),
                onPressed: () {
                  // Add logic to save form data and navigate back or perform additional actions
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
