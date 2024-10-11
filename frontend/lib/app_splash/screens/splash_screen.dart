import 'package:flutter/material.dart';
import 'package:fur_get_me_not/config/const.dart';
import 'package:fur_get_me_not/app_splash/models/onboarding_model.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PetsOnBoardingScreen extends StatefulWidget {
  const PetsOnBoardingScreen({super.key});

  @override
  State<PetsOnBoardingScreen> createState() => _PetsOnBoardingScreenState();
}

class _PetsOnBoardingScreenState extends State<PetsOnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.7,
            child: PageView.builder(
              itemCount: onBoardData.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return onBoardingItems(size, index);
              },
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (currentPage == onBoardData.length - 1) {
                final storage = FlutterSecureStorage();
                await storage.write(key: 'onboarding_completed', value: 'true'); // Add await
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                      (route) => false,
                );
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            child: Container(
              height: 70,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  currentPage == onBoardData.length - 1
                      ? "Get Started!"
                      : "Continue",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                onBoardData.length,
                    (index) => indicatorForSlider(index: index),
              )
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer indicatorForSlider({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: currentPage == index ? 20 : 10,
      height: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentPage == index ? Colors.orange : black.withOpacity(0.2),
      ),
    );
  }

  Column onBoardingItems(Size size, int index) {
    return Column(
      children: [
        Container(
          height: size.height * 0.4,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 240,
                    width: size.width * 0.9,
                    color: orangeContainer,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: -40,
                          height: 130,
                          width: 130,
                          child: Transform.rotate(
                            angle: -11,
                            child: Image.asset(
                              "images/pet-cat2.png",
                              color: pawColor1,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          right: -20,
                          height: 130,
                          width: 130,
                          child: Transform.rotate(
                            angle: -12,
                            child: Image.asset(
                              "images/pet-cat2.png",
                              color: pawColor1,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Centered main image
              Positioned(
                bottom: 0,
                right: 120,
                child: SizedBox(
                  height: size.height * 0.3,
                  width: size.width * 0.5,
                  child: Image.asset(
                    onBoardData[index].image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 35,
              color: black,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
            children: [
              TextSpan(text: "Pet Adoption/"),
              TextSpan(
                text: "",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(text: "App!"),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          onBoardData[index].text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15.5,
            color: Colors.black,
          ),
        )
      ],
    );
  }

}