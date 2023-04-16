import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sport_app_with_api/view/screens/introduction_data.dart';
import 'package:sport_app_with_api/view/auth/sing_in_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 60, 80, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          const Center(
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: contents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Image.asset(contents[index].image),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.935,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.2),
                            borderRadius: BorderRadius.circular(64),
                            color: const Color.fromRGBO(255, 255, 255, 0.17)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              contents[index].title,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              contents[index].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contents.length,
                                  (index) => buildDots(index),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (currentIndex == contents.length - 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                           const SingInPage(),
                                      ));
                                }
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.bounceIn,
                                );
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 80.5, vertical: 37),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(123, 97, 255, 1),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentIndex == contents.length - 1
                                          ? "Continue"
                                          : "Next >",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingInPage(),
                      ));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Color.fromRGBO(123, 97, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildDots(int index) {
    return Container(
      height: 7,
      width: currentIndex == index ? 20 : 7,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 73, 133, 1),
        border: Border.all(color: Colors.grey, width: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
