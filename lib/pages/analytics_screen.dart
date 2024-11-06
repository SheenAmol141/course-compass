import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/admission_news/add_admission_news_screen.dart';
import 'package:course_compass/pages/curricular_offerings/add_curricular_offering_screen_quill.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatefulWidget {
  AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool loading = true;
  String currentSchoolYear = 'current';

  // String schoolYear = "Nov, 5, 2024";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> campuses = [
      "lingayen",
      "alaminos",
      "asingan",
      "bayambang",
      "binmaley",
      "infanta",
      "san-carlos",
      "santa-maria",
      "urdaneta",
      "SCHOOL OF ADVANCED STUDIES",
      "OPEN UNIVERSITY SYSTEMS",
      "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)"
    ];
    final scrollController = ScrollController();
    const edgeInsets = const EdgeInsets.only(left: 40, top: 20, bottom: 20);
    return BaseWidget(
        title: "Analytics",
        widget: [
          Container(
            height: 350,
            color: Colors.white,
            child: Row(
              children: [
                MediaQuery.of(context).size.width < 1050
                    ? Container()
                    : Expanded(child: Container()),
                //CONTENT HERE expanded below ----------------------- white
                Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
                      child: ListView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          // bottom scrollable
                          Padding(
                            padding: edgeInsets,
                            child: ClickWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AddAdmissionNewsScreen(),
                                ));
                              },
                              child: Card(
                                color: PSU_BLUE,
                                child: Container(
                                  width: 550,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.newspaper_rounded,
                                              size: 150,
                                              color: PSU_YELLOW,
                                            ),
                                            const SizedBox(
                                              width: 100,
                                            ),
                                            Text(
                                              "+",
                                              style: TextStyle(
                                                  fontSize: 120,
                                                  fontWeight: FontWeight.w900,
                                                  color: PSU_YELLOW),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Add Admission News Post",
                                          style: GoogleFonts.inter(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w900,
                                              color: PSU_YELLOW),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: edgeInsets,
                            child: ClickWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AddCurricularOfferingQuillScreen(),
                                ));
                              },
                              child: Card(
                                color: PSU_BLUE,
                                child: Container(
                                  width: 550,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.school_rounded,
                                              size: 150,
                                              color: PSU_YELLOW,
                                            ),
                                            const SizedBox(
                                              width: 100,
                                            ),
                                            Text(
                                              "+",
                                              style: TextStyle(
                                                  fontSize: 120,
                                                  fontWeight: FontWeight.w900,
                                                  color: PSU_YELLOW),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Add Curricular Offering",
                                          style: GoogleFonts.inter(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w900,
                                              color: PSU_YELLOW),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///
                          /////
                          ////
                          ////
                          ////
                          ////
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                          ///
                        ],
                      ),
                    ))
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
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    // login success!
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: const Text(
                                              "Are you sure you want to start a new School Year?\n\nThis process is irreversible!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Store()
                                                      .createNewSchoolYear()
                                                      .then(
                                                    (value) {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                                child: const Text("Yes"))
                                          ],
                                        ));
                              },
                              child: Text(
                                "Start new School Year or reset current School Year | ${getCurrentAndNextYear()}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: PSU_YELLOW),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("school_years")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: PSU_YELLOW,
                                  ),
                                );
                              } else {
                                List<DropdownMenuItem<String>> schoolYears = [
                                  const DropdownMenuItem(
                                    value: "current",
                                    child: Text("Current School Year"),
                                  ),
                                  // const DropdownMenuItem(
                                  //   value: "November, 05, 2024",
                                  //   child: Text("November, 05, 2024"),
                                  // ),
                                  // const DropdownMenuItem(
                                  //   value: "Nov, 5, 2024",
                                  //   child: Text("Nov, 5, 2024"),
                                  // ),
                                  // const DropdownMenuItem(
                                  //   value: "Nov, 4, 2024",
                                  //   child: Text("Nov, 4, 2024"),
                                  // )
                                ];
                                // List docs = [];
                                for (DocumentSnapshot doc
                                    in snapshot.data!.docs.toList()) {
                                  schoolYears.add(DropdownMenuItem(
                                    value: doc.id,
                                    child: Text(doc.id),
                                  ));
                                }
                                return DropdownButton<String>(
                                  menuWidth: 300,
                                  value: currentSchoolYear, // Initial value
                                  items: schoolYears,
                                  onChanged: (value) {
                                    // Handle the selected value
                                    setState(() {
                                      currentSchoolYear = value!;
                                    });
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: campuses
                              .map(
                                (e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Card(
                                      elevation: 20,
                                      color: PSU_BLUE,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: 500,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // SelectableText(
                                              //     '\n\nCourse List: [\n    {\n        "Course Title": "Bachelor of Elementary Education major in Enhanced General Education",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Mathematics, English",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "INFP",\n            "ISTJ",\n            "INTJ",\n            "ENFJ",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Operations Mgt., Financial Mgt.",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Hospitality Management",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "ALAMINOS CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Mathematics, English, Science",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education major in Enhanced General Education",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Marketing Mgt., Financial Mgt.",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENTJ",\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Industrial Technology major in Automotive Tech., Electronics Tech., Electrical Tech., Mechanical Tech., Food Service Mgt.",\n        "Campus": "ASINGAN CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in English, Filipino, Mathematics, Science, Social Science",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ISTJ",\n            "INTJ",\n            "ENFJ",\n            "INFJ",\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Physical Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFP",\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ",\n            "ENTJ",\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Nursing",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Public Administration",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "AB English Language",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Early Childhood Education",\n        "Campus": "BAYAMBANG CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Fisheries and Aquatic Sciences",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Environmental Science",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Criminology",\n        "Campus": "BINMALEY CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Agriculture",\n        "Campus": "INFANTA CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in English, Filipino, Science, Social Studies",\n        "Campus": "INFANTA CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "INFANTA CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "AB English Language",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "AB Economics",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technical and Vocational Teacher Education",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Public Administration",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Biology",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Computer Science",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "BS Hospitality Management",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Nutrition and Dietetics",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Social Work",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Operations Mgt., Financial Mgt.",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Mathematics",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Industrial Technology",\n        "Campus": "LINGAYEN CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "BS Hospitality Management",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Filipino, Social Studies",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Business Administration major in Human Resource Dev’t. Mgt., Financial Mgt., Marketing Mgt.",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ",\n            "INTJ",\n            "ENTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "BS Office Administration",\n        "Campus": "SAN CARLOS CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Agriculture",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ISFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Elementary Education",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Technology and Livelihood Education",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ESFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Agricultural and Biosystems Engineering",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "BS Agri-Business Management",\n        "Campus": "STA MARIA CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Civil Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ESTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Mechanical Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Electrical Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "BS Computer Engineering",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ISTP"\n        ]\n    },\n    {\n        "Course Title": "BS Mathematics",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "INTJ"\n        ]\n    },\n    {\n        "Course Title": "BS Architecture",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "INFJ"\n        ]\n    },\n    {\n        "Course Title": "BS Information Technology",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENTP"\n        ]\n    },\n    {\n        "Course Title": "AB English Language",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFP"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Secondary Education major in Filipino, Science",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Bachelor of Early Childhood Education",\n        "Campus": "URDANETA CITY CAMPUS",\n        "Recommended MBTI": [\n            "ENFJ"\n        ]\n    },\n    {\n        "Course Title": "Doctor of Education Majors: (Educational Management, Mathematics, Guidance and Counseling)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Doctor of Philosophy(Development Studies)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master of Arts in Education Majors: (Educational Management, Guidance and Counseling, Communication Arts-Filipino, Communication Arts-English, Special Education, Science Education, Mathematics, Technology and Home Economics, Instructional Leadership, Computer Education, Social Studies, Sciences and Education)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master in Development Management Majors: (Public Management, Local Government and Regional Administration)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master in Management Engineering",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master of Science in Agriculture Majors: (Crop Science, Animal Science, Farming Systems)",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Master of Science in Aquaculture",\n        "Campus": "SCHOOL OF ADVANCED STUDIES",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "DOCTOR OF EDUCATION major in EDUCATIONAL MANAGEMENT",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER OF ARTS IN EDUCATION major in EDUCATION MANAGEMENT",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER OF ARTS IN EDUCATION major in INSTRUCTIONAL LEADERSHIP",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER IN DEVELOPMENT MANAGEMENT major in PUBLIC MANAGEMENT",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "MASTER OF SCIENCE IN FISHERIES",\n        "Campus": "OPEN UNIVERSITY SYSTEMS",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Education",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Industrial Technology",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Science in Agriculture",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    },\n    {\n        "Course Title": "Bachelor of Science in Fisheries",\n        "Campus": "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)",\n        "Recommended MBTI": []\n    }\n]\n\n\nCourse Code List: [\n    {\n        "Course Title": "Bachelor of Science in Information Technology",\n        "Course Code": "BSIT"\n    }\n    {\n        "Course Title": "Bachelor of Science in Computer Science",\n        "Course Code": "BSCS"\n    }\n    {\n        "Course Title": "Bachelor of Science in Hospitality Management",\n        "Course Code": "BSHM"\n    }\n]\n\n\n\n\nINSTRUCTIONS: \nYou are "Course Compass - Course Recommender of Pangasinan State University in the Philippines"\n\nYou will recommend 3 courses that are based on these factors\n\nMBTI Personality\nSenior High School Strand \nInterests\n\n\nMBTI: <to be inputted>\nInterests: <to be inputted>\nStrand: <to be inputted>\n\n\n\nBase on the Course List Provided (EXPLICITLY ONLY USE THIS LIST)\ndo not include the campus in the reply\nmake sure to correlate the strand and interests to the response explanations\ngive a brief intro for the mbti personality\ngive a brief intro of the results\nmake sure in the course explanation correlate it with the interests\nfor the course explanation keep it at around 100 tokens\nyou will be replying in JSON with a schema\nuse this template for the instructions as well\nif course code is not mentioned just leave it as empty string\n\n{\n    "MBTI": "<MBTI here>",\n    "Strand": "<Strand here>",\n    "Interests": "<interests here>",\n    "mbtiIntro": "<brief intro of mbti>",\n    "recommendIntro": "<brief intro of why recommended (correlate mbti interest and strand)>",\n    "Course Recommendations": [\n        "<Course Recommendation 1>",\n        "<Course Recommendation 2>",\n        "<Course Recommendation 3>"\n    ],\n    "Campuses of Course 1": [],\n    "Campuses of Course 2": [],\n    "Campuses of Course 3": [],\n    "Course Code": [\n        "<Course Code of Course 1>",\n        "<Course Recommendation 2>",\n        "<Course Recommendation 3>"\n    ],\n    "Course Explanation": [\n        "<Explanation on why recommendation 1 is chosen (correlate mbti interest and strand)>",\n        "<Explanation on why recommendation 2 is chosen (correlate mbti interest and strand)>",\n        "<Explanation on why recommendation 3 is chosen (correlate mbti interest and strand)>"\n    ]\n}'),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(getCampus(e),
                                                    style: GoogleFonts.inter(
                                                        color: PSU_YELLOW,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 24)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                      top: 8.0,
                                                    ) +
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                    "Number of Students interested in each Course",
                                                    style: GoogleFonts.inter(
                                                        color: PSU_YELLOW,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18)),
                                              ),
                                              Card(
                                                elevation: 0,
                                                child: SizedBox(
                                                    height: 300,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: SizedBox(
                                                        width: 500,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            AnalyticsChart(
                                                                key:
                                                                    UniqueKey(),
                                                                campus: e,
                                                                matched: false,
                                                                schoolYear:
                                                                    currentSchoolYear),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                      top: 8.0,
                                                    ) +
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                    "Number of Students matched to each Course",
                                                    style: GoogleFonts.inter(
                                                        color: PSU_YELLOW,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18)),
                                              ),
                                              Card(
                                                elevation: 0,
                                                child: SizedBox(
                                                    height: 300,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: SizedBox(
                                                        width: 500,
                                                        child: Row(
                                                          children: [
                                                            AnalyticsChart(
                                                                key:
                                                                    UniqueKey(),
                                                                campus: e,
                                                                matched: true,
                                                                schoolYear:
                                                                    currentSchoolYear),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                              .toList()
                              .animate(interval: 0.1.seconds)
                              .slideX(
                                  duration: .5.seconds,
                                  curve: Curves.easeInOut,
                                  begin: -.05)
                              .fadeIn(delay: .1.seconds, curve: Curves.easeIn),
                        ),
                      ],
                    ),
                  ))
            ],
          )
        ],
        currentpage: "analytics");
  }

  String getCampus(String id) {
    String camp = "Lingayen Campus - Main";
    switch (id) {
      case "lingayen":
        camp = "Lingayen Campus - Main";
      case "alaminos":
        camp = "Alaminos City Campus";
      case "asingan":
        camp = "Asingan Campus";
      case "bayambang":
        camp = "Bayambang Campus";
      case "binmaley":
        camp = "Binmaley Campus";
      case "infanta":
        camp = "Infanta Campus";
      case "san-carlos":
        camp = "San Carlos City Campus";
      case "santa-maria":
        camp = "Santa Maria Campus";
      case "urdaneta":
        camp = "Urdaneta City Campus";
      case "SCHOOL OF ADVANCED STUDIES":
        camp = "SCHOOL OF ADVANCED STUDIES";
      case "OPEN UNIVERSITY SYSTEMS":
        camp = "OPEN UNIVERSITY SYSTEMS";
      case "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)":
        camp =
            "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)";
      default:
    }
    return camp;
  }
}
