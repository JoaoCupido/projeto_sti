import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemDescriptionScreen extends StatefulWidget {
  const ItemDescriptionScreen({Key? key}) : super(key: key);

  @override
  _ItemDescriptionScreenState createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen>
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
