import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompareItemScreen extends StatefulWidget {
  const CompareItemScreen({Key? key}) : super(key: key);

  @override
  _CompareItemScreenState createState() => _CompareItemScreenState();
}

class _CompareItemScreenState extends State<CompareItemScreen>
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
