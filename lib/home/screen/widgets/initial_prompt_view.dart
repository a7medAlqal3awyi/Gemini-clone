import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../onboarding/widgets/gradient_text.dart';

class InitialPromptView extends StatefulWidget {
  const InitialPromptView({super.key});

  @override
  _InitialPromptViewState createState() => _InitialPromptViewState();
}

class _InitialPromptViewState extends State<InitialPromptView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();

    _fadeAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientText(
          "Hello, Ahmed",
          style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        SlideTransition(
          position: _fadeAnimation,
          child: Text(
            'What can I help with?',
            style: TextStyle(height: 1.7, color: Colors.black, fontSize: 30.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
