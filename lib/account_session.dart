import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_screen.dart';

class AccountSessionScreen extends StatefulWidget {
  const AccountSessionScreen({Key? key}) : super(key: key);

  @override
  _AccountSessionScreenState createState() => _AccountSessionScreenState();
}

class _AccountSessionScreenState extends State<AccountSessionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _obscureText = true;
  bool _rememberMe = false;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  bool _validateLoginForm() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    final RegExp passwordRegex = RegExp(r'^\S+$');

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

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Senha" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('A senha não pode conter espaços em branco!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    return true;
  }

  bool _validateCreateAccountForm() {
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    final RegExp usernameRegex = RegExp(r'^[\w\s]+$');
    final RegExp passwordRegex = RegExp(r'^\S+$');

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

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Nome do utilizador" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (!usernameRegex.hasMatch(username)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            'Por favor, digite um nome de usuário válido (apenas letras e números)!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('O campo "Senha" é obrigatório!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('A senha não pode conter espaços em branco!'),
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

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            const Text('Você precisa concordar com os Termos & Condições!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            const Text('Por favor, selecione uma data de nascimento válida!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (_selectedDate.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            'A data de nascimento não pode ser posterior à data atual!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    } else if (_selectedDate
        .isAfter((DateTime.now()).subtract(const Duration(days: 365 * 18)))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            'Por motivos legais, você precisa de ter pelo menos 18 anos para realizar esta ação!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return false;
    }

    // The validation was successful
    return true;
  }

  List<int> _daysInMonth(int year, int month) {
    var days = 31;
    if ([4, 6, 9, 11].contains(month)) {
      days = 30;
    } else if (month == 2) {
      if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
        days = 29;
      } else {
        days = 28;
      }
    }
    return List.generate(days, (index) => index + 1);
  }

  List<int> _years() {
    var currentYear = DateTime.now().year;
    return List.generate(120, (index) => currentYear - index);
  }

  List<int> _months() {
    return List.generate(12, (index) => index + 1);
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

  Widget _buildDateInput(BuildContext context) {
    return Row(
      children: [
        _buildDropdownButton(
          'Dia',
          _daysInMonth(_selectedDate.year, _selectedDate.month),
          _selectedDate.day,
          (value) {
            setState(() {
              _selectedDate =
                  DateTime(_selectedDate.year, _selectedDate.month, value);
            });
          },
        ),
        const SizedBox(width: 10),
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/images/logo.svg',
          width: 20,
          height: 20,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          tabs: const [
            Tab(text: 'Login'),
            Tab(text: 'Criar conta'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset('assets/images/login.svg',
                    width: 300, height: 300),
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
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
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
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              Text('Lembrar-me',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/recover-account');
                            },
                            child: Text(
                              'Esqueceu da senha?',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                // implement function
                                Navigator.of(context).pushReplacementNamed('/home');
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                              ),
                              child: const Text('Entrar sem sessão'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_validateLoginForm()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  // implement login function here
                                  await Future.delayed(const Duration(
                                      seconds: 2)); // simulating login delay

                                  // Navigate to the new route after the loading spinner is done
                                  Navigator.of(context).pushReplacementNamed('/home', arguments: _emailController.text);

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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      ),
                                    )
                                  : const Text('Login'),
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
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Nome do utilizador',
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
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
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
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirmar senha',
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
                        obscureText: _obscureText,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Data de nascimento',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      _buildDateInput(context),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value!;
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Concordo com os ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: 'Termos & Condições',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary, // Altera a cor do texto
                                    decoration: TextDecoration
                                        .underline, // Insere sublinhado
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                // implement function
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                              ),
                              child: const Text('Entrar sem sessão'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_validateCreateAccountForm()) {
                                  // implementar função de criar conta - backend
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Center(
                                      child: AlertDialog(
                                        title: const Text('Sucesso!'),
                                        content: const Text(
                                            'A sua conta foi criada com sucesso.'),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _tabController.animateTo(0);
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
                              child: const Text('Criar conta'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // implementar tela de criar conta
        ],
      ),
    );
  }
}
