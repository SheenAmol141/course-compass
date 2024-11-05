import 'dart:io';

import 'package:course_compass/blue_menu.dart';
import 'package:course_compass/pages/admin_login_screen.dart';
import 'package:course_compass/pages/admission_news/admission_news_screen.dart';
import 'package:course_compass/pages/analytics_screen.dart';
import 'package:course_compass/pages/course_recommender/course_recommender_screen_steps.dart';
import 'package:course_compass/pages/curricular_offerings/curricular_offerings_screen.dart';
import 'package:course_compass/pages/guides/guides_screen.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:course_compass/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:course_compass/hex_colors.dart';
// import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  final prefs = await SharedPreferences.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  bool initScreen;
  initScreen = prefs.getBool("initScreen") ?? false;
  // print(initScreen);
  // await prefs.setBool("initScreen", true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
      theme: ThemeData(
        // textTheme: textTheme,

        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: PSU_BLUE, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: PSU_BLUE.withOpacity(.5), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            textStyle:
                const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
            backgroundColor: WidgetStatePropertyAll(PSU_BLUE),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => SplashScreen(initScreen, prefs),
        '/home': (context) => const HomeScreen(),
        '/admin-login': (context) => AdminLoginScreen(),
        '/analytics': (context) => AnalyticsScreen(),
        '/admission-news': (context) => const AdmissionNewsScreen(),
        '/curricular-offerings': (context) => CurricularOfferingsScreen(),
        '/course-recommender': (context) =>
            const CourseRecommenderStepsScreen(),
        '/guides': (context) => const GuidesScreen(),
        // '/course-recommender': (context) =>
        // CourseRecommendationJSONScreen("a", "a", "a"),
      }));
  //
}

TextTheme textTheme = TextTheme(
    labelLarge: GoogleFonts.inter(
      fontSize: 40,
      color: PSU_BLUE,
      fontWeight: FontWeight.w800,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 30,
      color: PSU_BLUE,
      fontWeight: FontWeight.w700,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 22,
      color: PSU_BLUE,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 18,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 20,
    ));

AppBar appBar = AppBar(
  surfaceTintColor: Colors.transparent,
  toolbarHeight: 100,
  backgroundColor: LIGHT_GRAY,
  title: SizedBox(
      height: 70, child: Image.asset(fit: BoxFit.contain, "assets/logo.png")),
);

class BaseWidget extends StatelessWidget {
  final List<Widget> widget;
  final String currentpage;
  final String? title;
  const BaseWidget(
      {super.key, this.title, required this.widget, required this.currentpage});

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
                        Material(child: ResponsiveMenu(currentpage)),
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          MediaQuery.of(context).size.width < 1050 ? appBarResponsive : appBar,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                title != null
                    ? Container(
                        color: LIGHT_GRAY,
                        child: Row(
                          children: [
                            MediaQuery.of(context).size.width < 1050
                                ? Container()
                                : Expanded(child: Container()),

                            //CONTENT HERE expanded below ----------------------- gray
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, bottom: 20),
                                  child: Text(
                                    title!,
                                    style: GoogleFonts.inter(fontSize: 40),
                                  ),
                                ))
                          ],
                        ),
                      )
                    : Container(),
                ...widget
              ],
            ),
          ),
          MediaQuery.of(context).size.width < 1050
              ? Container()
              : BlueMenu(currentpage)
        ],
      ),
    );
  }
}

class MenuStack extends StatelessWidget {
  final Widget child;
  const MenuStack({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      textDirection: TextDirection.ltr,
      children: [
        child,
        ElevatedButton(
            onPressed: () {},
            child: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ))
      ],
    );
  }
}
