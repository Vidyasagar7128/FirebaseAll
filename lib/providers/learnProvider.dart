import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class LearnProvider extends ChangeNotifier {
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
}
