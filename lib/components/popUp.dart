import 'package:flutter/material.dart';

class PopupMessage {
  final String title;
  final int durationSeconds;
  IconData? icon;

  PopupMessage({required this.title, required this.durationSeconds, this.icon});

  void build(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Icon(
            icon,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
