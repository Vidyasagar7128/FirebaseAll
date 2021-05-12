import 'dart:io';
import 'package:auth/models/authUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class LearnProvider extends ChangeNotifier {
  final String uid;
  LearnProvider({this.uid});
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  File file;
  Stream getData() {
    return FirebaseFirestore.instance.collection('demo').snapshots();
  }

  deleteData(id) {
    FirebaseFirestore.instance.collection('demo').doc(id).delete();
  }

  Future<String> upload(String file) async {
    String downloadUrl;
    final uuid = Uuid();
    final filePath = '/images/${uuid.v4()}';
    final storage = FirebaseStorage.instance.ref(filePath);
    final uploadTask = await storage.putString(file);
    if (uploadTask.state == TaskState.success) {
      downloadUrl =
          await FirebaseStorage.instance.ref(filePath).getDownloadURL();
    }
    print(downloadUrl);
    return downloadUrl;
  }

  AuthUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return AuthUser(
          uid: user.uid,
          name: user.displayName,
          email: user.email,
          image: user.photoURL);
    }
  }

  Future<AuthUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(authResult.user);
    createUserInFirestore(authResult.user);
    return _userFromFirebase(authResult.user);
  }

  //store user in firestore
  createUserInFirestore(user) async {
    final uid = user.uid;
    CollectionReference authorizeUser =
        await FirebaseFirestore.instance.collection('demo');
    authorizeUser.doc(uid).set({
      'email': user.email,
      'name': user.displayName,
      'image': user.photoURL,
    });
  }

  void logOut() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
