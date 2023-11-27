import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/onboarding_screen/widgets/build_pages.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pagecontroller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 520.h,
              child: PageView(
                controller: pagecontroller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 2;
                  });
                },
                children: const [
                  BuildPages(
                      imageUrl: 'assets/onboarding_img1.png',
                      iconImage: 'assets/search.png',
                      smallText: 'Geolocation',
                      bigText: 'Tracking',
                      descriptionText:
                          'Find trusted security guard in your\n own neighborhood to protect\n whatever you want'),
                  BuildPages(
                      imageUrl: 'assets/onboarding_img2.png',
                      iconImage: 'assets/calendar.png',
                      smallText: 'Availability',
                      bigText: 'Reliable',
                      descriptionText:
                          'Determine the right time between\n you and the security guard with\n choices you cannot imagine before'),
                  BuildPages(
                      imageUrl: 'assets/onboarding_img3.png',
                      iconImage: 'assets/shield.png',
                      smallText: 'Security',
                      bigText: 'Guarding ',
                      descriptionText:
                          'Enjoy the right security and trust\n to protect your family, business\n and valuable assets'),
                ],
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pagecontroller,
                count: 3,
                onDotClicked: (index) => pagecontroller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                effect: WormEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  spacing: 16,
                  dotColor: Colors.grey,
                  activeDotColor: primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 88.h,
            ),
            isLastPage
                ? CustomButtonWidget(
                    buttonTitle: 'Get Started',
                    onBtnPress: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('welcome','1');
                      screenReplaceNavigator(context, SignInScreen());
                    })
                : InkWell(
                    onTap: () {
                      pagecontroller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
