import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      required File img}) async {
    final Map<String, dynamic> course = {
      "title": coursetitle,
      "description": courseDescription,
      "campus": campus,
      "time_added": DateTime.now(),
      "interested": 0
    };

    try {
      await Storage().uploadCampusImage(title: coursetitle, img: img);
    } on Exception catch (e) {
      // TODO
      // print(e);
    }
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
    _firebaseFirestore.collection("curricular_offerings").doc(id).delete().then(
      (value) {
        // print(id);
        Navigator.of(context).pop();
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
}

class Storage {
  final _firebaseStorageRef = FirebaseStorage.instance.ref();

  Future<void> uploadCampusImage(
      {required String title, required File img}) async {
    // print("bef");

    await _firebaseStorageRef.child("campuses/$title.png").putBlob(img);
    // print("af");
  }
}
