import 'dart:convert';
import 'dart:typed_data';

import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;
import 'dart:html';

import 'package:image_picker_web/image_picker_web.dart';

class AddCurricularOfferingQuillScreen extends StatefulWidget {
  const AddCurricularOfferingQuillScreen({super.key});

  @override
  State<AddCurricularOfferingQuillScreen> createState() =>
      _AddCurricularOfferingQuillScreenState();
}

class _AddCurricularOfferingQuillScreenState
    extends State<AddCurricularOfferingQuillScreen> {
  String? dataUrl = null;
  File? image = null;
  String _campus = 'lingayen';
  String plainDescription = '';
  final _key = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _code = TextEditingController();

  late QuillController quillController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quillController = QuillController.basic();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quillController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _link = TextEditingController();

    const edgeInsets = const EdgeInsets.only(top: 8.0, left: 8, right: 8);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _key,
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
                          Card(
                            margin: const EdgeInsets.all(0),
                            color: PSU_BLUE,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Add Curricular Offer",
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
                          Row(
                            children: [
                              Padding(
                                padding: edgeInsets,
                                child: DropdownMenu(
                                    width: 300,
                                    enableFilter: false,
                                    enableSearch: false,
                                    initialSelection: _campus,
                                    onSelected: (value) {
                                      _campus = value!;
                                      print(_campus);
                                    },
                                    inputDecorationTheme:
                                        const InputDecorationTheme(),
                                    dropdownMenuEntries: const [
                                      DropdownMenuEntry(
                                          value: "lingayen",
                                          label: "Lingayen Campus - Main"),
                                      DropdownMenuEntry(
                                          value: "alaminos",
                                          label: "Alaminos City Campus"),
                                      DropdownMenuEntry(
                                          value: "asingan",
                                          label: "Asingan Campus"),
                                      DropdownMenuEntry(
                                          value: "bayambang",
                                          label: "Bayambang Campus"),
                                      DropdownMenuEntry(
                                          value: "binmaley",
                                          label: "Binmaley Campus"),
                                      DropdownMenuEntry(
                                          value: "infanta",
                                          label: "Infanta Campus "),
                                      DropdownMenuEntry(
                                          value: "san-carlos",
                                          label: "San Carlos City Campus"),
                                      DropdownMenuEntry(
                                          value: "santa-maria",
                                          label: "Santa Maria Campus"),
                                      DropdownMenuEntry(
                                          value: "urdaneta",
                                          label: "Urdaneta City Campus"),
                                    ]),
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
                                                dataUrl =
                                                    reader.result as String?;
                                              });
                                            },
                                          );
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.5),
                                        child: Text(
                                          "Upload Preview Image",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700,
                                              color: PSU_YELLOW,
                                              fontSize: 16),
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: edgeInsets,
                            child: TextFormField(
                              controller: _title,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Course Title must not be empty!"
                                  : value.length < 5
                                      ? "Course Title must be at least 2 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                                hintText:
                                    "ex: Bachelor of Science in Information Technology",
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
                          Padding(
                            padding: edgeInsets,
                            child: TextFormField(
                              controller: _code,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Course Code must not be empty!"
                                  : value.length < 2
                                      ? "Course Code must be at least 2 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                                hintText: "ex: BSIT",
                                labelText: 'Course Code',
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
                          Padding(
                              padding: edgeInsets,
                              child: Column(
                                children: [
                                  QuillSimpleToolbar(
                                    controller: quillController,
                                    configurations:
                                        const QuillSimpleToolbarConfigurations(),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: QuillEditor.basic(
                                      controller: quillController,
                                      configurations:
                                          const QuillEditorConfigurations(
                                              minHeight: 10,
                                              placeholder:
                                                  "Course Description"),
                                    ),
                                  ),
                                ],
                              )),
                          // Padding(
                          //   padding: edgeInsets,
                          //   child: TextFormField(
                          //     controller: _link,
                          //     validator: (value) => value == null ||
                          //             value.isEmpty
                          //         ? "Link must not be empty!"
                          //         : value.length < 5
                          //             ? "Link must be at least 5 characters long!"
                          //             : null,
                          //     decoration: InputDecoration(
                          //       labelText: 'Link',
                          //       // hintText: "email@example.com",
                          //       border: OutlineInputBorder(),

                          //       suffixIcon: Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Icon(Icons.link,
                          //               color: Colors.black.withOpacity(0.2)),
                          //           SizedBox(
                          //             width: 5,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          dataUrl != null
                              ? Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(dataUrl!)),
                                )
                              : Container(),
                          Padding(
                            padding: edgeInsets,
                            child: ClickWidget(
                              onTap: () {},
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      print("upload " + _campus);
                                      _key.currentState!.validate();
                                      Store()
                                          .uploadCourse(
                                              coursetitle: _title.text,
                                              coursecode: _code.text,
                                              courseDescription: jsonEncode(
                                                      quillController.document
                                                          .toDelta()
                                                          .toJson()) ??
                                                  "",
                                              campus: _campus,
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
                                                "Curricular Offer added successfully!",
                                              ),
                                            ),
                                          );
                                        },
                                      );
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