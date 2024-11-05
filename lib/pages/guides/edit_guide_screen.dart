import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:html';

class EditGuideScreen extends StatefulWidget {
  final DocumentSnapshot doc;

  const EditGuideScreen({super.key, required this.doc});

  @override
  State<EditGuideScreen> createState() => _EditGuideScreenState();
}

class _EditGuideScreenState extends State<EditGuideScreen> {
  bool replaceImage = false;

  File? image = null;

  String? dataUrl = null;

  final key = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();

  late QuillController _controller1;
  @override
  void initState() {
    super.initState();

    _controller1 = QuillController.basic();
    _controller1.document =
        Document.fromJson(jsonDecode(widget.doc["description"]));
    title.text = widget.doc["title"];
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
  }

  String text = "";
  @override
  Widget build(BuildContext context) {
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
                            child: MediaQuery.of(context).size.width < 800
                                ? Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Edit Guide | ${widget.doc["title"]}",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          color: PSU_YELLOW,
                                          fontSize: 20),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Edit Guide | ${widget.doc["title"]}",
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
                          ClickWidget(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    FileUploadInputElement uploadInput =
                                        FileUploadInputElement()
                                          ..accept = 'image/*';
                                    uploadInput.click();

                                    uploadInput.onChange.listen((event) {
                                      image = uploadInput.files!.first;
                                      final reader = FileReader();
                                      reader.readAsDataUrl(image!);
                                      reader.onLoadEnd.listen(
                                        (event) {
                                          print("done");
                                          setState(() {
                                            dataUrl = reader.result as String?;
                                            replaceImage = true;
                                          });
                                        },
                                      );
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1.5),
                                    child: Text(
                                      "Update Preview Image",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          color: PSU_YELLOW,
                                          fontSize: 16),
                                    ),
                                  )),
                            ),
                          ),
                          // Padding(
                          //   padding: edgeInsets,
                          //   child: TextFormField(
                          //     controller: title,
                          //     readOnly: true,
                          //     validator: (value) => value == null ||
                          //             value.isEmpty
                          //         ? "Title must not be empty!"
                          //         : value.length < 5
                          //             ? "Title must be at least 5 characters long!"
                          //             : null,
                          //     decoration: InputDecoration(
                          //       labelText: 'Title',
                          //       // hintText: "email@example.com",
                          //       border: const OutlineInputBorder(),

                          //       suffixIcon: Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Icon(Icons.title_rounded,
                          //               color: Colors.black.withOpacity(0.2)),
                          //           const SizedBox(
                          //             width: 5,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                          dataUrl != null
                              ? Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(dataUrl!)),
                                )
                              : Container(),
                          replaceImage
                              ? Container()
                              : Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: FirebaseImageWidget(
                                      imageUrl:
                                          'guides/${widget.doc["image_url"]}.png'),
                                ),
                          Padding(
                            padding: edgeInsets,
                            child: ClickWidget(
                              onTap: () {},
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (key.currentState!.validate()) {
                                      if (replaceImage) {
                                        // print(title.text +
                                        //     description.text +
                                        //     link.text);
                                        key.currentState!.validate();

                                        Store()
                                            .uploadGuide(
                                                replaceImage: true,
                                                id: widget.doc.id,
                                                title: title.text,
                                                description: jsonEncode(
                                                        _controller1.document
                                                            .toDelta()
                                                            .toJson()) ??
                                                    "",
                                                img: image!)
                                            .then(
                                          (value) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("Okay"))
                                                ],
                                                content: const Text(
                                                  "Guide updated successfully!",
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        // print(title.text +
                                        //     description.text +
                                        //     link.text);
                                        key.currentState!.validate();

                                        Store()
                                            .uploadGuide(
                                          replaceImage: false,
                                          id: widget.doc.id,
                                          title: title.text,
                                          description: jsonEncode(_controller1
                                                  .document
                                                  .toDelta()
                                                  .toJson()) ??
                                              "",
                                        )
                                            .then(
                                          (value) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("Okay"))
                                                ],
                                                content: const Text(
                                                  "Guide updated successfully!",
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Submit",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
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