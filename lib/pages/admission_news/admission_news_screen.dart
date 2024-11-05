import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/blue_menu.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/admission_news/add_admission_news_screen.dart';
import 'package:course_compass/pages/admission_news/edit_admission_news_screen.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class AdmissionNewsScreen extends StatelessWidget {
  const AdmissionNewsScreen({super.key});

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
                    builder: (context) =>
                        Material(child: ResponsiveMenu("admission-news")),
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

    // double screenWidth = MediaQuery.of(context).size.width;
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
                  builder: (context) => const AddAdmissionNewsScreen(),
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
                  mainAxisAlignment: MediaQuery.of(context).size.width < 1050
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    MediaQuery.of(context).size.width < 1050
                        ? Container()
                        : Expanded(child: Container()),

                    //CONTENT HERE expanded below ----------------------- gray
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: MediaQuery.of(context).size.width < 1050
                              ? const EdgeInsets.only(bottom: 20)
                              : const EdgeInsets.only(left: 40.0, bottom: 20),
                          child: Row(
                            mainAxisAlignment:
                                MediaQuery.of(context).size.width < 1050
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                            children: [
                              Text(
                                "Admission news",
                                style: GoogleFonts.inter(fontSize: 40),
                              ),
                            ],
                          ),
                        ))
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
                                    // TODO FIX THIS!!!!!!------------------------------------------------

                                    List<DocumentSnapshot> admissionNews = [];
                                    // int indexItem = 0;

                                    for (int i = 0;
                                        i < snapshot.data!.docs.toList().length;
                                        i++) {
                                      // print("new");
                                      admissionNews
                                          .add(snapshot.data!.docs.toList()[i]);
                                    }

                                    return GridView.builder(
                                      itemCount: admissionNews.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 1,
                                            child: Card(
                                              color: Colors.white,
                                              child: SizedBox(
                                                // width: 240,v
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Card(
                                                                color: PSU_BLUE,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          6.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      admissionNews[
                                                                              index]
                                                                          [
                                                                          "title"],
                                                                      style: GoogleFonts.inter(
                                                                          color:
                                                                              PSU_YELLOW,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Auth().currentUser ==
                                                                    null
                                                                ? Container()
                                                                : const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                            Auth().currentUser ==
                                                                    null
                                                                ? Container()
                                                                : ClickWidget(
                                                                    onTap:
                                                                        () {},
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return EditAdmissionNewsScreen(doc: admissionNews[index]);
                                                                            },
                                                                          ));
                                                                        },
                                                                        child: const Icon(
                                                                          Icons
                                                                              .edit_rounded,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  ),
                                                            Auth().currentUser ==
                                                                    null
                                                                ? Container()
                                                                : const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                            Auth().currentUser ==
                                                                    null
                                                                ? Container()
                                                                : ClickWidget(
                                                                    onTap:
                                                                        () {},
                                                                    child: ElevatedButton(
                                                                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                                                                        onPressed: () {
                                                                          // print("yes");
                                                                          showDialog(
                                                                              // login success!
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    content: const Text("Are you sure you want to delete this Admission News?"),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                          onPressed: () {
                                                                                            Store().deleteAdmission(admissionNews[index].id, context);
                                                                                          },
                                                                                          child: const Text("Yes"))
                                                                                    ],
                                                                                  ));
                                                                        },
                                                                        child: const Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  )
                                                          ],
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
                                                                admissionNews[
                                                                        index][
                                                                    "description"],
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize: 16,
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
                                                                              admissionNews[index]["link"]
                                                                            ]);
                                                                      },
                                                                      label:
                                                                          Text(
                                                                        "Learn More",
                                                                        style: GoogleFonts.inter(
                                                                            color:
                                                                                PSU_YELLOW),
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
                                                            ),
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
                                              crossAxisCount:
                                                  MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          700
                                                      ? 1
                                                      : MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              1300
                                                          ? 2
                                                          : 3),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
          MediaQuery.of(context).size.width < 1050
              ? Container()
              : BlueMenu("admission-news")
        ],
      ),
    );
  }
}
