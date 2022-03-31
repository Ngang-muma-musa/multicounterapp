import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_app/screens/profilescreen.dart';
import 'package:interview_app/screens/registrationscreen.dart';
import 'package:provider/provider.dart';

import '../providers/providersfile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// login functionality
class _LoginScreenState extends State<LoginScreen> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
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
                      "Log In To Continue",
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
                            builder: (context) => const RegisterScreen()));
                      },
                      child: const Text(
                        "Dont have an account? : Click to register",
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
                          User? user = await loginUsingEmailPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                          print(user);
                          if (user != null) {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            String uid = auth.currentUser!.uid.toString();
                            Provider.of<SessionProvider>(context, listen: false)
                                .setUid(uid.toString());
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()));
                          }
                        },
                        child: const Text(
                          "Login",
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
