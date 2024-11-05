import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleGuideScreen extends StatefulWidget {
  DocumentSnapshot<Object?> guide;
  SingleGuideScreen(this.guide, {super.key});

  @override
  State<SingleGuideScreen> createState() => _SingleGuideScreenState();
}

class _SingleGuideScreenState extends State<SingleGuideScreen> {
  late QuillController _controller;
  @override
  void initState() {
    super.initState();

    _controller = QuillController.basic();
    _controller.readOnly = true;

    _controller.document =
        Document.fromJson(jsonDecode(widget.guide["description"]));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        title: widget.guide["title"],
        widget: [
          Row(
            children: [
              MediaQuery.of(context).size.width < 1050
                  ? Container()
                  : Expanded(child: Container()),
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
                            imageUrl:
                                'guides/${widget.guide["image_url"]}.png'),
                      ),
                      // Card(
                      //   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   child: FirebaseImageWidget(
                      //       imageUrl: 'campuses/${guide["title"]}.png'),
                      // ),
                      QuillEditor.basic(
                        controller: _controller,
                        configurations: const QuillEditorConfigurations(),
                      ),
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
