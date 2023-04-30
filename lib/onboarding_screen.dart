import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const OnboardingPage(
      title: 'Explorar',
      description: 'Quer esteja à procura de um novo brinquedo para o seu cão ou de uma cama confortável para o seu gato, a nossa loja de artigos para animais de estimação tem tudo o que precisa',
      imagePath: 'assets/images/onboarding/explorar.svg',
    ),
    const OnboardingPage(
      title: 'Encomendar',
      description: 'Todos os animais de companhia merecem o melhor. Por isso, comprometemos em tornar o processo de compra muito mais fácil e entregar os itens pretendidos diretamente à sua porta',
      imagePath: 'assets/images/onboarding/encomendar.svg',
    ),
    const OnboardingPage(
      title: 'Partilhar',
      description: 'Salva os teus itens favoritos e partilha a tua lista de desejos para a comunidade. Além disso, os teus amigos podem comprar e encomendar os teus itens favoritos que partilhaste para ti',
      imagePath: 'assets/images/onboarding/partilhar.svg',
    ),
  ];

  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.page == _pages.length - 1) {
        setState(() {
          _isLastPage = true;
        });
      } else {
        setState(() {
          _isLastPage = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: DotsIndicator(
              controller: _pageController,
              itemCount: _pages.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    'Saltar',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_isLastPage ? 'Concluir' : 'Seguinte'),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onPressed: () {
                    if (_isLastPage) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    } else {
                      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({super.key, required this.title, required this.description, required this.imagePath});

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
          Text(title, style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16.0),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;

  const DotsIndicator({super.key, required this.controller, required this.itemCount}) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 20.0,
          height: 20.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (controller.page?.round() ?? 0) == index ? colorScheme.primary : colorScheme.secondary,
          ),
        );
      }),
    );
  }
}
