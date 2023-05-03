import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecuperarAccount extends StatefulWidget {
  const RecuperarAccount({super.key});

  @override
  State<RecuperarAccount> createState() => _RecuperarAccountState();
}

class _RecuperarAccountState extends State<RecuperarAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        const SizedBox(height: 60),
        SvgPicture.asset(
          'assets/images/292-cadeado.svg',
          width: 300,
          height: 300,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Recuperação de Senha\n',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Insere o seu email associado à sua conta.\n\n'
                  'Nós vamos enviar para si um código de ativação para poder alterar a sua senha.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 60),
                TextField(
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
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        // implement function
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                      ),
                      child: const Text('Entrar sem sessão'),
                    ),
                    const SizedBox(width: 65),
                    ElevatedButton(
                      onPressed: () {
                        // implement function
                      },
                      child: const Text('Entrar sem sessão2'),
                    ),
                  ],
                )
              ],
            ))
      ]),
    );
  }
}
