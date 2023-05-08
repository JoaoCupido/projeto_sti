import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imagesList = [
    'assets/images/carousel-item/biscoito.svg',
    'assets/images/carousel-item/biscoito-1.svg'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: <Widget>[
        SizedBox(
            width: 350,
            height: 180,
            child: Stack(children: [
              Align(
                  alignment: Alignment.center,
                  child: CarouselSlider(
                    items: imagesList
                        .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SvgPicture.asset(
                              item,
                              width: 120,
                              height: 120,
                            )))
                        .toList(),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(
                          () {
                            _currentIndex = index;
                          },
                        );
                      },
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 16 / 9,
                    ),
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    buttonCarouselController.previousPage();
                  },
                  icon: const Icon(Icons.arrow_circle_left_outlined),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    buttonCarouselController.nextPage();
                  },
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ])),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagesList.map((urlOfItem) {
            int index = imagesList.indexOf(urlOfItem);
            return Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? const Color(0xFFF28A0C)
                    : const Color(0xFFF2E0CB),
              ),
            );
          }).toList(),
        )
      ]),
    );
  }
}
