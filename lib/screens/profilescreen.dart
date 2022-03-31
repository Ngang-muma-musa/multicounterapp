import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase_auth/manageuserdata.dart';
import '../providers/providersfile.dart';
import 'loginscreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: fetchdata(Provider.of<SessionProvider>(context).uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcome ' + data!['username']),
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    });
                  },
                  child: const Text("Logout"),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 19,
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Text(
                    data['basenumber'].toString(),
                    style: const TextStyle(fontSize: 50),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: () {
                          int incrementedNumber = data['basenumber'] + 1;
                          updatedate(
                              Provider.of<SessionProvider>(context,
                                      listen: false)
                                  .uid,
                              incrementedNumber);
                        },
                        child: const Text(
                          "+",
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: () {
                          int incrementedNumber = data['basenumber'] - 1;
                          updatedate(
                              Provider.of<SessionProvider>(context,
                                      listen: false)
                                  .uid,
                              incrementedNumber);
                        },
                        child: const Text(
                          "-",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
