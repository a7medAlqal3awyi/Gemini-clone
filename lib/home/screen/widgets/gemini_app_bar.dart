import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../onboarding/widgets/gradient_text.dart';

class GeminiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeminiAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return _appBar;
  }
}

AppBar _appBar = AppBar(
  backgroundColor: Colors.white,
  leading: const Padding(
    padding: EdgeInsets.all(8.0),
    child: Icon(Icons.menu, size: 25),
  ),
  title: GradientText(
    "Gemini",
    style: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true,
  actions: const [
    Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(
          "https://lh3.googleusercontent.com/a/ACg8ocJ1PlzCTxA_rxHKJCoRKGBuF5KndmJJLxK37VuvPVAKQjYzNpF7=s317-c-no",
        ),
      ),
    ),
  ],
);
