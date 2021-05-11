// import 'package:auth/endpoints/authapi.dart';
// import 'package:auth/models/customer.dart';
// import 'package:auth/models/demoUser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class DemoService extends GetxController {
//   final doc = FirebaseFirestore.instance;
//   RxList user = RxList<DemoUser>();
//   List users = <DemoUser>[].obs;
//   get myUser => getDemoUser();
//   @override
//   void onInit() {
//     super.onInit();
//     //getMyUser();
//     getDemoUser();
//   }

//   Future<List<QueryDocumentSnapshot>> getUsers() async {
//     var data = await doc.collection('demo').get();
//     print(data.docs.map((e) => print('===== ${e.data()}')));
//     print(data.docs.map((e) => e.data().forEach((key, value) {
//           user.add(DemoUser());
//           print('From $user');
//         })));
//     print(user);
//     return data.docs;
//   }

//   Future<List<QueryDocumentSnapshot>> getUser() async {
//     var data = await doc.collection('demo').get();
//     print(data.docs.map((e) => print('===== ${e.data().toString()}')));
//     print(data.docs.map((e) => e.data().entries.forEach((e) {
//           print('${e.key} = ${e.value}');
//           //user.add(DemoUser(e.key, e.value));
//         })));
//     return data.docs;
//   }

//   Future getMyUser() async {
//     return await doc
//         .collection('demo')
//         .get()
//         .then((value) => users = value.docs.map((e) => e.data()).toList());
//   }

//   Future getDemoUser() async {
//     return await doc
//         .collection('demo')
//         .get()
//         .then((value) => print(value.docs.map((e) => e.data()).toList()));
//   }

//   // getGet() async {
//   //   var list = await AuthApi().getDemoUser();
//   //   print(' Data ========== ${list.runtimeType}');
//   // }
// }
