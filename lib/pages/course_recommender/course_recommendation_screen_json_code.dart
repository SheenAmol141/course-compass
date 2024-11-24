import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/curricular_offerings/single_curricular_offer_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'dart:js' as js;

import 'package:swipe_cards/swipe_cards.dart';

String removePrefixSuffix(String inputString, String prefix, String suffix) {
  if (inputString.startsWith(prefix) && inputString.endsWith(suffix)) {
    return inputString.substring(
        prefix.length, inputString.length - suffix.length);
  } else {
    return inputString; // Return the original string if prefixes/suffixes don't match
  }
}

final model = GenerativeModel(
  model: 'gemini-1.5-pro',
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

class CourseRecommendationJSONCodeScreen extends StatefulWidget {
  final String interests, strand, currentPersonality;

  const CourseRecommendationJSONCodeScreen(
      this.currentPersonality, this.interests, this.strand,
      {super.key});

  @override
  State<CourseRecommendationJSONCodeScreen> createState() =>
      _CourseRecommendationJSONCodeScreenState();
}

class _CourseRecommendationJSONCodeScreenState
    extends State<CourseRecommendationJSONCodeScreen> {
  late String content;
  late CareerRecommendation recommendationInstance;
  late MatchEngine matchEngine;
  final TextStyle paragraph = GoogleFonts.inter(fontSize: 16);
  final TextStyle cardTitle = GoogleFonts.inter(
      fontSize: 22, color: PSU_YELLOW, fontWeight: FontWeight.w700);
//

  Future<String> fetchAndCombineCodeAndTitle() async {
    String combinedStrings =
        "Only get the course codes from this list, if course code is not on this list leave as blank \n";

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('curricular_offerings')
          .where("archived", isEqualTo: false)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final String code = doc['code'];
        final String title = doc['title'];
        combinedStrings +=
            '\n{\n"Course Title": "$title",\n"Course Code": "$code"\n},';
        print('\n{"Course Title": "$title","Course Code": "$code"},');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    combinedStrings += "";
    return combinedStrings;
  }

  Future<String> getCourses() async {
    final chat = model.startChat(history: [
      Content.multi([
        TextPart(
            'Course List: [\n    {\n        "Course Title": "Bachelor of Elementary Education major in Enhanced General Education",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Mathematics, English",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "INFP",\n            "ISTJ",\n            "INTJ",\n            "ENFJ",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Operations Mgt., Financial Mgt.",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Hospitality Management",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Mathematics, English, Science",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education major in Enhanced General Education",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Marketing Mgt., Financial Mgt.",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENTJ",\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Industrial Technology major in Automotive Tech., Electronics Tech., Electrical Tech., Mechanical Tech., Food Service Mgt.",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in English, Filipino, Mathematics, Science, Social Science",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ISTJ",\n            "INTJ",\n            "ENFJ",\n            "INFJ",\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Physical Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFP",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ",\n            "ENTJ",\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Nursing",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Public Administration",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "AB English Language",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Early Childhood Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Fisheries and Aquatic Sciences",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Environmental Science",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Criminology",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Agriculture",\n        "Campus": "INFANTA CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in English, Filipino, Science, Social Studies",\n        "Campus": "INFANTA CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "INFANTA CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "AB English Language",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "AB Economics",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technical and Vocational Teacher Education",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Public Administration",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Biology",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Computer Science",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "BS Hospitality Management",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Nutrition and Dietetics",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Social Work",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Operations Mgt., Financial Mgt.",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Mathematics",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Industrial Technology",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "BS Hospitality Management",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Filipino, Social Studies",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Human Resource Dev’t. Mgt., Financial Mgt., Marketing Mgt.",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ",\n            "INTJ",\n            "ENTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "BS Office Administration",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Agriculture",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Agricultural and Biosystems Engineering",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "BS Agri-Business Management",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Civil Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Mechanical Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Electrical Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "BS Computer Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "BS Mathematics",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Architecture",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "AB English Language",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Filipino, Science",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Early Childhood Education",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Doctor of Education Majors: (Educational Management, Mathematics, Guidance and Counseling)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Doctor of Philosophy(Development Studies)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master of Arts in Education Majors: (Educational Management, Guidance and Counseling, Communication Arts-Filipino, Communication Arts-English, Special Education, Science Education, Mathematics, Technology and Home Economics, Instructional Leadership, Computer Education, Social Studies, Sciences and Education)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master in Development Management Majors: (Public Management, Local Government and Regional Administration)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master in Management Engineering",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master of Science in Agriculture Majors: (Crop Science, Animal Science, Farming Systems)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master of Science in Aquaculture",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "DOCTOR OF EDUCATION major in EDUCATIONAL MANAGEMENT",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER OF ARTS IN EDUCATION major in EDUCATION MANAGEMENT",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER OF ARTS IN EDUCATION major in INSTRUCTIONAL LEADERSHIP",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER IN DEVELOPMENT MANAGEMENT major in PUBLIC MANAGEMENT",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER OF SCIENCE IN FISHERIES",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Education",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Industrial Technology",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Science in Agriculture",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Science in Fisheries",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    }\n]\n\n\n\n\n\n\n\nINSTRUCTIONS: \nYou are "Course Compass - Course Recommender of Pangasinan State University in the Philippines"\n\nYou will recommend 3 courses that are based on these factors\n\nMBTI Personality\nSenior High School Strand \nInterests\n\n\nMBTI: <to be inputted>\nInterests: <to be inputted>\nStrand: <to be inputted>\n\n\n\nBase on the Course List Provided (EXPLICITLY ONLY USE THIS LIST)\ndo not include the campus in the reply\nmake sure to correlate the strand and interests to the response explanations\ngive a brief intro for the mbti personality\ngive a brief intro of the results\nmake sure in the course explanation correlate it with the interests\nfor the course explanation keep it at around 100 tokens\nyou will be replying in JSON with a schema\nuse this template for the instructions as well\nif course code is not mentioned just leave it as empty string\nyou will be replying in JSON with this schema\n{\n    "MBTI": "<MBTI here>",\n    "Strand": "<Strand here>",\n    "Interests": "<interests here>",\n    "mbtiIntro": "<brief intro of mbti>",\n    "recommendIntro": "<brief intro of why recommended (correlate mbti interest and strand)>",\n    "Course Recommendations": [\n        "<Course Recommendation 1>",\n        "<Course Recommendation 2>",\n        "<Course Recommendation 3>"\n    ],\n    "Campuses of Course 1": [],\n    "Campuses of Course 2": [],\n    "Campuses of Course 3": [],\n    "Course Code": [\n        "<Course Code of Course 1>",\n        "<Course Recommendation 2>",\n        "<Course Recommendation 3>"\n    ],\n    "Course Explanation": [\n        "<Explanation on why recommendation 1 is chosen (correlate mbti interest and strand)>",\n        "<Explanation on why recommendation 2 is chosen (correlate mbti interest and strand)>",\n        "<Explanation on why recommendation 3 is chosen (correlate mbti interest and strand)>"\n    ]\n}\n\na dataset for the course codes will be sent in the next message (you do not have to explicitly recommend courses that only has course codes) (do not use the course titles in the course codes dataset, only use it as a reference for the dataset of all courses) if there is not course code dataset just leave each as blank\n'),
      ]),
    ]);
    final message =
        'MBTI: ${widget.currentPersonality}\nInterests: ${widget.interests}\n Strand: ${widget.strand}' +
            await fetchAndCombineCodeAndTitle();
    // 'MBTI: MBTI: ${widget.currentPersonality}\nInterests: ${widget.interests}\n Strand: ${widget.strand}\n\n\n\nCourse Code dataset: [\n    {\n        "Course Title": "Bachelor of Science in Information Technology",\n        "Course Code": "BSIT"\n    },\n    {\n        "Course Title": "Bachelor of Science in Computer Science",\n        "Course Code": "BSCS"\n    },\n{"Course Title": "Bachelor of Technology and Livelihood Education",\n        "Course Code": "BSTVL"},\n]';
    final content = Content.text(message);

    final response = await chat.sendMessage(content);
    // print(response.text);
    return response.text!;
  }

  var responseLoaded = false;
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
          print(value);
          try {
            try {
              recommendationInstance =
                  CareerRecommendation.fromJson(jsonDecode(value));
            } on Exception catch (e) {
              recommendationInstance = CareerRecommendation.fromJson(
                  jsonDecode(removePrefixSuffix(value, "```json", "```")));
              // TODO
            }
            responseLoaded = true;
            // content = value;
            // matchEngine = MatchEngine(swipeItems: [
            //   SwipeItem(
            //       content: "${recommendationInstance.recommendIntro}",
            //       likeAction: () {
            //         matchEngine = MatchEngine(swipeItems: [
            //           SwipeItem(
            //               content: "dataswipe",
            //               likeAction: () {
            //                 print('swiped right');
            //               })
            //         ]);
            //         print('swiped right');
            //       })
            // ]);
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
            MediaQuery.of(context).size.width < 1050
                ? Container()
                : Expanded(child: Container()),
            Expanded(
              flex: 3,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40),
                  child: !responseLoaded
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
                            Wrap(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: PSU_BLUE,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: GoogleFonts.inter(
                                                          fontSize: 12),
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Details from ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '16personalities.com.',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  js.context
                                                                      .callMethod(
                                                                          'open',
                                                                          [
                                                                        "https://www.16personalities.com/free-personality-test"
                                                                      ]);
                                                                },
                                                        ),
                                                      ],
                                                    ),
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
                                Card(
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
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
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 18),
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
                                                            color: Colors.grey,
                                                            height: 1,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Your strand is: ",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 18),
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
          MediaQuery.of(context).size.width < 1050
              ? Container()
              : Expanded(child: Container()),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 20),
                child: !responseLoaded
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
                                  const SizedBox(
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
                    : Builder(builder: (context) {
                        for (String code in recommendationInstance.code) {
                          Store().incrementMatchedCount(code);
                        }
                        return MediaQuery.of(context).size.width < 1050
                            ? Wrap(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0) +
                                        const EdgeInsets.only(right: 28.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, bottom: 8),
                                          child: Text(
                                            recommendationInstance
                                                .recommendIntro,
                                            style: GoogleFonts.inter(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        CourseItem(
                                          recommendationInstance
                                              .courseRecommendations[0],
                                          recommendationInstance
                                              .courseExplanations[0],
                                          recommendationInstance.code[0],
                                          campuses: recommendationInstance
                                              .course1Campus,
                                        ),
                                        CourseItem(
                                            recommendationInstance
                                                .courseRecommendations[1],
                                            recommendationInstance
                                                .courseExplanations[1],
                                            recommendationInstance.code[1],
                                            campuses: recommendationInstance
                                                .course2Campus),
                                        CourseItem(
                                            recommendationInstance
                                                .courseRecommendations[2],
                                            recommendationInstance
                                                .courseExplanations[2],
                                            recommendationInstance.code[2],
                                            campuses: recommendationInstance
                                                .course3Campus)
                                      ]
                                          .animate(interval: 0.50.seconds)
                                          .slideX(
                                              duration: 1.seconds,
                                              curve: Curves.easeInOut,
                                              begin: -.05)
                                          .fadeIn(
                                              delay: .5.seconds,
                                              curve: Curves.easeIn),
                                    ),
                                  ),
                                  ClickWidget(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "/curricular-offerings",
                                              (Route<dynamic> route) => false);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Card(
                                        color: PSU_BLUE,
                                        child: SizedBox(
                                          width: 400,
                                          height: 300,
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
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  "View all Curricular Offerings of PSU",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w900,
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
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 8),
                                            child: Text(
                                              recommendationInstance
                                                  .recommendIntro,
                                              style: GoogleFonts.inter(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          CourseItem(
                                            recommendationInstance
                                                .courseRecommendations[0],
                                            recommendationInstance
                                                .courseExplanations[0],
                                            recommendationInstance.code[0],
                                            campuses: recommendationInstance
                                                .course1Campus,
                                          ),
                                          CourseItem(
                                              recommendationInstance
                                                  .courseRecommendations[1],
                                              recommendationInstance
                                                  .courseExplanations[1],
                                              recommendationInstance.code[1],
                                              campuses: recommendationInstance
                                                  .course2Campus),
                                          CourseItem(
                                              recommendationInstance
                                                  .courseRecommendations[2],
                                              recommendationInstance
                                                  .courseExplanations[2],
                                              recommendationInstance.code[2],
                                              campuses: recommendationInstance
                                                  .course3Campus)
                                        ]
                                            .animate(interval: 0.50.seconds)
                                            .slideX(
                                                duration: 1.seconds,
                                                curve: Curves.easeInOut,
                                                begin: -.05)
                                            .fadeIn(
                                                delay: .5.seconds,
                                                curve: Curves.easeIn),
                                      ),
                                    ),
                                  ),
                                  ClickWidget(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "/curricular-offerings",
                                              (Route<dynamic> route) => false);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Card(
                                        color: PSU_BLUE,
                                        child: SizedBox(
                                          width: 400,
                                          height: 300,
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
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  "View all Curricular Offerings of PSU",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w900,
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
                              );
                      }),
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
  final String course, description, code;
  final List<String> campuses;
  const CourseItem(this.course, this.description, this.code,
      {super.key, required this.campuses});

  @override
  Widget build(BuildContext context) {
    bool done = false;
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
              code == ""
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "Course Code: $code",
                          style: GoogleFonts.inter(
                              color: PSU_BLUE,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        const Spacer(),
                        ClickWidget(
                          onTap: () {},
                          child: ElevatedButton(
                              onPressed: () {
                                if (done) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: const Text(
                                          "You've let us know already."),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Okay"))
                                      ],
                                    ),
                                  );
                                } else {
                                  Store().incrementInterestedCount(code).then(
                                    (value) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: const Text("Thank you!."),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Okay"))
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  done = true;
                                }
                              },
                              child: Text(
                                "I'm Interested!",
                                style: GoogleFonts.inter(
                                    color: PSU_YELLOW,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              )),
                        )
                      ],
                    ),
              Text(
                description,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Text(
                "Campuses that offer this Course: ",
                style: GoogleFonts.inter(
                    color: PSU_BLUE, fontWeight: FontWeight.w800, fontSize: 20),
              ),
              Wrap(
                  children: campuses.map(
                (e) {
                  return ClickWidget(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await Store().checkCurriculumOffering(
                                code, getCampusReversed(e))) {
                              DocumentSnapshot doc =
                                  await Store().getOfferingScreen(code, e);
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) {
                                  return SingleCurricularOfferScreen(doc);
                                },
                              ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text(
                                      "This Campus has not yet created this Course's page."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Okay"))
                                  ],
                                ),
                              );
                            }
                          },
                          child: Text(
                            e,
                            style: GoogleFonts.inter(
                                color: PSU_YELLOW,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ));
                },
              ).toList()),
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
  final List<String> code;
  final List<String> courseExplanations;
  final List<String> course1Campus;
  final List<String> course2Campus;
  final List<String> course3Campus;

  CareerRecommendation({
    required this.mbti,
    required this.strand,
    required this.interests,
    required this.mbtiIntro,
    required this.code,
    required this.recommendIntro,
    required this.courseRecommendations,
    required this.courseExplanations,
    required this.course1Campus,
    required this.course2Campus,
    required this.course3Campus,
  });

  factory CareerRecommendation.fromJson(Map<String, dynamic> json) {
    print(json["Course Code"]);
    return CareerRecommendation(
      mbti: json['MBTI'],
      strand: json['Strand'],
      interests: json['Interests'],
      code: List<String>.from(json['Course Code']),
      mbtiIntro: json['mbtiIntro'],
      recommendIntro: json['recommendIntro'],
      courseRecommendations: List<String>.from(json['Course Recommendations']),
      course1Campus: List<String>.from(json['Campuses of Course 1']),
      course2Campus: List<String>.from(json['Campuses of Course 2']),
      course3Campus: List<String>.from(json['Campuses of Course 3']),
      courseExplanations: List<String>.from(json['Course Explanation']),
    );
  }
}

String getCampusReversed(String id) {
  String camp = "lingayen";
  switch (id) {
    case "LINGAYEN CAMPUS":
      camp = "lingayen";
    case "ALAMINOS CITY CAMPUS":
      camp = "alaminos";
    case "ASINGAN CAMPUS":
      camp = "asingan";
    case "BAYAMBANG CAMPUS":
      camp = "bayambang";
    case "BINMALEY CAMPUS":
      camp = "binmaley";
    case "INFANTA CAMPUS":
      camp = "infanta";
    case "SAN CARLOS CAMPUS":
      camp = "san-carlos";
    case "STA MARIA CAMPUS":
      camp = "santa-maria";
    case "URDANETA CITY CAMPUS":
      camp = "urdaneta";
    case "SCHOOL OF ADVANCED STUDIES":
      camp = "SCHOOL OF ADVANCED STUDIES";
    case "OPEN UNIVERSITY SYSTEMS":
      camp = "OPEN UNIVERSITY SYSTEMS";
    case "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)":
      camp =
          "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)";
    default:
  }
  print(camp);
  return camp;
}
