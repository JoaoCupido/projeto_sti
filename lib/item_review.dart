import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemReviewScreen extends StatefulWidget {
  const ItemReviewScreen({Key? key}) : super(key: key);

  @override
  _ItemReviewScreenState createState() => _ItemReviewScreenState();
}

class _ItemReviewScreenState extends State<ItemReviewScreen>
    with SingleTickerProviderStateMixin {
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
      body: Column(),
    );
  }
}
