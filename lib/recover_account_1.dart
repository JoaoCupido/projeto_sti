import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'recover_account_2.dart';

class RecoverAccount1 extends StatefulWidget {
  const RecoverAccount1({super.key});

  @override
  State<RecoverAccount1> createState() => _RecoverAccount1State();
}

class _RecoverAccount1State extends State<RecoverAccount1>
    with SingleTickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();
  String emailName = 'johndoe@gmail.com';

  bool _validateEmailForm() {
    final email = _emailController.text.trim();

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Email" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Por favor, digite um email válido!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    return true;
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
                    'assets/images/292-cadeado.svg',
                    width: 350,
                    height: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.5),
                    child: Text("Recuperação de Senha",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text(
                        "Insere o seu email associado à sua conta.\n"
                        "Nós vamos enviar para si um código de ativação para poder alterar a sua senha.",
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
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                    onChanged: (text) {
                      emailName = text;
                    },
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
                          onPressed: () {
                            if (_validateEmailForm()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RecoverAccount2(emailName: emailName)));
                            }
                          },
                          child: const Text('Enviar'),
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
