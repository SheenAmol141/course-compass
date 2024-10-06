import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseRecommendationScreen extends StatelessWidget {
  const CourseRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(widget: [
      Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
              child: Text(
                "Thank you for taking the form! Here are your results!",
                overflow: TextOverflow.clip,
                style: GoogleFonts.inter(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(child: Container()),
          Expanded(flex: 3, child: Container())
        ],
      )
    ], currentpage: "");
  }
}
