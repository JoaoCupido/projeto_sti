import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final IconData? icon;
  final Widget textLeft;
  final String textRight;
  Function onPress;
  int movement;
  Buttons(
      {Key? key,
      this.icon,
      required this.textLeft,
      required this.textRight,
      required this.onPress,
      this.movement = 0})
      : super(key: key);

  void runFunction() {
    onPress();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 15,
        left: MediaQuery.of(context).size.width / 2 - 150 + movement,
        child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 38,
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  child: textLeft,
                ),
                ElevatedButton(
                    onPressed: (() => runFunction()),
                    child: Row(children: [
                      if (icon != null)
                        Icon(
                          icon,
                          color: Theme.of(context).colorScheme.surface,
                        ), // El icono del botón
                      const SizedBox(
                          width:
                              5), // Un pequeño espacio entre el icono y el texto
                      Text(
                        textRight,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ), // El
                    ]))
              ],
            )));
  }
}
