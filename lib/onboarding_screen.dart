import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    OnboardingPage(
      title: 'Welcome to My App',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imagePath: 'assets/images/placeholder.jpg',
    ),
    OnboardingPage(
      title: 'Discover New Features',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imagePath: 'assets/images/placeholder.jpg',
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imagePath: 'assets/images/placeholder.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text('SKIP'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
              DotsIndicator(
                controller: _pageController,
                itemCount: _pages.length,
              ),
              TextButton(
                child: Text('NEXT'),
                onPressed: () {
                  if (_pageController.page == _pages.length - 1) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                  }
                },
              ),
            ],
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

  OnboardingPage({required this.title, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200.0),
          SizedBox(height: 32.0),
          Text(title, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.0),
          Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;

  DotsIndicator({required this.controller, required this.itemCount}) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.page == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}
