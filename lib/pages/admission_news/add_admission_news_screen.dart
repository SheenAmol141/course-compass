import 'package:course_compass/auth.dart';
import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:course_compass/templates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAdmissionNewsScreen extends StatefulWidget {
  AddAdmissionNewsScreen({super.key});

  @override
  State<AddAdmissionNewsScreen> createState() => _AddAdmissionNewsScreenState();
}

class _AddAdmissionNewsScreenState extends State<AddAdmissionNewsScreen> {
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    // bool uploading = false;
    final key = GlobalKey<FormState>();
    final TextEditingController title = TextEditingController();
    final TextEditingController description = TextEditingController();
    final TextEditingController link = TextEditingController();

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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            margin: const EdgeInsets.all(0),
                            color: PSU_BLUE,
                            child: MediaQuery.of(context).size.width < 1050
                                ? Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Add Admission News",
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
                          Padding(
                            padding: edgeInsets,
                            child: TextFormField(
                              minLines: 3,
                              maxLines: 888,
                              controller: description,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Description must not be empty!"
                                  : value.length < 5
                                      ? "Description must be at least 5 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                // hintText: "email@example.com",
                                border: const OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.description_rounded,
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
                              controller: link,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? "Link must not be empty!"
                                  : value.length < 5
                                      ? "Link must be at least 5 characters long!"
                                      : null,
                              decoration: InputDecoration(
                                labelText: 'Link',
                                // hintText: "email@example.com",
                                border: const OutlineInputBorder(),

                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.link,
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
                            child: ClickWidget(
                              onTap: () {},
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (key.currentState!.validate()) {
                                      setState(() {
                                        uploading = true;
                                      });
                                      // print(title.text +
                                      //     description.text +
                                      //     link.text);
                                      key.currentState!.validate();
                                      Store()
                                          .uploadAdmission(
                                              title: title.text,
                                              description: description.text,
                                              link: link.text)
                                          .then(
                                        (value) {
                                          setState(() {
                                            uploading = false;
                                          });
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
                                      uploading
                                          ? CircularProgressIndicator(
                                              color: PSU_YELLOW,
                                            )
                                          : Text(
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