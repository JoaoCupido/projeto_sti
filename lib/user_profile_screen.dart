import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'classes/input_validation.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isNameEditable = false;
  TextEditingController _nameController = TextEditingController(text: 'Fulano de Tal');
  final FocusNode _nameFocusNode = FocusNode();

  bool _isEmailEditable = false;
  TextEditingController _emailController = TextEditingController(text: 'a@g.c');
  final FocusNode _emailFocusNode = FocusNode();

  TextEditingController _birthDateController = TextEditingController(text: '01/01/2000');
  final FocusNode _birthDateFocusNode = FocusNode();
  bool _isBirthDateEditable = false;

  TextEditingController _genderController = TextEditingController(text: 'Masculino');
  final FocusNode _genderFocusNode = FocusNode();
  bool _isGenderEditable = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Perfil', textAlign: TextAlign.center),
          ),
          body: Column(
            children: [
              Container(
                height: 125,
                color: Theme.of(context).colorScheme.surface,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      focusNode: _nameFocusNode,
                      controller: _nameController,
                      readOnly: !_isNameEditable,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: const Icon(Icons.person),
                        suffixIcon: _isNameEditable ? IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            if(validateUsernameInput(context, _nameController)) {
                              setState(() {
                                _isNameEditable = false;
                              });
                            }
                          },
                        ) : IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isNameEditable = true;
                              _nameFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      onEditingComplete: () {
                        if(validateUsernameInput(context, _nameController)) {
                          setState(() {
                            _isNameEditable = false;
                          });
                        }
                      },
                    ),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      readOnly: !_isEmailEditable,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        suffixIcon: _isEmailEditable ? IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            if(validateEmailInput(context, _emailController)) {
                              setState(() {
                                _isEmailEditable = false;
                              });
                            }
                          },
                        ) : IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isEmailEditable = true;
                              _emailFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      onEditingComplete: () {
                        if(validateEmailInput(context, _emailController)) {
                          setState(() {
                            _isEmailEditable = false;
                          });
                        }
                      },
                    ),
                    TextFormField(
                      focusNode: _birthDateFocusNode,
                      controller: _birthDateController,
                      readOnly: !_isBirthDateEditable,
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: _isBirthDateEditable ? IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            if(validateBirthDateInput(context, (DateFormat('dd/MM/yyyy')).parse(_birthDateController.text))) {
                              setState(() {
                                _isBirthDateEditable = false;
                              });
                            }
                          },
                        ) : IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isBirthDateEditable = true;
                              _birthDateFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      onEditingComplete: () {
                        if(validateBirthDateInput(context, (DateFormat('dd/MM/yyyy')).parse(_birthDateController.text))) {
                          setState(() {
                            _isBirthDateEditable = false;
                          });
                        }
                      },
                    ),
                    TextFormField(
                      focusNode: _genderFocusNode,
                      controller: _genderController,
                      readOnly: !_isGenderEditable,
                      decoration: InputDecoration(
                        labelText: 'Género',
                        prefixIcon: const Icon(Icons.people),
                        suffixIcon: _isGenderEditable ? IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            if(validateGenderInput(context, _genderController)) {
                              setState(() {
                                _isGenderEditable = false;
                              });
                            }
                          },
                        ) : IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isGenderEditable = true;
                              _genderFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      onEditingComplete: () {
                        if(validateGenderInput(context, _genderController)) {
                          setState(() {
                            _isGenderEditable = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                      leading: const Icon(Icons.lock_outline),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: const Text('Mudar senha'),
                      onTap: () {
                        Navigator.of(context).pushNamed('/recover-account');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
