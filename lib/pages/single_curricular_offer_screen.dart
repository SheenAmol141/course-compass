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
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            color: LIGHT_GRAY,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                child: SizedBox(
                  width: 800,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        admission_new["title"],
                        style: GoogleFonts.inter(
                          fontSize: 30,
                        ),
                      ),
                      FirebaseImageWidget(
                          imageUrl: 'campuses/${admission_new["title"]}.png'),
                      Text(
                        admission_new["title"],
                        style: GoogleFonts.inter(),
                      ),
                      ClickWidget(
                          onTap: () {},
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Back")))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
