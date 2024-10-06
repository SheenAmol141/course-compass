import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

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

class CourseRecommenderScreen extends StatefulWidget {
  const CourseRecommenderScreen({super.key});

  @override
  State<CourseRecommenderScreen> createState() =>
      _CourseRecommenderScreenState();
}

class _CourseRecommenderScreenState extends State<CourseRecommenderScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _interests = TextEditingController();
  late bool validatorMBTI;
  late String currentPersonality;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPersonality = "";
    validatorMBTI = false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(widget: [
      Container(
        color: LIGHT_GRAY,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Container()),
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
          Expanded(child: Container()),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "First, tell us your Myers-Briggs Type Indicator (MBTI) personality.",
                    style: GoogleFonts.inter(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MBTIRadioGroup(
                    mbtiPersonalities: mbtiPersonalities,
                    selectedPersonality: currentPersonality,
                    onChanged: (value) {
                      setState(() {
                        currentPersonality = value;
                        print(currentPersonality);
                      });
                    },
                  ),
                  Visibility(
                    visible: validatorMBTI,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
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
                                    color: Colors.red.withAlpha(200),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Please select your MBTI Personality!",
                                    style: GoogleFonts.inter(
                                        color: Colors.red.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Don't know your MBTI Personality?",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                color: PSU_YELLOW, fontWeight: FontWeight.w700),
                          ))),
                  Form(
                      key: _key,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
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
                                // hintText: "email@example.com",
                                border: OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.link,
                                        color: Colors.black.withOpacity(0.2)),
                                    SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ClickWidget(
                      // SUBMIT FORM
                      onTap: () {},
                      child: ElevatedButton(
                          onPressed: () {
                            // vaidate
                            if (currentPersonality.isEmpty) {
                              if (_key.currentState!.validate()) {}
                              setState(() {
                                validatorMBTI = true;
                              });
                            } else {
                              setState(() {
                                validatorMBTI = false;
                              });
                            }
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.inter(
                                color: PSU_YELLOW, fontWeight: FontWeight.w700),
                          ))),
                ],
              ),
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
    Key? key,
    required this.mbtiPersonalities,
    required this.selectedPersonality,
    required this.onChanged,
  }) : super(key: key);

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
            child: Container(
              width: 200,
              child: RadioListTile<String>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Colors.grey)),
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
