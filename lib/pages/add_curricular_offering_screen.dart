import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class AddCurricularOfferingScreen extends StatelessWidget {
  const AddCurricularOfferingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final TextEditingController _title = TextEditingController();
    final TextEditingController _description = TextEditingController();
    final TextEditingController _link = TextEditingController();

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
                            margin: EdgeInsets.all(0),
                            color: PSU_BLUE,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Add Admission News",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: PSU_YELLOW,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: edgeInsets,
                            child: TextFormField(
                              controller: _title,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Title must not be empty!"
                                  : value.length < 5
                                      ? "Title must be at least 5 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                // hintText: "email@example.com",
                                border: OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.title_rounded,
                                        color: Colors.black.withOpacity(0.2)),
                                    SizedBox(
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
                              minLines: 3,
                              maxLines: 888,
                              controller: _description,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Description must not be empty!"
                                  : value.length < 5
                                      ? "Description must be at least 5 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                // hintText: "email@example.com",
                                border: OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.description_rounded,
                                        color: Colors.black.withOpacity(0.2)),
                                    SizedBox(
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
                              controller: _link,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Link must not be empty!"
                                  : value.length < 5
                                      ? "Link must be at least 5 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                labelText: 'Link',
                                // hintText: "email@example.com",
                                border: OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.link,
                                        color: Colors.black.withOpacity(0.2)),
                                    SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: edgeInsets,
                            child: ClickWidget(
                              onTap: () {},
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      print(_title.text +
                                          _description.text +
                                          _link.text);
                                      _key.currentState!.validate();
                                      Store()
                                          .uploadAdmission(
                                              title: _title.text,
                                              description: _description.text,
                                              link: _link.text)
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
                                                    child: Text("Okay"))
                                              ],
                                              content: Text(
                                                "Admission news added successfully!",
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
                          SizedBox(
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