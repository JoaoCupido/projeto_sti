import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecoverAccount2 extends StatefulWidget {
  final String emailName;

  const RecoverAccount2({Key? key, required this.emailName}) : super(key: key);

  @override
  State<RecoverAccount2> createState() => _RecoverAccount2State(emailName);
}

class _RecoverAccount2State extends State<RecoverAccount2>
    with SingleTickerProviderStateMixin {
  String emailName;
  _RecoverAccount2State(this.emailName);

  bool _isLoading = false;

  final FocusNode _firstTextFieldFocusNode = FocusNode();
  final FocusNode _secondTextFieldFocusNode = FocusNode();
  final FocusNode _thirdTextFieldFocusNode = FocusNode();
  final FocusNode _fourthTextFieldFocusNode = FocusNode();
  final TextEditingController _firstTextFieldController =
      TextEditingController();
  final TextEditingController _secondTextFieldController =
      TextEditingController();
  final TextEditingController _thirdTextFieldController =
      TextEditingController();
  final TextEditingController _fourthTextFieldController =
      TextEditingController();

  void clearText() {
    _firstTextFieldController.clear();
    _secondTextFieldController.clear();
    _thirdTextFieldController.clear();
    _fourthTextFieldController.clear();
  }

  bool _validateEmailForm() {
    final campo1 = _firstTextFieldController;
    final campo2 = _secondTextFieldController;
    final campo3 = _thirdTextFieldController;
    final campo4 = _fourthTextFieldController;

    if (campo1.text.isEmpty &&
        campo2.text.isEmpty &&
        campo3.text.isEmpty &&
        campo4.text.isEmpty) {
      clearText();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Código de verificação" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _secondTextFieldFocusNode.dispose();
    _thirdTextFieldFocusNode.dispose();
    _fourthTextFieldFocusNode.dispose();
    _firstTextFieldController.dispose();
    _secondTextFieldController.dispose();
    _thirdTextFieldController.dispose();
    _fourthTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/logoPaginaValidarEmail.svg',
                    width: 350,
                    height: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.5),
                    child: Text("Validar o email",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text(
                        "Por favor insere o código de 4 dígitos enviado a $emailName",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstTextFieldController,
                          focusNode: _firstTextFieldFocusNode,
                          decoration: InputDecoration(
                            hintText: '_',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context)
                                  .requestFocus(_secondTextFieldFocusNode);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                          width: 8), // Add some spacing between the sections
                      Expanded(
                        child: TextField(
                          controller: _secondTextFieldController,
                          focusNode: _secondTextFieldFocusNode,
                          decoration: InputDecoration(
                            hintText: '_',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context)
                                  .requestFocus(_thirdTextFieldFocusNode);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _thirdTextFieldController,
                          focusNode: _thirdTextFieldFocusNode,
                          decoration: InputDecoration(
                            hintText: '_',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context)
                                  .requestFocus(_fourthTextFieldFocusNode);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _fourthTextFieldController,
                          focusNode: _fourthTextFieldFocusNode,
                          decoration: InputDecoration(
                            hintText: '_',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      //Implementar backend de reenviar codigo
                    },
                    child: Text(
                      'Reenviar código',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // go back
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                          ),
                          child: const Text('Voltar'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_validateEmailForm()) {
                              setState(() {
                                _isLoading = true;
                              });

                              // implement login function here
                              await Future.delayed(const Duration(
                                  seconds: 2)); // simulating login delay

                              // Navigate to the new route after the loading spinner is done
                              Navigator.of(context)
                                  .pushReplacementNamed('/recover-account-3');

                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                )
                              : const Text('Validar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
