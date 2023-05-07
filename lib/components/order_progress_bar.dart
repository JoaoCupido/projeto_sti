import 'package:flutter/material.dart';

class OrderProgress extends StatefulWidget {
  final int currentStep;
  final List<String> textSteps;

  const OrderProgress({Key? key, required this.currentStep, required this.textSteps})
      : super(key: key);

  @override
  _OrderProgressState createState() => _OrderProgressState(currentStep, textSteps);
}

class _OrderProgressState extends State<OrderProgress> {
  int currentStep;
  List<String> textSteps;

  _OrderProgressState(this.currentStep, this.textSteps);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepCircle(textSteps[0], 1),
            _buildStepCircle(textSteps[1], 2),
            _buildStepCircle(textSteps[2], 3),
            _buildStepCircle(textSteps[3], 4),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle(String title, int stepNumber) {
    final isCurrent = stepNumber == currentStep;
    final circleColor = isCurrent
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    final titleColor = isCurrent
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.outlineVariant;

    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
          ),
          child: Center(
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
