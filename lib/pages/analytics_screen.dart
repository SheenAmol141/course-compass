import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/admission_news/add_admission_news_screen.dart';
import 'package:course_compass/pages/curricular_offerings/add_curricular_offering_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
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
                                      const AddAdmissionNewsScreen(),
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
                                      const AddCurricularOfferingScreen(),
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
                      children: [
                        ElevatedButton(
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
                            child: Text("a")),
                        StreamBuilder(
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
                                const DropdownMenuItem(
                                  value: "November, 05, 2024",
                                  child: Text("November, 05, 2024"),
                                ),
                                const DropdownMenuItem(
                                  value: "Nov, 5, 2024",
                                  child: Text("Nov, 5, 2024"),
                                ),
                                const DropdownMenuItem(
                                  value: "Nov, 4, 2024",
                                  child: Text("Nov, 4, 2024"),
                                )
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
                        Wrap(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: campuses.map(
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
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(getCampus(e),
                                              style: GoogleFonts.inter(
                                                  color: PSU_YELLOW,
                                                  fontWeight: FontWeight.w800,
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
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18)),
                                        ),
                                        Card(
                                          elevation: 0,
                                          child: SizedBox(
                                              height: 300,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width: 500,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      AnalyticsChart(
                                                          key: UniqueKey(),
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
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18)),
                                        ),
                                        Card(
                                          elevation: 0,
                                          child: SizedBox(
                                              height: 300,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width: 500,
                                                  child: Row(
                                                    children: [
                                                      AnalyticsChart(
                                                          key: UniqueKey(),
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
                        ).toList()),
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
