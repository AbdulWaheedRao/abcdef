import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_project/view/loginscreen.dart';
import 'package:flutter_application_project/view/profile.dart';

import 'dashboadscreen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});
  static const pageName = "/CreateScreen";

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globlekey = GlobalKey<FormState>();
  GlobalKey<FormState> globlekey1 = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    clientHeight =
        screenHeight - kToolbarHeight - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white38,
        appBar: AppBar(
          title: const Text('CreateAccount'),
        ),
        body: Column(children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const AutoSizeText(
                        'Create Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const AutoSizeText(
                          'Enter your Email and Password\n for sign up.Already have account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      SizedBox(
                        width: screenWidth * 0.8,
                        height: clientHeight * 0.1,
                        child: Form(
                            key: globlekey,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: 'Enter the Address',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: 'Address'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the adress';
                                } else if (value.isValiedAlpha()) {
                                  return null;
                                } else {
                                  return 'invalid';
                                }
                              },
                            )),
                      ),
                      SizedBox(
                        width: screenWidth * 0.8,
                        height: clientHeight * 0.1,
                        child: Form(
                            key: globlekey1,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Enter the Password',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: 'Password'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the password';
                                } else {}
                              },
                            )),
                      ),
                      SizedBox(
                          width: screenWidth * 0.5,
                          height: clientHeight * 0.07,
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  Navigator.of(context)
                                      .pushNamed(LoginScreen.pageName);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => const LoginScreen(),
                                  // ));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'The password provided is too weak.'),
                                    ));
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'The account already exists for that email.'),
                                    ));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(e.toString()),
                                  ));
                                }
                                globlekey.currentState!.validate();
                                globlekey1.currentState!.validate();
                              },
                              child: const Center(child: Text('SIGN UP')))),
                      const AutoSizeText(
                        'By Signing up you agree to our Terms\n Condition and privacy policy',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )
                    ]),
              )),
        ]),
      ),
    );
  }
}

extension validatedDigit on String {
  bool isValiedAlpha() {
    var length = this.length ?? 0;
    if (length != 0) {
      for (var i = 0; i < length; i++) {
        var code = this.codeUnits[i] ?? 0;
        //this is ASCII code for Alpha(capital & small letter)
        if (!(code >= 65 && code <= 90 || code >= 97 && code <= 122)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
