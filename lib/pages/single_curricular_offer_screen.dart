import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleCurricularOfferScreen extends StatelessWidget {
  DocumentSnapshot<Object?> admission_new;
  SingleCurricularOfferScreen(this.admission_new, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        title: admission_new["title"],
        widget: [
          Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: FirebaseImageWidget(
                            imageUrl: 'campuses/${admission_new["title"]}.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Text(
                          admission_new["description"],
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                      ClickWidget(
                          onTap: () {},
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_left_rounded,
                                    color: PSU_YELLOW,
                                  ),
                                  Text(
                                    "Back",
                                    style: GoogleFonts.inter(
                                        color: PSU_YELLOW,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
        currentpage: "");
  }
}
