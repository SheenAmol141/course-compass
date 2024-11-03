import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_compass/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser {
    // print(_firebaseAuth.currentUser);
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // print(_firebaseAuth.currentUser);
  }

  Future<void> createUserWithEmailPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    // print(_firebaseAuth.currentUser);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // print(_firebaseAuth.currentUser);
  }
}

class Store {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> uploadAdmission(
      {required String title,
      required String description,
      required String link}) async {
    final Map<String, dynamic> admissionNews = {
      "title": title,
      "description": description,
      "link": link,
      "time_added": DateTime.now()
    };
    _firebaseFirestore.collection("admission_news").add(admissionNews);
  }

  Future<void> uploadCourse(
      {required String coursetitle,
      required String courseDescription,
      required String campus,
      required File img,
      required String coursecode}) async {
    final Map<String, dynamic> course = {
      "title": coursetitle,
      "description": courseDescription,
      "code": coursecode,
      "campus": campus,
      "time_added": DateTime.now(),
      "interested": 0,
      "matched": 0
    };

    await Storage().uploadCampusImage(title: coursetitle, img: img);

    _firebaseFirestore.collection("curricular_offerings").add(course);
  }

  Future<void> addInterested({
    required String courseTitle,
    required current,
  }) async {
    final Map<String, dynamic> course = {"interested": current + 1};

    _firebaseFirestore
        .collection("curricular_offerings")
        .doc(courseTitle)
        .update(course);
  }

  void deleteAdmission(String id, BuildContext context) {
    _firebaseFirestore.collection("admission_news").doc(id).delete().then(
      (value) {
        Navigator.of(context).pop();
      },
    );
  }

  void deleteCourse(String id, BuildContext context) {
    String title;
    firestore.collection("curricular_offerings").doc(id).get().then(
      (value) {
        title = value["title"];
        print("get: $title");
        Storage()
            .deleteCampusImage(title: title)
            .then(
              (value) {},
            )
            .then(
          (value) {
            _firebaseFirestore
                .collection("curricular_offerings")
                .doc(id)
                .delete()
                .then(
              (value) {
                // print(id);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  get courses {
    return _firebaseFirestore.collection("curricular_offerings").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot["title"]}');
        }
      },
      // onError: (e) => print("Error completing: $e"),
    );
  }

  Future<bool> checkCurriculumOffering(String code, String campus) async {
    final firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('curricular_offerings')
          .where('code', isEqualTo: code)
          .where('campus', isEqualTo: campus)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String title = documentSnapshot.get('title');
        print('Title: $title');
        return true;
      } else {
        print('No document found with the specified criteria.');
        return false;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return false;
    }
  }

  Future<void> incrementInterestedCount(String code) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('curricular_offerings')
          .where('code', isEqualTo: code)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({
          'interested': FieldValue.increment(1),
        });
      }
    } catch (e) {
      print('Error incrementing interested count: $e');
    }
  }

  Future<void> incrementMatchedCount(String code) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('curricular_offerings')
          .where('code', isEqualTo: code)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({
          'matched': FieldValue.increment(1),
        });
      }
    } catch (e) {
      print('Error incrementing interested count: $e');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getOfferingScreen(
      String code, String campus) async {
    print(code + "-" + campus);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('curricular_offerings')
        .where('code', isEqualTo: code)
        .where('campus', isEqualTo: getCampusReversed(campus))
        .get();

    return querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;
    // Or handle the case where no document is found
  }
  // void getReadMore(String code) async {
  //   print("start");
  //   firestore
  //       .collection("curricular_offerings")
  //       .where("code", isEqualTo: code)
  //       .where("campus", isEqualTo: "lingayen").get()
  //       .
  //       snapshots()

  //       .toList()
  //       .then(
  //     (value) {
  //       List<DocumentSnapshot> docs = [];
  //       if (value.isNotEmpty) {
  //         docs.add(value[0] as DocumentSnapshot<Object?>);
  //         print(docs[0]);
  //       }
  //     },
  //   );
  // }
  String getCampusReversed(String id) {
    String camp = "lingayen";
    switch (id) {
      case "LINGAYEN CAMPUS":
        camp = "lingayen";
      case "ALAMINOS CITY CAMPUS":
        camp = "alaminos";
      case "ASINGAN CAMPUS":
        camp = "asingan";
      case "BAYAMBANG CAMPUS":
        camp = "bayambang";
      case "BINMALEY CAMPUS":
        camp = "binmaley";
      case "INFANTA CAMPUS":
        camp = "infanta";
      case "SAN CARLOS CAMPUS":
        camp = "san-carlos";
      case "STA MARIA CAMPUS":
        camp = "santa-maria";
      case "URDANETA CITY CAMPUS":
        camp = "urdaneta";
      case "SCHOOL OF ADVANCED STUDIES":
        camp = "SCHOOL OF ADVANCED STUDIES";
      case "OPEN UNIVERSITY SYSTEMS":
        camp = "OPEN UNIVERSITY SYSTEMS";
      case "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)":
        camp =
            "EXPANDED TERTIARY EDUCATION EQUIVALENCY AND ACCREDITATION PROGRAM (ETEEAP)";
      default:
    }
    print(camp);
    return camp;
  }
}

class Storage {
  final _firebaseStorageRef = FirebaseStorage.instance.ref();

  Future<void> uploadCampusImage(
      {required String title, required File img}) async {
    // print("bef");

    await _firebaseStorageRef.child("campuses/$title.png").putBlob(img);
    print("upload: campuses/$title.png");

    // print("af");
  }

  Future<void> deleteCampusImage({required String title}) async {
    // print("bef");
    final desertRef = _firebaseStorageRef.child("campuses/$title.png");
    print("delete: campuses/$title.png");

    await desertRef.delete().onError(
      (error, stackTrace) {
        print(error);
      },
    );
    // print("af");
  }
}
