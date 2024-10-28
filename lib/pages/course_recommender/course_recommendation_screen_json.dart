import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

final model = GenerativeModel(
  model: 'gemini-1.5-pro',
  apiKey: "AIzaSyACO3x6Ygtrc30W19AnWIxt9UaApTMSq3Y",
  // safetySettings: Adjust safety settings
  // See https://ai.google.dev/gemini-api/docs/safety-settings
  generationConfig: GenerationConfig(
    temperature: .5,
    topK: 64,
    topP: 0.95,
    maxOutputTokens: 300,
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

  Future<String> getCourses() async {
    final chat = model.startChat(history: [
      Content.multi([
        TextPart(
            'You are "Course Compass - Course Recommender of Pangasinan State University in the Philippines"\n\nYou will recommend 3 courses that are based on these factors\n\nMBTI Personality\nSenior High School Strand\nInterests\nBase on the Course List Provided (EXPLICITLY ONLY USE THIS LIST)\n\nMBTI: <to be inputted>\nInterests: <to be inputted>\n\nCourse List:\nBachelor of Elementary Education major in Enhanced General Education\nBachelor of Secondary Education major in Mathematics, English\nBS Business Administration major in Operations Mgt., Financial Mgt.\nBS Hospitality Management\nBS Information Technology\n\nBachelor of Secondary Education major in Mathematics, English, Science\nBachelor of Elementary Education major in Enhanced General Education\nBachelor of Technology and Livelihood Education\nBS Business Administration major in Marketing Mgt., Financial Mgt.\nBS Information Technology\nBachelor of Industrial Technology major in Automotive Tech., Electronics Tech., Electrical Tech., Mechanical Tech., Food Service Mgt.\n\nBachelor of Elementary Education\nBachelor of Secondary Education major in English, Filipino, Mathematics, Science, Social Science\nBachelor of Technology and Livelihood Education\nBachelor of Physical Education\nBS Business Administration\nBS Nursing\nBachelor of Public Administration\nAB English Language\nBS Information Technology\nBachelor of Early Childhood Education\n\nBS Fisheries and Aquatic Sciences\nBachelor of Secondary Education\nBS Environmental Science\nBS Criminology\n\nBS Agriculture\nBachelor of Secondary Education major in English, Filipino, Science, Social Studies\nBachelor of Elementary Education\n\nAB English Language\nAB Economics\nBachelor of Secondary Education\nBachelor of Technology and Livelihood Education\nBachelor of Technical and Vocational Teacher Education\nBachelor of Public Administration\nBS Biology\nBS Computer Science\nBS Information Technology\nBS Hospitality Management\nBS Nutrition and Dietetics\nBS Social Work\nBS Business Administration major in Operations Mgt., Financial Mgt.\nBS Mathematics\nBachelor of Industrial Technology\n\nBS Hospitality Management\nBachelor of Elementary Education\nBachelor of Secondary Education major in Filipino, Social Studies\nBachelor of Technology and Livelihood Education\nBS Business Administration major in Human Resource Dev’t. Mgt., Financial Mgt., Marketing Mgt.\nBS Information Technology\nBS Office Administration\n\nBS Agriculture\nBachelor of Secondary Education\nBachelor of Elementary Education\nBachelor of Technology and Livelihood Education\nBS Agricultural and Biosystems Engineering\nBS Agri-Business Management\n\nBS Civil Engineering\nBS Mechanical Engineering\nBS Electrical Engineering\nBS Computer Engineering\nBS Mathematics\nBS Architecture\nBS Information Technology\nAB English Language\nBachelor of Secondary Education major in Filipino, Science\nBachelor of Early Childhood Education\n\nDoctor of Education Majors: (Educational Management, Mathematics, Guidance and Counseling)\nDoctor of Philosophy(Development Studies)\nMaster of Arts in Education Majors: (Educational Management, Guidance and Counseling, Communication Arts-Filipino, Communication Arts-English, Special Education, Science Education, Mathematics, Technology and Home Economics, Instructional Leadership, Computer Education, Social Studies, Sciences and Education)\nMaster in Development Management Majors: (Public Management, Local Government and Regional Administration)\nMaster in Management Engineering\nMaster of Science in Agriculture Majors: (Crop Science, Animal Science, Farming Systems)\nMaster of Science in Aquaculture\n\nDOCTOR OF EDUCATION major in EDUCATIONAL MANAGEMENT\nMASTER OF ARTS IN EDUCATION major in EDUCATION MANAGEMENT\nMASTER OF ARTS IN EDUCATION major in INSTRUCTIONAL LEADERSHIP\nMASTER IN DEVELOPMENT MANAGEMENT major in PUBLIC MANAGEMENT\nMASTER OF SCIENCE IN FISHERIES\n\nBachelor of Education\nBachelor of Industrial Technology\nBachelor of Science in Agriculture\nBachelor of Science in Fisheries\n\nalways reply in json\nNEVERREPLY IN BOLD TEXT ONLY INCLUDE RAW UNFORMATTED TEXT\n\nuse this template as a format for the reply\n\n{\n    "MBTI": "<MBTI here>",\n    "Strand": "<Strand here>",\n    "Interests": "<interests here>",\n    "Intro": "<brief intro>",\n    "Course Recommendations": [\n        "<Recommendation 1>",\n        "<Recommendation 2>",\n        "<Recommendation 3>"\n    ],\n    "Course Explanation": [\n        "<Explanation on why recommendation 1 is chosen>",\n        "<Explanation on why recommendation 2 is chosen>",\n        "<Explanation on why recommendation 3 is chosen>"\n    ]\n}'),
      ]),
    ]);
    final message =
        'MBTI: ${widget.currentPersonality}\nInterests: ${widget.interests}\n Strand: ${widget.strand}';
    final content = Content.text(message);

    final response = await chat.sendMessage(content);
    print(response.text);
    return response.text!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    content = "";
    getCourses().then(
      (value) {
        setState(() {
          content = value;
          recommendationInstance =
              CareerRecommendation.fromJson(jsonDecode(value));

          print("JSON HERE =-=-=-=-=-=-= " + recommendationInstance.intro);
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
                      : Text(
                          "Thank you for taking the form! Here are your results!",
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.inter(fontSize: 40),
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
                    : Wrap(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              content,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ClickWidget(
                            onTap: () {
                              Navigator.of(context)
                                ..pushNamedAndRemoveUntil(
                                    "/curricular-offerings",
                                    (Route<dynamic> route) => false);
                            },
                            child: Card(
                              color: PSU_BLUE,
                              child: Container(
                                width: 400,
                                height: 500,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
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
                        ],
                      ),
              ))
        ],
      )
    ], currentpage: "course-recommender");
  }
}

class CareerRecommendation {
  final String mbti;
  final String strand;
  final String interests;
  final String intro;
  final List<String> courseRecommendations;
  final List<String> courseExplanations;

  CareerRecommendation({
    required this.mbti,
    required this.strand,
    required this.interests,
    required this.intro,
    required this.courseRecommendations,
    required this.courseExplanations,
  });

  factory CareerRecommendation.fromJson(Map<String, dynamic> json) {
    return CareerRecommendation(
      mbti: json['MBTI'],
      strand: json['Strand'],
      interests: json['Interests'],
      intro: json['Intro'],
      courseRecommendations: List<String>.from(json['Course Recommendations']),
      courseExplanations: List<String>.from(json['Course Explanation']),
    );
  }
}
