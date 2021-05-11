import 'package:auth/models/demoUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<DemoUser>> getUser() {
    return _firebaseFirestore.collection('demo').snapshots().map(
        (QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => DemoUser(
                name: documentSnapshot.data()['name'],
                age: documentSnapshot.data()['age'],
                demoUserClass: documentSnapshot.data()['class'],
                contact: documentSnapshot.data()['contact']))
            .toList());
  }

  createUser(name, age, demoUserClass, contact) {
    print(name);
    CollectionReference user = _firebaseFirestore.collection('demo');
    user.add({
      'name': name,
      'age': age,
      'class': demoUserClass,
      'contact': contact,
    });
  }
}
