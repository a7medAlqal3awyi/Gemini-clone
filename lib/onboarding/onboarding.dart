import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini/core/extention/spacing.dart';
import 'package:gemini/home/screen/home.dart';
import 'package:gemini/onboarding/widgets/gradient_text.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    const titles = [
      "Welcome to Gemini",
      "Powered by Google",
      "Revolutionizing Customer Experience",
    ];
    const imgs = [
      "assets/onboarding/intro1.jpeg",
      "assets/onboarding/intro2.jpeg",
      "assets/onboarding/intro3.jpeg",
    ];
    const desc = [
      "Experience seamless communication with our cutting-edge chatbot, powered by Google's Gemini LLM. Engage in natural conversations and get instant, personalized responses.",
      "Our chatbot harnesses the power of Google's Gemini LLM, a state-of-the-art language model, to understand and respond to your queries with remarkable accuracy.",
      "Say goodbye to long wait times and impersonal responses. Our chatbot provides a delightful, efficient, and tailored experience for all your needs."
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (_) {
              setState(() => index = _);
            },
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return intro(titles, index, desc, imgs);
            },
          ),
          index == 2
              ? Positioned(
                  bottom: 30,
                  right: MediaQuery.of(context).size.width / 5,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: Container(
                      width: 200.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Center(
                        child: Text(
                          "Start",
                          style:
                              TextStyle(color: Colors.white, fontSize: 27.sp),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: 90,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                          child: Container(
                            width: 100.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(120),
                        GestureDetector(
                          onTap: () {
                            if (index < 2) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            }
                          },
                          child: Container(
                            width: 100.w,
                            height: 40.h,
                            // clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.deepPurpleAccent.shade200,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget intro(titles, index, desc, imgs) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 270.w,
            height: 250.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imgs[index]))),
          ),
          verticalSpace(40),
          GradientText(
            titles[index],
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          verticalSpace(20),
          Text(
            desc[index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, height: 1.8),
          ),
        ],
      ),
    );
  }
}
