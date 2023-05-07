import 'package:flutter/material.dart';

final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
);
final RegExp usernameRegex = RegExp(r'^[\w\s]+$');
final RegExp passwordRegex = RegExp(r'^\S+$');
final RegExp genderRegex = RegExp(r'^[\w\s]+$');

bool validateEmailInput(BuildContext context, TextEditingController emailController)
{
  final email = emailController.text.trim();

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

bool validateUsernameInput(BuildContext context, TextEditingController usernameController)
{
  final username = usernameController.text.trim();

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

  return true;
}

bool validatePasswordInput(BuildContext context, TextEditingController passwordController)
{
  final password = passwordController.text.trim();

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

bool validateConfirmPasswordInput(BuildContext context,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController)
{
  final password = passwordController.text.trim();
  final confirmPassword = confirmPasswordController.text.trim();

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

bool validateBirthDateInput(BuildContext context, DateTime selectedDate)
{
  if (selectedDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
      const Text('Por favor, selecione uma data de nascimento válida!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  } else if (selectedDate.isAfter(DateTime.now())) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
          'A data de nascimento não pode ser posterior à data atual!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  } else if (selectedDate
      .isAfter((DateTime.now()).subtract(const Duration(days: 365 * 18)))) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
          'Por motivos legais, você precisa de ter pelo menos 18 anos para realizar esta ação!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  }

  return true;
}

bool validateGenderInput(BuildContext context, TextEditingController genderController)
{
  final gender = genderController.text.trim();

  if (gender.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('O campo "Género" é obrigatório!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  } else if (!usernameRegex.hasMatch(gender)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
          'Por favor, digite um valor válido (apenas letras e números)!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  }

  return true;
}

bool validateNewWishlistName(BuildContext context, TextEditingController newWishlistNameController) {
  final wishlistName = newWishlistNameController.text.trim();

  if (wishlistName.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('O campo "Nome da lista" é obrigatório!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  }

  return true;
}

bool validateLoginForm(BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return validateEmailInput(context, emailController) &&
      validatePasswordInput(context, passwordController);
}

bool validateCreateAccountForm(BuildContext context,
    TextEditingController emailController,
    TextEditingController usernameController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    DateTime selectedDate, bool agreeToTerms) {
  if (!agreeToTerms) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
      const Text('Você precisa concordar com os Termos & Condições!'),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
    return false;
  }

  return validateEmailInput(context, emailController) &&
      validateUsernameInput(context, usernameController) &&
      validatePasswordInput(context, passwordController) &&
      validateConfirmPasswordInput(context, passwordController, confirmPasswordController) &&
      validateBirthDateInput(context, selectedDate);
}