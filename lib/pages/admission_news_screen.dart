import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/blue_menu.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/add_admission_news_screen.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class AdmissionNewsScreen extends StatelessWidget {
  const AdmissionNewsScreen({super.key});

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
                  builder: (context) => AddAdmissionNewsScreen(),
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
                              "Admission news",
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
                                      .collection("admission_news")
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
                                      //TODO FIX THIS!!!!!!------------------------------------------------

                                      List<DocumentSnapshot> admission_news =
                                          [];
                                      // int indexItem = 0;

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

                                      return GridView.builder(
                                        itemCount: admission_news.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            height: 270,
                                            width: 270,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                color: Colors.white,
                                                child: SizedBox(
                                                  width: 270,
                                                  child: Column(
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
                                                                          js.context.callMethod(
                                                                              'open',
                                                                              [
                                                                                admission_news[index]["link"]
                                                                              ]);
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
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
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
          BlueMenu("admission-news")
        ],
      ),
    );
  }
}
