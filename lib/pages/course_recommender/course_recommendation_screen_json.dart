import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

import 'package:swipe_cards/swipe_cards.dart';

final model = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: "AIzaSyACO3x6Ygtrc30W19AnWIxt9UaApTMSq3Y",
  // safetySettings: Adjust safety settings
  // See https://ai.google.dev/gemini-api/docs/safety-settings
  generationConfig: GenerationConfig(
    temperature: .5,
    topK: 64,
    topP: 0.95,
    // maxOutputTokens: 300,
    responseMimeType: 'text/plain',
  ),
);

class CourseRecommendationJSONScreen extends StatefulWidget {
  String interests, strand, currentPersonality;

  CourseRecommendationJSONScreen(
      this.currentPersonality, this.interests, this.strand,
      {super.key});

  @override
  State<CourseRecommendationJSONScreen> createState() =>
      _CourseRecommendationJSONScreenState();
}

class _CourseRecommendationJSONScreenState
    extends State<CourseRecommendationJSONScreen> {
  late String content;
  late CareerRecommendation recommendationInstance;
  late MatchEngine matchEngine;
  final TextStyle paragraph = GoogleFonts.inter(fontSize: 16);
  final TextStyle cardTitle = GoogleFonts.inter(
      fontSize: 22, color: PSU_YELLOW, fontWeight: FontWeight.w700);
//

  Future<String> getCourses() async {
    final chat = model.startChat(history: [
      Content.multi([
        TextPart(
            'You are "Course Compass - Course Recommender of Pangasinan State University in the Philippines"\n\nYou will recommend 3 courses that are based on these factors\n\nMBTI Personality\nSenior High School Strand\nInterests\nBase on the Course List Provided (EXPLICITLY ONLY USE THIS LIST)\n\nMBTI: <to be inputted>\nInterests: <to be inputted>\n\nCourse List:\nBachelor of Elementary Education major in Enhanced General Education\nBachelor of Secondary Education major in Mathematics, English\nBS Business Administration major in Operations Mgt., Financial Mgt.\nBS Hospitality Management\nBS Information Technology\n\nBachelor of Secondary Education major in Mathematics, English, Science\nBachelor of Elementary Education major in Enhanced General Education\nBachelor of Technology and Livelihood Education\nBS Business Administration major in Marketing Mgt., Financial Mgt.\nBS Information Technology\nBachelor of Industrial Technology major in Automotive Tech., Electronics Tech., Electrical Tech., Mechanical Tech., Food Service Mgt.\n\nBachelor of Elementary Education\nBachelor of Secondary Education major in English, Filipino, Mathematics, Science, Social Science\nBachelor of Technology and Livelihood Education\nBachelor of Physical Education\nBS Business Administration\nBS Nursing\nBachelor of Public Administration\nAB English Language\nBS Information Technology\nBachelor of Early Childhood Education\n\nBS Fisheries and Aquatic Sciences\nBachelor of Secondary Education\nBS Environmental Science\nBS Criminology\n\nBS Agriculture\nBachelor of Secondary Education major in English, Filipino, Science, Social Studies\nBachelor of Elementary Education\n\nAB English Language\nAB Economics\nBachelor of Secondary Education\nBachelor of Technology and Livelihood Education\nBachelor of Technical and Vocational Teacher Education\nBachelor of Public Administration\nBS Biology\nBS Computer Science\nBS Information Technology\nBS Hospitality Management\nBS Nutrition and Dietetics\nBS Social Work\nBS Business Administration major in Operations Mgt., Financial Mgt.\nBS Mathematics\nBachelor of Industrial Technology\n\nBS Hospitality Management\nBachelor of Elementary Education\nBachelor of Secondary Education major in Filipino, Social Studies\nBachelor of Technology and Livelihood Education\nBS Business Administration major in Human Resource Dev’t. Mgt., Financial Mgt., Marketing Mgt.\nBS Information Technology\nBS Office Administration\n\nBS Agriculture\nBachelor of Secondary Education\nBachelor of Elementary Education\nBachelor of Technology and Livelihood Education\nBS Agricultural and Biosystems Engineering\nBS Agri-Business Management\n\nBS Civil Engineering\nBS Mechanical Engineering\nBS Electrical Engineering\nBS Computer Engineering\nBS Mathematics\nBS Architecture\nBS Information Technology\nAB English Language\nBachelor of Secondary Education major in Filipino, Science\nBachelor of Early Childhood Education\n\nDoctor of Education Majors: (Educational Management, Mathematics, Guidance and Counseling)\nDoctor of Philosophy(Development Studies)\nMaster of Arts in Education Majors: (Educational Management, Guidance and Counseling, Communication Arts-Filipino, Communication Arts-English, Special Education, Science Education, Mathematics, Technology and Home Economics, Instructional Leadership, Computer Education, Social Studies, Sciences and Education)\nMaster in Development Management Majors: (Public Management, Local Government and Regional Administration)\nMaster in Management Engineering\nMaster of Science in Agriculture Majors: (Crop Science, Animal Science, Farming Systems)\nMaster of Science in Aquaculture\n\nDOCTOR OF EDUCATION major in EDUCATIONAL MANAGEMENT\nMASTER OF ARTS IN EDUCATION major in EDUCATION MANAGEMENT\nMASTER OF ARTS IN EDUCATION major in INSTRUCTIONAL LEADERSHIP\nMASTER IN DEVELOPMENT MANAGEMENT major in PUBLIC MANAGEMENT\nMASTER OF SCIENCE IN FISHERIES\n\nBachelor of Education\nBachelor of Industrial Technology\nBachelor of Science in Agriculture\nBachelor of Science in Fisheries\n\nalways reply in json\nNEVERREPLY IN BOLD TEXT ONLY INCLUDE RAW UNFORMATTED TEXT\n\nuse this template as a format for the reply\n\n{\n    "MBTI": "<MBTI here>",\n    "Strand": "<Strand here>",\n    "Interests": "<interests here>",\n    "recommendIntro": "<brief intro of why courses are recommended>",\n"mbtiIntro": "<brief intro of the mbti>",\n    "Course Recommendations": [\n        "<Recommendation 1>",\n        "<Recommendation 2>",\n        "<Recommendation 3>"\n    ],\n    "Course Explanation": [\n        "<Explanation on why recommendation 1 is chosen>",\n        "<Explanation on why recommendation 2 is chosen>",\n        "<Explanation on why recommendation 3 is chosen>"\n    ]\n} ONLY REPLY IN PURE RAW UNFORMATTED JSON'),
      ]),
    ]);
    final message =
        'MBTI: ${widget.currentPersonality}\nInterests: ${widget.interests}\n Strand: ${widget.strand}';
    final content = Content.text(message);

    final response = await chat.sendMessage(content);
    // print(response.text);
    return response.text!;
  }

  late String tempResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    content = "";
    // tempResponse =
    //     '{ "MBTI": "INTP","Strand": "STEM","Interests": "Guitar, Computer Games","Intro": "As an INTP with interests in guitar and computer games, and a STEM background, you might thrive in careers that blend your analytical thinking with your creative and technical interests. Here are three courses that align with your profile:","Course Recommendations": ["BS Information Technology", "Bachelor of Industrial Technology major in Electronics Tech.","BS Computer Science"],"Course Explanation": ["BS Information Technology provides a broad understanding of computer systems and software development, opening doors to various tech roles. Your problem-solving skills and love for technology would be valuable assets in this field. ","Bachelor of Industrial Technology major in Electronics Tech. combines your interest in technology with a hands-on approach. You can explore the technical aspects of electronics, potentially linking it to your passion for guitars and gaming.", "BS Computer Science delves deeper into the theoretical and practical aspects of computing. This aligns well with your analytical mind and could lead to careers in software engineering or game development, fulfilling your interest in computer games."]}';
    // content = tempResponse;
    // recommendationInstance =
    //     CareerRecommendation.fromJson(jsonDecode(tempResponse));

    getCourses().then(
      (value) {
        setState(() {
          try {
            print(value);
            recommendationInstance =
                CareerRecommendation.fromJson(jsonDecode(value));
            content = value;
            matchEngine = MatchEngine(swipeItems: [
              SwipeItem(
                  content: "${recommendationInstance.recommendIntro}",
                  likeAction: () {
                    matchEngine = MatchEngine(swipeItems: [
                      SwipeItem(
                          content: "dataswipe",
                          likeAction: () {
                            print('swiped right');
                          })
                    ]);
                    print('swiped right');
                  })
            ]);
          } catch (e) {
            print(e);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(widget: [
      Container(
        color: LIGHT_GRAY,
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 3,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40),
                  child: content.isEmpty
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You are an",
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.inter(
                                  fontSize: 24, fontWeight: FontWeight.w900),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: PSU_BLUE,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0) +
                                        const EdgeInsets.symmetric(
                                            horizontal: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          recommendationInstance.mbti,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.inter(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w700,
                                              color: PSU_YELLOW),
                                        ),
                                        Card(
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getTitle(
                                                      recommendationInstance
                                                          .mbti),
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: Text(
                                                    recommendationInstance
                                                        .mbtiIntro,
                                                    style: paragraph,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      color: PSU_BLUE,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 386,
                                          child: Builder(
                                            builder: (context) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4),
                                                        child: Text(
                                                          "Some more details about you:",
                                                          style: cardTitle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Card(
                                                    elevation: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Your interests are: ",
                                                            style: GoogleFonts
                                                                .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          Text(
                                                            recommendationInstance
                                                                .interests,
                                                            style: paragraph,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              color:
                                                                  Colors.grey,
                                                              height: 1,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Your strand is: ",
                                                            style: GoogleFonts
                                                                .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          Text(
                                                            recommendationInstance
                                                                .strand,
                                                            style: paragraph,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(child: Container()),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 20),
                child: content.isEmpty
                    ? Center(
                        child: Card(
                          color: PSU_BLUE,
                          child: SizedBox(
                            height: 400,
                            width: 600,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: PSU_YELLOW,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "We are figuring out your recommended courses! Please wait...",
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ClickWidget(
                                onTap: () {
                                  Navigator.of(context)
                                    ..pushNamedAndRemoveUntil(
                                        "/curricular-offerings",
                                        (Route<dynamic> route) => false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Card(
                                    color: PSU_BLUE,
                                    child: SizedBox(
                                      width: 400,
                                      height: 500,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Icon(
                                              Icons.school_rounded,
                                              color: PSU_YELLOW,
                                              size: 110,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "View all Curricular Offerings of PSU",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w900,
                                                  color: PSU_YELLOW),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 800,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      recommendationInstance.recommendIntro,
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  CourseItem(
                                      recommendationInstance
                                          .courseRecommendations[0],
                                      recommendationInstance
                                          .courseExplanations[0]),
                                  CourseItem(
                                      recommendationInstance
                                          .courseRecommendations[1],
                                      recommendationInstance
                                          .courseExplanations[1]),
                                  CourseItem(
                                      recommendationInstance
                                          .courseRecommendations[2],
                                      recommendationInstance
                                          .courseExplanations[2])
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              ))
        ],
      )
    ], currentpage: "course-recommender");
  }

  String getTitle(String mbti) {
    String result = '';
    switch (mbti) {
      case "INTJ":
        result = "The Architect";
      case "INTP":
        result = "The Logician";
      case "ENTJ":
        result = "The Commander";
      case "ENTP":
        result = "The Debater";
      case "INFJ":
        result = "The Advocate";
      case "INFP":
        result = "The Mediator";
      case "ENFJ":
        result = "The Protagonist";
      case "ENFP":
        result = "The Campaigner";
      case "ISTJ":
        result = "The Logistician";
      case "ISFJ":
        result = "The Defender";
      case "ESTJ":
        result = "The Executive";
      case "ESFJ":
        result = "The Consul";
      case "ISTP":
        result = "The Virtuoso";
      case "ISFP":
        result = "The Adventurer";
      case "ESTP":
        result = "The Entrepreneur";
      case "ESFP":
        result = "The Entertainer";
    }
    print(result);
    return result;
  }
}

class CourseItem extends StatelessWidget {
  final String course, description;
  const CourseItem(this.course, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: PSU_YELLOW,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course,
                style: GoogleFonts.inter(
                    color: PSU_BLUE, fontWeight: FontWeight.w800, fontSize: 22),
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CareerRecommendation {
  final String mbti;
  final String strand;
  final String interests;
  final String mbtiIntro;
  final String recommendIntro;
  final List<String> courseRecommendations;
  final List<String> courseExplanations;

  CareerRecommendation({
    required this.mbti,
    required this.strand,
    required this.interests,
    required this.mbtiIntro,
    required this.recommendIntro,
    required this.courseRecommendations,
    required this.courseExplanations,
  });

  factory CareerRecommendation.fromJson(Map<String, dynamic> json) {
    return CareerRecommendation(
      mbti: json['MBTI'],
      strand: json['Strand'],
      interests: json['Interests'],
      mbtiIntro: json['mbtiIntro'],
      recommendIntro: json['recommendIntro'],
      courseRecommendations: List<String>.from(json['Course Recommendations']),
      courseExplanations: List<String>.from(json['Course Explanation']),
    );
  }
}
