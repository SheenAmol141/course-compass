import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/blue_menu.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/add_curricular_offering_screen.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:course_compass/pages/single_curricular_offer_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class CurricularOfferingsScreen extends StatelessWidget {
  const CurricularOfferingsScreen({super.key});

// DropdownMenuEntry(
//                                           value: "lingayen",
//                                           label: "Lingayen Campus - Main"),
//                                       DropdownMenuEntry(
//                                           value: "alaminos",
//                                           label: "Alaminos City Campus"),
//                                       DropdownMenuEntry(
//                                           value: "asingan",
//                                           label: "Asingan Campus"),
//                                       DropdownMenuEntry(
//                                           value: "bayambang",
//                                           label: "Bayambang Campus"),
//                                       DropdownMenuEntry(
//                                           value: "binmaley ",
//                                           label: "Binmaley Campus"),
//                                       DropdownMenuEntry(
//                                           value: "infanta",
//                                           label: "Infanta Campus "),
//                                       DropdownMenuEntry(
//                                           value: "san-carlos",
//                                           label: "San Carlos City Campus"),
//                                       DropdownMenuEntry(
//                                           value: "santa-maria",
//                                           label: "Santa Maria Campus"),
//                                       DropdownMenuEntry(
//                                           value: "urdaneta ",
//                                           label: "Urdaneta City Campus"),
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
      default:
    }
    return camp;
  }

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => AddCurricularOfferingScreen(),
                ));
              })
          : Container(),
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: LIGHT_GRAY,
                child: Row(
                  children: [
                    Expanded(child: Container()),

                    //CONTENT HERE expanded below ----------------------- gray
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, bottom: 20),
                            child: Text(
                              "Curricular Offerings",
                              style: GoogleFonts.inter(fontSize: 40),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            child: // THIS IS STREAMBUILDER
                                Card(
                              color: LIGHT_GRAY,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StreamBuilder(
                                  stream: firestore
                                      .collection("curricular_offerings")
                                      .orderBy("time_added", descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: PSU_YELLOW,
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
                                      //TODO THISSSSSS ----------------------------------------------------------------------------------------

                                      List<DocumentSnapshot> admission_news =
                                          [];
                                      // int index = 0;

                                      for (int i = 0;
                                          i <
                                              snapshot.data!.docs
                                                  .toList()
                                                  .length;
                                          i++) {
                                        print("new");
                                        admission_news.add(
                                            snapshot.data!.docs.toList()[i]);
                                      }
                                      return ListView.builder(
                                        itemCount: admission_news.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            height: 270,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                color: Colors.white,
                                                child: SizedBox(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Card(
                                                            color: PSU_BLUE,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Center(
                                                                child: Text(
                                                                  admission_news[
                                                                          index]
                                                                      ["title"],
                                                                  style: GoogleFonts.inter(
                                                                      color:
                                                                          PSU_YELLOW,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15.0),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: 270,
                                                                child: Text(
                                                                  getCampus(admission_news[
                                                                          index]
                                                                      [
                                                                      "campus"]),
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  maxLines: 5,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 270,
                                                                child: Text(
                                                                  admission_news[
                                                                          index]
                                                                      [
                                                                      "description"],
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  maxLines: 5,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            13.0),
                                                                child: SizedBox(
                                                                  width: 270,
                                                                  child: Row(
                                                                    children: [
                                                                      TextButton
                                                                          .icon(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return SingleCurricularOfferScreen(admission_news[index]);
                                                                            },
                                                                          ));
                                                                        },
                                                                        label:
                                                                            Text(
                                                                          "Learn More",
                                                                          style:
                                                                              GoogleFonts.inter(color: PSU_YELLOW),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .play_arrow_rounded,
                                                                          color:
                                                                              PSU_YELLOW,
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
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
          BlueMenu("curricular-offerings")
        ],
      ),
    );
  }
}
