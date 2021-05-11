// import 'package:auth/models/bakery.dart';
// import 'package:auth/models/demoUser.dart';
// import 'package:auth/models/googleUser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthApi {
//   final String uid;
//   AuthApi({this.uid});
//   final doc = FirebaseFirestore.instance;
//   final CollectionReference user =
//       FirebaseFirestore.instance.collection('users');
//   final CollectionReference cakes =
//       FirebaseFirestore.instance.collectionGroup('cakes');

//   Future setData(authUser) async {
//     return await user.doc(uid).set({
//       'name': authUser.displayName,
//       'email': authUser.email,
//       'image': authUser.photoURL,
//     });
//   }

//   Future getdata() async {
//     QuerySnapshot data =
//         await FirebaseFirestore.instance.collection('users').get();
//     print(data.docs.runtimeType);
//     return data.docs;
//   }

//   Future getDatas() async {
//     var myData = await FirebaseFirestore.instance.collection('users').get();

//     return myData.docs;
//   }

//   Stream<List<Bakery>> funData() {
//     return cakes.snapshots().map(
//         (query) => query.docs.map((e) => Bakery.fromJson(e.data())).toList());
//   }

//   Future<List<GoogleUser>> funTo() async {
//     var data = await FirebaseFirestore.instance.collection('users').get();

//     return data.docs.map((e) => GoogleUser.fromJson(e.data())).toList();
//   }

//   Future getDemoUser() async {
//     var data = await doc
//         .collection('demo')
//         .get()
//         .then((value) => value.docs.map((e) => e.data()).toList());
//     print(' Data ========== ${data.length}');
//     return data;
//   }
// }
