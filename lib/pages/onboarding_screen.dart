import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const OnboardingScreen({super.key, required this.prefs});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height - 40,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/logo.png"),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MouseDraggableScrollBehavior(),
                    child: PageView.builder(
                        onPageChanged: (value) => setState(() {
                              currentPage = value;
                            }),
                        controller: _pageController,
                        itemCount: onboardData.length,
                        itemBuilder: (context, index) {
                          return OnboardContent(
                              image: onboardData[index].image,
                              title: onboardData[index].title,
                              boldDescription:
                                  onboardData[index].boldDescription,
                              description: onboardData[index].description);
                        }),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: ClickWidget(
                            onTap: () async {
                              _pageController.nextPage(
                                  duration: .3.seconds, curve: Curves.ease);
                              print(currentPage);
                              if (currentPage == 3) {
                                await widget.prefs.setBool("initScreen", true);
                                // print(widget.prefs.getBool("initScreen"));

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "/home", (Route<dynamic> route) => false);
                              }
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(999)),
                              child: Container(
                                color: PSU_BLUE,
                                child: const Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingleOnboard {
  final String image, title, boldDescription, description;

  SingleOnboard(
      {required this.image,
      required this.title,
      required this.boldDescription,
      required this.description});
}

final List<OnboardContent> onboardData = [
  const OnboardContent(
      image: "assets/waving-hand.png",
      title: "Welcome!",
      boldDescription: "Course Compass",
      description:
          " is your personalized academic guide at Pangasinan State University."),
  const OnboardContent(
      image: "assets/behaviour.png",
      title: "Discover Yourself!",
      boldDescription: "",
      description: "Take the MBTI assessment."),
  const OnboardContent(
      image: "assets/search-engine.png",
      title: "Explore Courses!",
      boldDescription: "",
      description: "Browse a wide range of programs."),
  const OnboardContent(
      image: "assets/notice.png",
      title: "Stay Updated!",
      boldDescription: "",
      description:
          "Get the latest news and announcements about admission or enrollment."),
  const OnboardContent(
      image: "assets/search-engine.png",
      title: "Personalized Recommendations!",
      boldDescription: "",
      description:
          "Receive tailored course suggestions. Start your academic journey today!")
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.boldDescription,
    required this.description,
  });

  final String image, title, boldDescription, description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(
          flex: 2,
        ),
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset(
              width: 300,
              height: 300,
              image,
            ),
          ),
        ),
        // temporary image below
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 40.0),
        //   child: SizedBox(
        //       width: 200,
        //       child: RotatedBox(
        //         quarterTurns: 1,
        //         child: Icon(
        //           size: 400,
        //           Icons.rectangle_rounded,
        //         ),
        //       )),
        // ),
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.inter(
                  fontSize: 30, fontWeight: FontWeight.w800, color: PSU_BLUE)),
        ),
        const Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: boldDescription,
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w800),
                ),
                TextSpan(
                    text: description,
                    style: Theme.of(context).textTheme.bodyMedium)
              ])),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

class MouseDraggableScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
