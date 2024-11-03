import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
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
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Text(
                          "Interested ${admission_new["interested"]}",
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                      InterestedButton(admission_new: admission_new)
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

class InterestedButton extends StatefulWidget {
  const InterestedButton({
    super.key,
    required this.admission_new,
  });

  final DocumentSnapshot<Object?> admission_new;

  @override
  State<InterestedButton> createState() => _InterestedButtonState();
}

class _InterestedButtonState extends State<InterestedButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                loading = true;
              });
              Store()
                  .addInterested(
                      courseTitle: widget.admission_new.id,
                      current: widget.admission_new["interested"])
                  .then(
                (value) {
                  setState(() {
                    loading = false;
                  });
                  showDialog(
                      // login success!
                      context: context,
                      builder: (context) => AlertDialog(
                            content: const Text(
                                "Thank you for letting us know you are interested in this course!"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Okay"))
                            ],
                          ));
                },
              );
            },
            child: const Text("I'm Interested!")),
        loading
            ? CircularProgressIndicator(
                color: PSU_BLUE,
              )
            : Container()
      ],
    );
  }
}
