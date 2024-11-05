import 'package:course_compass/blue_menu.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/course_recommender/course_recommendation_screen_json_code.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

import 'package:percent_indicator/linear_percent_indicator.dart';

final List<Shadow> shadows = [
  Shadow(color: Colors.black.withOpacity(.4), blurRadius: 3)
];

List<String> mbtiPersonalities = [
  "ISTJ",
  "ISTP",
  "ISFJ",
  "ISFP",
  "INTJ",
  "INTP",
  "INFJ",
  "INFP",
  "ESTJ",
  "ESTP",
  "ESFJ",
  "ESFP",
  "ENTJ",
  "ENTP",
  "ENFJ",
  "ENFP"
];

List<String> academicTracks = [
  'Academic Track - ABM (Accountancy, Business and Management)',
  'Academic Track - STEM (Science, Technology, Engineering, and Mathematics)',
  'Academic Track - HUMSS (Humanities and Social Science)',
  'Academic Track - GAS (General Academic Strand)',
  'Arts and Design track',
  'Sports Track',
  'TVL Track - AFA (Agricultural-Fishery Arts)',
  'TVL Track - HE (Home Economics)',
  'TVL Track - IA (Industrial arts)',
  'TVL Track - ICT (Information and Communications Technology)',
];

class CourseRecommenderStepsScreen extends StatefulWidget {
  const CourseRecommenderStepsScreen({super.key});

  @override
  State<CourseRecommenderStepsScreen> createState() =>
      _CourseRecommenderStepsScreenState();
}

class _CourseRecommenderStepsScreenState
    extends State<CourseRecommenderStepsScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _interests = TextEditingController();
  late bool validatorMBTI;
  late String currentPersonality;
  int currentPage = 0;
  // ignore: prefer_typing_uninitialized_variables
  var selectedTrack;

  @override
  void initState() {
    super.initState();
    currentPersonality = "";
    validatorMBTI = false;
  }

  @override
  Widget build(BuildContext context) {
    // AppBar appBarResponsive = AppBar(
    //   surfaceTintColor: Colors.transparent,
    //   toolbarHeight: 120,
    //   centerTitle: true,
    //   backgroundColor: LIGHT_GRAY,
    //   title: Column(
    //     children: [
    //       SizedBox(
    //           height: 50,
    //           child: Image.asset(fit: BoxFit.contain, "assets/logo.png")),
    //       ElevatedButton(
    //         onPressed: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) =>
    //                     Material(child: ResponsiveMenu("course-recommender")),
    //               ));
    //         },
    //         style: const ButtonStyle(
    //             padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
    //             elevation: WidgetStatePropertyAll(0),
    //             backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
    //         child: Icon(Icons.menu_rounded, color: PSU_BLUE),
    //       )
    //     ],
    //   ),
    // );

    return BaseWidget(widget: [
      Container(
        color: LIGHT_GRAY,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              MediaQuery.of(context).size.width < 1050
                  ? Container()
                  : Expanded(child: Container()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40),
                  child: Text(
                    "Fill out a short form so we can determine your most suitable courses!",
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.inter(fontSize: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          MediaQuery.of(context).size.width < 1050
              ? Container()
              : Expanded(child: Container()),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(9999),
                      animation: true,
                      animationDuration: 1000,
                      animateFromLastPercent: true,
                      center: currentPage == 0
                          ? Text(
                              "Let's Start!",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  shadows: shadows),
                            )
                          : currentPage == 1
                              ? Text(
                                  "Just a bit more!",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      shadows: shadows),
                                )
                              : Text(
                                  "Almost there!",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      shadows: shadows),
                                ),
                      width: 400.0,
                      lineHeight: 35.0,
                      percent: currentPage == 0
                          ? 0
                          : currentPage == 1
                              ? .33
                              : currentPage == 2
                                  ? .66
                                  : 1.00,
                      backgroundColor: PSU_YELLOW,
                      progressColor: PSU_BLUE,
                    ),
                    // LinearProgressIndicator(
                    //   value: currentPage == 0
                    //       ? 0
                    //       : currentPage == 1
                    //           ? .33
                    //           : currentPage == 2
                    //               ? .66
                    //               : 1.00,
                    // ),
                    currentPage == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Let's get started!",
                                style: GoogleFonts.inter(
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Before we dive into the form, please make sure you've taken the MBTI personality test on 16Personalities.",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "This button will redirect you to the 16Personalities free personality test.",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ClickWidget(
                                  onTap: () {},
                                  child: ElevatedButton(
                                      onPressed: () {
                                        js.context.callMethod('open', [
                                          "https://www.16personalities.com/free-personality-test"
                                        ]);
                                      },
                                      child: Text(
                                        "Click to Take a short assessment",
                                        style: GoogleFonts.inter(
                                            color: PSU_YELLOW,
                                            fontWeight: FontWeight.w700),
                                      ))),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Knowing your MBTI personality type, along with your interests and high school strand helps us recommend courses that match your personality, skills, and aspirations. For example, an INTP interested in technology and with a STEM strand might be suited for Computer Science, while an ENFJ interested in helping people and with a HUMSS strand might prefer Psychology or Education.",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                ),
                              ),
                            ]
                                .animate(interval: 0.1.seconds)
                                .slideX(
                                    duration: .5.seconds,
                                    curve: Curves.easeInOut,
                                    begin: -.05)
                                .fadeIn(
                                    delay: .1.seconds, curve: Curves.easeIn),
                          )
                        : Container(),
                    !(currentPage == 1)
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First, tell us your Myers-Briggs Type Indicator (MBTI) personality.",
                                style: GoogleFonts.inter(
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MBTIRadioGroup(
                                mbtiPersonalities: mbtiPersonalities,
                                selectedPersonality: currentPersonality,
                                onChanged: (value) {
                                  setState(() {
                                    currentPersonality = value;
                                  });
                                },
                              ),
                              Visibility(
                                visible: validatorMBTI,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.red.withAlpha(50),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0, vertical: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.error_rounded,
                                                color:
                                                    Colors.red.withAlpha(200),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Please select your MBTI Personality!",
                                                style: GoogleFonts.inter(
                                                    color: Colors.red
                                                        .withAlpha(200)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 7.0),
                                        child: Text(
                                          "I am an  ",
                                          style:
                                              GoogleFonts.inter(fontSize: 28),
                                        ),
                                      ),
                                      currentPersonality.isEmpty
                                          ? Container()
                                          : Text(currentPersonality,
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w800,
                                                    color: PSU_BLUE,
                                                    fontSize: 34,
                                                  ))
                                              .animate()
                                              // .slideY(
                                              //     duration: .5.seconds,
                                              //     curve: Curves.easeInOut,
                                              //     begin: -.05)
                                              .fadeIn(
                                                  delay: .1.seconds,
                                                  curve: Curves.easeIn),
                                    ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Don't know your MBTI Personality?",
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ClickWidget(
                                  onTap: () {},
                                  child: ElevatedButton(
                                      onPressed: () {
                                        js.context.callMethod('open', [
                                          "https://www.16personalities.com/free-personality-test"
                                        ]);
                                      },
                                      child: Text(
                                        "Click to Take a short assessment",
                                        style: GoogleFonts.inter(
                                            color: PSU_YELLOW,
                                            fontWeight: FontWeight.w700),
                                      ))),
                            ]
                                .animate(interval: 0.1.seconds)
                                .slideX(
                                    duration: .5.seconds,
                                    curve: Curves.easeInOut,
                                    begin: -.05)
                                .fadeIn(
                                    delay: .1.seconds, curve: Curves.easeIn),
                          ),
                    !(currentPage == 2)
                        ? Container()
                        : Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: TextFormField(
                                    controller: _interests,
                                    validator: (value) => value == null ||
                                            value.isEmpty
                                        ? "Interests must not be empty!"
                                        : value.length < 5
                                            ? "Interests must be at least 5 characters long!"
                                            : null,
                                    decoration: InputDecoration(
                                      labelText: 'What are your interests?',
                                      hintText:
                                          "You can add multiple (separate with a comma ,)",
                                      border: const OutlineInputBorder(),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.link,
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                          const SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: DropdownButton<String>(
                                      focusColor: PSU_YELLOW,
                                      style: GoogleFonts.inter(color: PSU_BLUE),
                                      borderRadius: BorderRadius.circular(10),
                                      hint: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                            "Select your Senior High School Strand"),
                                      ),
                                      // menuWidth: 300,
                                      value:
                                          selectedTrack, // Initial selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedTrack = newValue!;
                                        });
                                      },
                                      items: academicTracks
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )),
                              ]
                                  .animate(interval: 0.1.seconds)
                                  .slideX(
                                      duration: .5.seconds,
                                      curve: Curves.easeInOut,
                                      begin: -.05)
                                  .fadeIn(
                                      delay: .1.seconds, curve: Curves.easeIn),
                            )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: currentPage != 0,
                          child: ClickWidget(
                              // SUBMIT FORM
                              onTap: () {},
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(PSU_YELLOW)),
                                  onPressed: () {
                                    setState(() {
                                      currentPage--;
                                    });
                                    // vaidate
                                  },
                                  child: Text(
                                    "Previous",
                                    style: GoogleFonts.inter(
                                        color: PSU_BLUE,
                                        fontWeight: FontWeight.w700),
                                  ))),
                        ),
                        Visibility(
                          visible: currentPage != 0,
                          child: const SizedBox(
                            width: 20,
                          ),
                        ),
                        Visibility(
                          visible: currentPage != 2,
                          child: ClickWidget(
                              // SUBMIT FORM
                              onTap: () {},
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (currentPage == 0) {
                                      setState(() {
                                        currentPage++;
                                      });
                                    } else {
                                      if (currentPersonality.isEmpty) {
                                        setState(() {
                                          validatorMBTI = true;
                                        });
                                      } else {
                                        {
                                          setState(() {
                                            validatorMBTI = false;
                                            if (currentPage != 2) {
                                              currentPage++;
                                            }
                                          });
                                        }
                                      }
                                    }
                                    // vaidate
                                  },
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.inter(
                                        color: PSU_YELLOW,
                                        fontWeight: FontWeight.w700),
                                  ))),
                        ),
                        Visibility(
                          visible: currentPage != 0,
                          child: const SizedBox(
                            width: 20,
                          ),
                        ),
                        Visibility(
                          visible: currentPage == 2,
                          child: ClickWidget(
                              // SUBMIT FORM
                              onTap: () {},
                              child: ElevatedButton(
                                  onPressed: () {
                                    // vaidate
                                    if (currentPersonality.isEmpty) {
                                      setState(() {
                                        validatorMBTI = true;
                                      });
                                      if (_key.currentState!.validate()) {}
                                    } else {
                                      {
                                        setState(() {
                                          validatorMBTI = false;
                                        });
                                      }
                                      if (_key.currentState!.validate()) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              CourseRecommendationJSONCodeScreen(
                                                  currentPersonality,
                                                  _interests.text,
                                                  selectedTrack),
                                        ));
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.inter(
                                        color: PSU_YELLOW,
                                        fontWeight: FontWeight.w700),
                                  ))),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      )
    ], currentpage: "course-recommender");
  }
}
//
//
//
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
//

class MBTISelector extends StatelessWidget {
  const MBTISelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

class MBTIRadioGroup extends StatelessWidget {
  final List<String> mbtiPersonalities;
  final String selectedPersonality;
  final ValueChanged<String> onChanged;

  const MBTIRadioGroup({
    super.key,
    required this.mbtiPersonalities,
    required this.selectedPersonality,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        checkboxTheme:
            CheckboxThemeData(checkColor: WidgetStatePropertyAll(PSU_BLUE)),
      ),
      child: Wrap(
        children: mbtiPersonalities.map((personality) {
          return Padding(
            padding: const EdgeInsets.all(3.5),
            child: SizedBox(
              width: 200,
              child: RadioListTile<String>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1, color: Colors.grey)),
                title: Text(personality),
                value: personality,
                groupValue: selectedPersonality,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
