import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_app/screens/profilescreen.dart';
import 'package:provider/provider.dart';

import '../firebase_auth/manageuserdata.dart';
import '../providers/providersfile.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// login functionality
class _RegisterScreenState extends State<RegisterScreen> {
  static Future<User?> registerUsingEmailPassword(
      {required String email,
      required String password,
      required String userName,
      required int baseName,
      required BuildContext context}) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createuser(userName, email, 0);
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid.toString();
      Provider.of<SessionProvider>(context, listen: false)
          .setUid(uid.toString());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _usernameController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            padding: const EdgeInsets.only(top: 150),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const Text(
                      "Register To Continue",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "User Email",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                          hintText: "User Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "User Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Already have an account? : Click to Login",
                        style: TextStyle(color: Color(0xFF0069FE)),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RawMaterialButton(
                        fillColor: const Color(0xFF0069FE),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        onPressed: () async {
                          User? user = await registerUsingEmailPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              userName: _usernameController.text,
                              baseName: 0,
                              context: context);
                          // if (user != null) {

                          // }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
