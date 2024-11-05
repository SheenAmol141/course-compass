import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/blue_menu.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/curricular_offerings/add_curricular_offering_screen.dart';
import 'package:course_compass/pages/curricular_offerings/add_curricular_offering_screen_quill.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:course_compass/pages/curricular_offerings/single_curricular_offer_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurricularOfferingsScreen extends StatefulWidget {
  CurricularOfferingsScreen({super.key});

  @override
  State<CurricularOfferingsScreen> createState() =>
      _CurricularOfferingsScreenState();
}

class _CurricularOfferingsScreenState extends State<CurricularOfferingsScreen> {
// DropdownMenuEntry(
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

  String currentCampus = 'All Campuses';
  final items = const [
    DropdownMenuItem(
      value: 'All Campuses',
      child: Text('ALL CAMPUSES'),
    ),
    DropdownMenuItem(
      value: 'ALAMINOS CITY CAMPUS',
      child: Text('ALAMINOS CITY CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'ASINGAN CAMPUS',
      child: Text('ASINGAN CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'BAYAMBANG CAMPUS',
      child: Text('BAYAMBANG CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'BINMALEY CAMPUS',
      child: Text('BINMALEY CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'INFANTA CAMPUS',
      child: Text('INFANTA CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'LINGAYEN CAMPUS',
      child: Text('LINGAYEN - MAIN CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'SAN CARLOS CAMPUS',
      child: Text('SAN CARLOS CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'STA MARIA CAMPUS',
      child: Text('STA MARIA CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'URDANETA CITY CAMPUS',
      child: Text('URDANETA CITY CAMPUS'),
    ),
    DropdownMenuItem(
      value: 'SCHOOL OF ADVANCED STUDIES',
      child: Text('SCHOOL OF ADVANCED STUDIES'),
    ),
    DropdownMenuItem(
      value: 'OPEN UNIVERSITY SYSTEMS',
      child: Text('OPEN UNIVERSITY SYSTEMS'),
    ),
    DropdownMenuItem(
      value:
          'EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)',
      child: Text(
          'EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    AppBar appBarResponsive = AppBar(
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 120,
      centerTitle: true,
      backgroundColor: LIGHT_GRAY,
      title: Column(
        children: [
          SizedBox(
              height: 50,
              child: Image.asset(fit: BoxFit.contain, "assets/logo.png")),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Material(
                        child: ResponsiveMenu("curricular-offerings")),
                  ));
            },
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
            child: Icon(Icons.menu_rounded, color: PSU_BLUE),
          )
        ],
      ),
    );

    return Scaffold(
      floatingActionButton: Auth().currentUser != null
          ? FloatingActionButton(
              backgroundColor: PSU_BLUE,
              child: Icon(
                Icons.add_rounded,
                color: PSU_YELLOW,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddCurricularOfferingScreen(),
                ));
              })
          : Container(),
      backgroundColor: Colors.white,
      appBar:
          MediaQuery.of(context).size.width < 1050 ? appBarResponsive : appBar,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: LIGHT_GRAY,
                child: Row(
                  children: [
                    MediaQuery.of(context).size.width < 1050
                        ? Container()
                        : Expanded(child: Container()),

                    //CONTENT HERE expanded below ----------------------- gray
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, bottom: 20),
                          child: Text(
                            "Curricular Offerings",
                            style: GoogleFonts.inter(fontSize: 40),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    MediaQuery.of(context).size.width < 1050
                        ? Container()
                        : Expanded(child: Container()),

                    //CONTENT HERE expanded below ----------------------- gray
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40, top: 20.0),
                            child: SizedBox(
                              // width: 300,
                              child: DropdownButton<String>(
                                focusColor: PSU_YELLOW,
                                style: GoogleFonts.inter(color: PSU_BLUE),
                                borderRadius: BorderRadius.circular(10),
                                hint: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                      "Select your Senior High School Strand"),
                                ),
                                // menuWidth: 300,
                                value: currentCampus, // Initial value
                                items: items,
                                onChanged: (value) {
                                  // Handle the selected value
                                  setState(() {
                                    currentCampus = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MediaQuery.of(context).size.width < 1050
                        ? Container()
                        : Expanded(child: Container()),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            color: LIGHT_GRAY,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder(
                                stream: currentCampus == "ALAMINOS CITY CAMPUS"
                                    ? firestore
                                        .collection("curricular_offerings")
                                        .where("campus", isEqualTo: "alaminos")
                                        .snapshots()
                                    : currentCampus == "ASINGAN CAMPUS"
                                        ? firestore
                                            .collection("curricular_offerings")
                                            .where("campus",
                                                isEqualTo: "asingan")
                                            .snapshots()
                                        : currentCampus == "BAYAMBANG CAMPUS"
                                            ? firestore
                                                .collection(
                                                    "curricular_offerings")
                                                .where("campus",
                                                    isEqualTo: "bayambang")
                                                .snapshots()
                                            : currentCampus == "BINMALEY CAMPUS"
                                                ? firestore
                                                    .collection(
                                                        "curricular_offerings")
                                                    .where("campus",
                                                        isEqualTo: "binmaley")
                                                    .snapshots()
                                                : currentCampus ==
                                                        "INFANTA CAMPUS"
                                                    ? firestore
                                                        .collection(
                                                            "curricular_offerings")
                                                        .where("campus",
                                                            isEqualTo:
                                                                "infanta")
                                                        .snapshots()
                                                    : currentCampus ==
                                                            "LINGAYEN CAMPUS"
                                                        ? firestore
                                                            .collection(
                                                                "curricular_offerings")
                                                            .where("campus",
                                                                isEqualTo:
                                                                    "lingayen")
                                                            .snapshots()
                                                        : currentCampus ==
                                                                "SAN CARLOS CAMPUS"
                                                            ? firestore
                                                                .collection(
                                                                    "curricular_offerings")
                                                                .where("campus",
                                                                    isEqualTo:
                                                                        "san-carlos")
                                                                .snapshots()
                                                            : currentCampus ==
                                                                    "STA MARIA CAMPUS"
                                                                ? firestore
                                                                    .collection(
                                                                        "curricular_offerings")
                                                                    .where(
                                                                        "campus",
                                                                        isEqualTo:
                                                                            "santa-maria")
                                                                    .snapshots()
                                                                : currentCampus ==
                                                                        "URDANETA CITY CAMPUS"
                                                                    ? firestore
                                                                        .collection(
                                                                            "curricular_offerings")
                                                                        .where(
                                                                            "campus",
                                                                            isEqualTo:
                                                                                "urdaneta")
                                                                        .snapshots()
                                                                    : currentCampus ==
                                                                            "SCHOOL OF ADVANCED STUDIES"
                                                                        ? firestore
                                                                            .collection(
                                                                                "curricular_offerings")
                                                                            .where("campus",
                                                                                isEqualTo: "SCHOOL OF ADVANCED STUDIES")
                                                                            .snapshots()
                                                                        : currentCampus == "OPEN UNIVERSITY SYSTEMS"
                                                                            ? firestore.collection("curricular_offerings").where("campus", isEqualTo: "OPEN UNIVERSITY SYSTEMS").snapshots()
                                                                            : currentCampus == "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)"
                                                                                ? firestore.collection("curricular_offerings").where("campus", isEqualTo: "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)").snapshots()
                                                                                : firestore.collection("curricular_offerings").orderBy("time_added", descending: true).snapshots(),
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
                                    List<DocumentSnapshot> courses = [];
                                    // int index = 0;

                                    for (int i = 0;
                                        i < snapshot.data!.docs.toList().length;
                                        i++) {
                                      courses
                                          .add(snapshot.data!.docs.toList()[i]);
                                    }
                                    return ListView.builder(
                                      itemCount: courses.length,
                                      itemBuilder: (context, index) {
                                        return CurricularOfferingItem(
                                            courses, index, context);
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
          MediaQuery.of(context).size.width < 1050
              ? Container()
              : const BlueMenu("curricular-offerings")
        ],
      ),
    );
  }

  SizedBox CurricularOfferingItem(List<DocumentSnapshot<Object?>> courses,
      int index, BuildContext context) {
    return SizedBox(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          child: SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: PSU_BLUE,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Center(
                                child: Text(
                                  courses[index]["title"],
                                  style: GoogleFonts.inter(
                                      color: PSU_YELLOW,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Auth().currentUser == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, top: 8, bottom: 8),
                              child: ClickWidget(
                                onTap: () {},
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                      Auth().currentUser == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, top: 8, bottom: 8),
                              child: ClickWidget(
                                onTap: () {},
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(Colors.red)),
                                    onPressed: () {
                                      showDialog(
                                          // login success!
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                content: const Text(
                                                    "Are you sure you want to delete this Admission News?\n\nThis process is irreversible!"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Store().deleteCourse(
                                                            courses[index].id,
                                                            context);
                                                      },
                                                      child: const Text("Yes"))
                                                ],
                                              ));
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            width: 270,
                            child: Text(
                              getCampus(courses[index]["campus"]),
                              style: GoogleFonts.inter(
                                color: PSU_BLUE,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          courses[index]["description"],
                          style: GoogleFonts.inter(
                            fontSize: 16,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0, bottom: 13),
                          child: SizedBox(
                            width: 270,
                            child: Row(
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return SingleCurricularOfferScreen(
                                            courses[index]);
                                      },
                                    ));
                                  },
                                  label: Text(
                                    "Learn More",
                                    style: GoogleFonts.inter(color: PSU_YELLOW),
                                  ),
                                  icon: Icon(
                                    Icons.play_arrow_rounded,
                                    color: PSU_YELLOW,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
