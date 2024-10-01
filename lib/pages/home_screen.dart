import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return BaseWidget(
      title: "Admission News",
      widget: [
        Container(
          height: 270,
          color: LIGHT_GRAY,
          child: Row(
            children: [
              Expanded(child: Container()),
              //CONTENT HERE expanded below ----------------------- GREY
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
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

                            List<DocumentSnapshot> admission_news = [];

                            for (var i = 0; i < 5; i++) {
                              try {
                                // print("test");
                                admission_news
                                    .add(snapshot.data!.docs.toList()[i]);
                              } catch (e) {
                                break;
                              }
                            }
                            // return Container(
                            //   child: Center(
                            //     child: Text("${admission_news.length}"),
                            //   ),
                            // );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: admission_news.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (index == admission_news.length) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClickWidget(
                                          onTap: () {
                                            Navigator.of(context)
                                              ..pushNamedAndRemoveUntil(
                                                  "/admission-news",
                                                  (Route<dynamic> route) =>
                                                      false);
                                          },
                                          child: Card(
                                            color: PSU_BLUE,
                                            child: Container(
                                              width: 270,
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.newspaper_rounded,
                                                      color: PSU_YELLOW,
                                                      size: 120,
                                                    ),
                                                    Text("View All",
                                                        style:
                                                            GoogleFonts.inter(
                                                                color:
                                                                    PSU_YELLOW,
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                    );
                                  } else if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0) +
                                          EdgeInsets.only(left: 30),
                                      child: Card(
                                        color: Colors.white,
                                        child: SizedBox(
                                          width: 270,
                                          child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    color: PSU_BLUE,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Center(
                                                        child: Text(
                                                          admission_news[index]
                                                              ["title"],
                                                          style:
                                                              GoogleFonts.inter(
                                                                  color:
                                                                      PSU_YELLOW,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 270,
                                                        child: Text(
                                                          admission_news[index]
                                                              ["description"],
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 16,
                                                          ),
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 13.0),
                                                        child: SizedBox(
                                                          width: 270,
                                                          child: Row(
                                                            children: [
                                                              TextButton.icon(
                                                                onPressed: () {
                                                                  js.context
                                                                      .callMethod(
                                                                          'open',
                                                                          [
                                                                        admission_news[index]
                                                                            [
                                                                            "link"]
                                                                      ]);
                                                                },
                                                                label: Text(
                                                                  "Learn More",
                                                                  style: GoogleFonts
                                                                      .inter(
                                                                          color:
                                                                              PSU_YELLOW),
                                                                ),
                                                                icon: Icon(
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
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: 270,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Card(
                                                  color: PSU_BLUE,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Center(
                                                      child: Text(
                                                        admission_news[index]
                                                            ["title"],
                                                        style:
                                                            GoogleFonts.inter(
                                                                color:
                                                                    PSU_YELLOW,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 270,
                                                      child: Text(
                                                        admission_news[index]
                                                            ["description"],
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 16,
                                                        ),
                                                        maxLines: 5,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 13.0),
                                                      child: SizedBox(
                                                        width: 270,
                                                        child: Row(
                                                          children: [
                                                            TextButton.icon(
                                                              onPressed: () {
                                                                js.context
                                                                    .callMethod(
                                                                        'open',
                                                                        [
                                                                      admission_news[
                                                                              index]
                                                                          [
                                                                          "link"]
                                                                    ]);
                                                              },
                                                              label: Text(
                                                                "Learn More",
                                                                style: GoogleFonts
                                                                    .inter(
                                                                        color:
                                                                            PSU_YELLOW),
                                                              ),
                                                              icon: Icon(
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
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(child: Container()),
              //CONTENT HERE expanded below ----------------------- white
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Not sure what course to take?",
                          style: GoogleFonts.inter(fontSize: 40),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Image.asset("assets/think.png"),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClickWidget(
                                onTap: () {
                                  Navigator.of(context)
                                    ..pushNamedAndRemoveUntil(
                                        "/course-recommender",
                                        (Route<dynamic> route) => false);
                                },
                                child: Card(
                                  color: PSU_BLUE,
                                  child: Container(
                                    width: 500,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(
                                            Icons.search_rounded,
                                            color: PSU_YELLOW,
                                            size: 110,
                                          ),
                                        ),
                                        Text(
                                          "Find a course suitable for you",
                                          style: GoogleFonts.inter(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w900,
                                              color: PSU_YELLOW),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
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
                                    width: 500,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        "Or view all Curricular Offerings",
                                        style: GoogleFonts.inter(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w900,
                                            color: PSU_YELLOW),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
      currentpage: "home",
    );
  }
}
