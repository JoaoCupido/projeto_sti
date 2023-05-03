import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecuperarAccount extends StatefulWidget {
  const RecuperarAccount({super.key});

  @override
  State<RecuperarAccount> createState() => _RecuperarAccountState();
}

class _RecuperarAccountState extends State<RecuperarAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SvgPicture.asset(
          'assets/images/292-cadeado.svg',
          width: 200,
          height: 200,
        ),
      ]),
    );
  }
}
