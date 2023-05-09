import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentMethodsPage2 extends StatefulWidget {
  @override
  _PaymentMethodsPage2State createState() => _PaymentMethodsPage2State();
}

class _PaymentMethodsPage2State extends State<PaymentMethodsPage2> {
  String selectedMethod = 'credit_card';
  TextEditingController dateController = TextEditingController();
  TextEditingController multibancoController = TextEditingController();
  TextEditingController paypalLoginController = TextEditingController();
  TextEditingController paypalPasswordController = TextEditingController();
  TextEditingController mbwPhoneNumberController = TextEditingController();

  void selectMethod(int index) {
    String method = '';
    switch (index) {
      case 0:
        method = 'credit_card';
        break;
      case 1:
        method = 'house';
        break;
      case 2:
        method = 'paypal';
        break;
      case 3:
        method = 'mbw';
        break;
    }
    setState(() {
      selectedMethod = method;
    });
  }

  @override
  void dispose() {
    dateController.dispose();
    multibancoController.dispose();
    paypalLoginController.dispose();
    paypalPasswordController.dispose();
    mbwPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Métodos de pagamento'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0), // Add padding around the text fields
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  isSelected: [
                    selectedMethod == 'credit_card',
                    selectedMethod == 'house',
                    selectedMethod == 'paypal',
                    selectedMethod == 'mbw',
                  ],
                  onPressed: (index) {
                    selectMethod(index);
                  },
                  children: [
                    Icon(Icons.credit_card),
                    Icon(Icons.home),
                    Icon(Icons.paypal),
                    Icon(Icons.mobile_screen_share),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            if (selectedMethod == 'credit_card') ...[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Número do cartão de crédito',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome do Titular',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      inputFormatters: [_DateInputFormatter()], // Add this line
                      decoration: InputDecoration(
                        labelText: 'Data (DD/MM/AAAA)',
                        hintText: 'Digite a data',
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle create button press
                    Navigator.pop(context);
                  },
                  child: Text('Criar'),
                ),
              ),
            ],
            if (selectedMethod == 'house') ...[
              TextField(
                controller: multibancoController,
                decoration: InputDecoration(
                  labelText: 'Referência Multibanco',
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle create button press
                    Navigator.pop(context);
                  },
                  child: Text('Criar'),
                ),
              ),
            ],
            if (selectedMethod == 'paypal') ...[
              TextField(
                controller: paypalLoginController,
                decoration: InputDecoration(
                  labelText: 'Login',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: paypalPasswordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle create button press
                    Navigator.pop(context);
                  },
                  child: Text('Criar'),
                ),
              ),
            ],
            if (selectedMethod == 'mbw') ...[
              TextField(
                controller: mbwPhoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle create button press
                    Navigator.pop(context);
                  },
                  child: Text('Criar'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _formatDate(newValue.text);
    final cursorOffset = newValue.selection.baseOffset + 1;

    TextSelection newSelection = TextSelection.collapsed(
      offset: cursorOffset > text.length ? text.length : cursorOffset,
    );

    return TextEditingValue(
      text: text,
      selection: newSelection,
    );
  }

  String _formatDate(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');

    if (value.length < 3) {
      return value;
    } else if (value.length < 5) {
      return '${value.substring(0, 2)}/${value.substring(2)}';
    } else if (value.length < 9) {
      return '${value.substring(0, 2)}/${value.substring(2, 4)}/${value.substring(4)}';
    } else {
      return '${value.substring(0, 2)}/${value.substring(2, 4)}/${value.substring(4, 8)}';
    }
  }
}
