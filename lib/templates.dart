import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  final Widget child;
  const CardTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          child: child,
        ));
  }
}

// [
//       Expanded(
//           flex: 1,
//           child: Container(
//             color: LIGHT_GRAY,
//             child: Row(
//               children: [
//                 Expanded(child: Container()),

//                 //CONTENT HERE expanded below ----------------------- gray
//                 Expanded(
//                     flex: 3,
//                     child: Container(
//                       child: Text("data"),
//                     ))
//               ],
//             ),
//           )),
//       Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Expanded(child: Container()),
//                 //CONTENT HERE expanded below ----------------------- white
//                 Expanded(flex: 3, child: Container())
//               ],
//             ),
//           )),
//     ]

class ClickWidget extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  const ClickWidget({super.key, required this.child, required this.onTap});

  @override
  State<ClickWidget> createState() => _ClickWidgetState();
}

class _ClickWidgetState extends State<ClickWidget> {
  double opacityLev = 1;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          opacityLev = 0.7;
        });
      },
      onExit: (event) {
        setState(() {
          opacityLev = 1;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 150),
            opacity: opacityLev,
            child: widget.child),
      ),
    );
  }
}

class FirebaseStorageImage extends StatefulWidget {
  final String filename;
  FirebaseStorageImage({super.key, required this.filename});

  @override
  State<FirebaseStorageImage> createState() => _FirebaseStorageImageState();
}

class _FirebaseStorageImageState extends State<FirebaseStorageImage> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl = '';

    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('campuses/${widget.filename}.png');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}

class FirebaseImageWidget extends StatelessWidget {
  final String imageUrl;

  const FirebaseImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref().child(imageUrl).getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading image: ${snapshot.error}');
        } else {
          final imageUrl = snapshot.data as String;
          return Image.network(imageUrl);
        }
      },
    );
  }
}

//CHART FL CHART
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart_app/util/extensions/color_extensions.dart';

// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart_app/util/extensions/color_extensions.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

class AnalyticsChart extends StatefulWidget {
  AnalyticsChart({super.key, required this.campus, required this.matched});

  final Color dark = PSU_BLUE;
  final Color normal = PSU_BLUE;
  final Color light = PSU_BLUE;
  final String campus;
  final bool matched;

  @override
  State<StatefulWidget> createState() => AnalyticsChartState();
}

class AnalyticsChartState extends State<AnalyticsChart> {
  //declarations
  bool loading = true;
  List<String> courseTitle = [];
  List<int> courseInterestedNum = [];

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    text = courseTitle[value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  getCourse() {
    FirebaseFirestore.instance
        .collection("curricular_offerings")
        .where("campus", isEqualTo: widget.campus)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          courseTitle.insert(0, docSnapshot["code"]);
          courseInterestedNum.insert(
              0, docSnapshot[!widget.matched ? "interested" : "matched"]);
          print('${courseTitle[0]} = ${courseInterestedNum[0]}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    ).then(
      (value) => setState(() {
        loading = false;
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(loading);
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container()
        : AspectRatio(
            aspectRatio: 1.66,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final barsSpace = 20.0 * constraints.maxWidth / 400;
                  final barsWidth = 8.0 * constraints.maxWidth / 400;
                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      barTouchData: BarTouchData(
                        enabled: false,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget: bottomTitles,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: false,
                        checkToShowHorizontalLine: (value) => value % 10 == 0,
                        // getDrawingHorizontalLine: (value) => FlLine(
                        //   color: PSU_BLUE,
                        //   strokeWidth: 1,
                        // ),
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      groupsSpace: barsSpace,
                      barGroups: getData(barsWidth, barsSpace),
                    ),
                  );
                },
              ),
            ),
          );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    int i = 0;
    List<BarChartGroupData> interestedBars = [];

    for (int x in courseInterestedNum) {
      // String _title = courseTitle[i];
      double width = courseTitle[i].length * 5;
      interestedBars.insert(
        0,
        BarChartGroupData(
          x: i,
          barsSpace: barsSpace,
          barRods: [
            BarChartRodData(
              toY: x.toDouble(),
              borderRadius: BorderRadius.zero,
              width: width,
            )
          ],
        ),
      );
      i++;
    }
    print(interestedBars.length);
    return interestedBars;
  }
}
