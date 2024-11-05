import 'dart:convert';

import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';

class Quilltemplate extends StatefulWidget {
  const Quilltemplate({super.key});

  @override
  State<Quilltemplate> createState() => _QuilltemplateState();
}

class _QuilltemplateState extends State<Quilltemplate> {
  late QuillController _controller1;
  late QuillController _controller2;
  @override
  void initState() {
    super.initState();

    _controller1 = QuillController.basic();
    _controller2 = QuillController.basic();
    _controller2.readOnly = true;
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  String text = "";
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    final TextEditingController title = TextEditingController();
    final TextEditingController description = TextEditingController();

    const edgeInsets = EdgeInsets.only(top: 8.0, left: 8, right: 8);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: key,
              child: Card(
                color: LIGHT_GRAY,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Colors.white,
                    child: SizedBox(
                      width: 800,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            margin: const EdgeInsets.all(0),
                            color: PSU_BLUE,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Add a Guide",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: PSU_YELLOW,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: edgeInsets,
                            child: TextFormField(
                              controller: title,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Title must not be empty!"
                                  : value.length < 5
                                      ? "Title must be at least 5 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                // hintText: "email@example.com",
                                border: const OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.title_rounded,
                                        color: Colors.black.withOpacity(0.2)),
                                    const SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          QuillSimpleToolbar(
                            controller: _controller1,
                            configurations:
                                const QuillSimpleToolbarConfigurations(),
                          ),
                          Expanded(
                            child: QuillEditor.basic(
                              controller: _controller1,
                              configurations: const QuillEditorConfigurations(),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  text = jsonEncode(
                                      _controller1.document.toDelta().toJson());
                                  _controller2.document =
                                      Document.fromJson(jsonDecode(text));
                                });
                              },
                              child: Text("Read")),
                          Expanded(
                              child: Card(
                            elevation: 20,
                            child: Text("$text"),
                          )),
                          Expanded(
                            child: QuillEditor.basic(
                              controller: _controller2,
                              configurations: const QuillEditorConfigurations(),
                            ),
                          ),
                          // Padding(
                          //   padding: edgeInsets,
                          //   child: ClickWidget(
                          //     onTap: () {},
                          //     child: ElevatedButton(
                          //         onPressed: () {
                          //           if (key.currentState!.validate()) {
                          //             // print(title.text +
                          //             //     description.text +
                          //             //     link.text);
                          //             key.currentState!.validate();
                          //             Store()
                          //                 .uploadGuide(
                          //                     title: title.text,
                          //                     description: jsonEncode(
                          //                         _controller1.document
                          //                             .toDelta()
                          //                             .toJson()))
                          //                 .then(
                          //               (value) {
                          //                 showDialog(
                          //                   context: context,
                          //                   builder: (context) => AlertDialog(
                          //                     actions: [
                          //                       TextButton(
                          //                           onPressed: () {
                          //                             Navigator.of(context)
                          //                                 .pop();
                          //                             Navigator.of(context)
                          //                                 .pop();
                          //                           },
                          //                           child: const Text("Okay"))
                          //                     ],
                          //                     content: const Text(
                          //                       "Guide added successfully!",
                          //                     ),
                          //                   ),
                          //                 );
                          //               },
                          //             );
                          //           }
                          //         },
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text(
                          //               "Submadasdadasaaaaaaaaaddwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwaadadasaaaaaaaaaaaasdadasdadadaaaaa it",
                          //               style: GoogleFonts.inter(
                          //                   color: Colors.white,
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w700),
                          //             ),
                          //           ],
                          //         )),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}


// js.context.callMethod('open',
//                                 ['https://stackoverflow.com/questions/ask']);