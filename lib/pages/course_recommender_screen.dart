import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseRecommenderScreen extends StatefulWidget {
  const CourseRecommenderScreen({super.key});

  @override
  State<CourseRecommenderScreen> createState() =>
      _CourseRecommenderScreenState();
}

class _CourseRecommenderScreenState extends State<CourseRecommenderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(widget: [
      Container(
        color: LIGHT_GRAY,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40),
                  child: Text(
                    "Fill out a short form so we can determine your most suitable courses!",
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.inter(fontSize: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            child: Container(),
            flex: 3,
          )
        ],
      )
    ], currentpage: "course-recommender");
  }
}
