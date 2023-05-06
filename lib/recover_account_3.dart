import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecoverAccount3 extends StatefulWidget {
  const RecoverAccount3({super.key});

  @override
  State<RecoverAccount3> createState() => _RecoverAccount3State();
}

class _RecoverAccount3State extends State<RecoverAccount3>
    with SingleTickerProviderStateMixin {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _validateChangePasswordForm() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final RegExp passwordRegex = RegExp(r'^\S+$');

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Nova senha" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('A nova senha não pode conter espaços em branco!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Confirmar senha" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('As senhas não coincidem!'),
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
                    'assets/images/225-2-NovaSenha.svg',
                    width: 350,
                    height: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.5),
                    child: Text("Alterar senha",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text(
                        "Por favor insere uma nova senha forte que não seja igual à antiga senha usada anteriormente na sua conta.",
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Nova senha',
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
                  const SizedBox(height: 40),
                  TextField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
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
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_validateChangePasswordForm()) {
                            // implementar função de alterar senha - backend
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => Center(
                                child: AlertDialog(
                                  title: const Text('Sucesso!'),
                                  content: const Text(
                                      'A senha foi alterada com sucesso.'),
                                  actions: [
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed('/login');
                                        },
                                        child: const Text('Continuar'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Salvar'),
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
