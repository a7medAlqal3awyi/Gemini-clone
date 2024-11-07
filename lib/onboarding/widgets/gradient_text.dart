import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const GradientText(this.text, {required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color.fromRGBO(112, 129, 230, 1),
          Color.fromRGBO(157, 117, 169, 1),
          Color.fromRGBO(185, 115, 114, 1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        textAlign: TextAlign.center,

        text,
        style: style.copyWith(
            color: Colors
                .white), // Set the text color to white so the gradient can be visible
      ),
    );
  }
}
