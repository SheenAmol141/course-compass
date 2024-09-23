import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path_provider/path_provider.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser {
    print(_firebaseAuth.currentUser);
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print(_firebaseAuth.currentUser);
  }

  Future<void> createUserWithEmailPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(_firebaseAuth.currentUser);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print(_firebaseAuth.currentUser);
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
      {required String course_title,
      required String course_description,
      required String campus,
      required File img}) async {
    final Map<String, dynamic> course = {
      "title": course_title,
      "description": course_description,
      "campus": campus,
      "time_added": DateTime.now()
    };

    try {
      await Storage().uploadCampusImage(title: course_title, img: img);
    } on Exception catch (e) {
      print(e);
      // TODO
    }
    _firebaseFirestore.collection("curricular_offerings").add(course);
  }
}

class Storage {
  final _firebaseStorageRef = FirebaseStorage.instance.ref();

  Future<void> uploadCampusImage(
      {required String title, required File img}) async {
    print("bef");

    await _firebaseStorageRef.child("campuses/$title.png").putBlob(img);
    print("af");
  }
}
