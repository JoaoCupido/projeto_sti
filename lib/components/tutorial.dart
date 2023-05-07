import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final List<Widget> tutorialPages = [
  const TutorialPage(
    title: 'Explorar',
    description: 'Quer esteja à procura de um novo brinquedo para o seu cão ou de uma cama confortável para o seu gato, a nossa loja de artigos para animais de estimação tem tudo o que precisa',
    imagePath: 'assets/images/onboarding/explorar.svg',
  ),
  const TutorialPage(
    title: 'Encomendar',
    description: 'Todos os animais de companhia merecem o melhor. Por isso, comprometemos em tornar o processo de compra muito mais fácil e entregar os itens pretendidos diretamente à sua porta',
    imagePath: 'assets/images/onboarding/encomendar.svg',
  ),
  const TutorialPage(
    title: 'Partilhar',
    description: 'Salva os teus itens favoritos e partilha a tua lista de desejos para a comunidade. Além disso, os teus amigos podem comprar e encomendar os teus itens favoritos que partilhaste para ti',
    imagePath: 'assets/images/onboarding/partilhar.svg',
  ),
];

class TutorialPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const TutorialPage({super.key, required this.title, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 400,
            height: 400,
          ),
          Text(title, style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Text(description, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}