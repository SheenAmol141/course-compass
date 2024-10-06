import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/add_admission_news_screen.dart';
import 'package:course_compass/pages/add_curricular_offering_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    const edgeInsets = const EdgeInsets.only(left: 20, top: 20, bottom: 20);
    return BaseWidget(
        title: "Analytics",
        widget: [
          Container(
            height: 350,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: Container()),
                //CONTENT HERE expanded below ----------------------- white
                Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
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
                                            SizedBox(
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
                                      AddCurricularOfferingScreen(),
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
                                            SizedBox(
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
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
        currentpage: "analytics");
  }
}
