import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/templates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BlueMenu extends StatelessWidget {
  final String currentPage;
  BlueMenu(
    this.currentPage, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: PSU_BLUE,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                )),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                BlueMenuTile("Home", "home", Icons.home_rounded,
                    currentPage == "home" ? true : false, false),
                BlueMenuTile(
                    "Course Recommender",
                    "course-recommender",
                    Icons.school_rounded,
                    currentPage == "course-recommender" ? true : false,
                    false),
                BlueMenuTile(
                    "Curricular Offerings",
                    "curricular-offerings",
                    Icons.search_rounded,
                    currentPage == "curricular-offerings" ? true : false,
                    false),
                BlueMenuTile(
                    "Admission News",
                    "admission-news",
                    Icons.newspaper_rounded,
                    currentPage == "admission-news" ? true : false,
                    false),
                Expanded(child: Text("")),
                BlueMenuTile("Analytics", "analytics", Icons.bar_chart_rounded,
                    currentPage == "analytics" ? true : false, true),
                BlueMenuTile(
                    "Admin Login",
                    "admin-login",
                    Icons.admin_panel_settings_rounded,
                    currentPage == "admin-login" ? true : false,
                    false),
              ],
            ),
          ),
        ),
        Expanded(flex: 3, child: Container())
      ],
    );
  }
}

class BlueMenuTile extends StatelessWidget {
  final String text;
  final String nav;
  final IconData icon;
  final bool active;
  final bool admin;

  const BlueMenuTile(
    this.text,
    this.nav,
    this.icon,
    this.active,
    this.admin, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Shadow> shadows = [
      Shadow(color: Colors.black.withOpacity(.4), blurRadius: 3)
    ];
    final bool isadmin = FirebaseAuth.instance.currentUser != null;

    final Widget out = ListTile(
        title: ClickWidget(
      onTap: () {
        // print("$nav");
        Navigator.of(context)
          ..pushNamedAndRemoveUntil("/$nav", (Route<dynamic> route) => false);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: active ? Colors.yellow : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                shadows: active ? shadows : [],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: active ? shadows : [],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    Widget output = Container();
    if (isadmin) {
      output = out;
    } else {
      !admin ? output = out : Container();
    }
    return output;
  }
}
