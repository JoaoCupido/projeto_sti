import 'package:flutter/material.dart';
import 'components/tutorial.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final PageController _pageController = PageController();

  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.page == tutorialPages.length - 1) {
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
              children: tutorialPages,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: DotsIndicator(
              controller: _pageController,
              itemCount: tutorialPages.length,
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
                    Navigator.of(context).pop();
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
                      Navigator.of(context).pop();
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
