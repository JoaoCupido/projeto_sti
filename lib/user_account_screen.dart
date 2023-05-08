import 'package:flutter/material.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  bool _isLoggingOut = false;

  void _handleLogout() async {
    setState(() {
      _isLoggingOut = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    // aqui colocamos a lógica para realizar o logout - backend
    Navigator.of(context).pushReplacementNamed('/login');

    setState(() {
      _isLoggingOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('A minha conta', textAlign: TextAlign.center),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Implementar a funcionalidade do ícone de configurações aqui
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 125,
                color: Theme.of(context).colorScheme.surface,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/patternLogo.png',
                        width: 400,
                        height: 300,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Olá, Fulano de Tal!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.person),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Perfil'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Perfil aqui
                        Navigator.of(context).pushNamed('/user-profile');
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.receipt),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Dados de faturação'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Dados de faturação aqui
                        Navigator.of(context).pushNamed('/dados_faturação');
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.payment),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Métodos de pagamento'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Métodos de pagamento aqui
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.notifications),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Notificações'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Notificações aqui
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.contacts),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Preferências de contacto'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Preferências de contacto aqui
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.people),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Contas associadas'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Contas associadas aqui
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.help),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Ajuda'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Ajuda aqui
                        Navigator.of(context).pushNamed('/help');
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.info),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Sobre nós'),
                      onTap: () {
                        // Implementar a funcionalidade da tab Sobre nós aqui
                      },
                    ),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onError,
                      textColor: Theme.of(context).colorScheme.onError,
                      leading: const Icon(Icons.exit_to_app),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Terminar sessão'),
                      onTap: _handleLogout,
                      tileColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_isLoggingOut)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
