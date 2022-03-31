import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createuser(String userName, String email, int baseNumber) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({
    'uid': uid,
    'username': userName,
    'email': email,
    'basenumber': baseNumber
  });
  return;
}

Stream<DocumentSnapshot<Map<String, dynamic>>> fetchdata(String uID) {
  Stream<DocumentSnapshot<Map<String, dynamic>>> users =
      FirebaseFirestore.instance.collection('Users').doc(uID).snapshots();
  return users;
}

void updatedate(String uID, int basenumber) {
  FirebaseFirestore.instance
      .collection("Users")
      .doc(uID)
      .update({"basenumber": basenumber}).then(
          (value) => print("Data updated Succesfully"));
}
