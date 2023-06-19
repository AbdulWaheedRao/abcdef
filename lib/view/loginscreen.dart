import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'createscreen.dart';
import 'dashboadscreen.dart';
import 'forgotpassword.dart';
import 'profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globlekey = GlobalKey<FormState>();
  GlobalKey<FormState> globlekey1 = GlobalKey<FormState>();

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
        body: Center(
          child: Column(children: [
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/flutter.png',
                              width: screenWidth * 0.1,
                              height: screenHeight * 0.1,
                            ),
                            SizedBox(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.1,
                              child: const FittedBox(
                                  child: Text(
                                'Hotel',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.15,
                          child: Form(
                              key: globlekey,
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter the Address',
                                    labelText: 'Address'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the adress';
                                  } else if (value.isValidAlpha()) {
                                    return null;
                                  } else {
                                    return 'invalid';
                                  }
                                },
                              )),
                        ),
                        SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.15,
                          child: Form(
                              key: globlekey1,
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                    hintText: 'Enter the Password',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelText: 'Password'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter the password';
                                  } else {}
                                },
                              )),
                        ),
                        SizedBox(
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.07,
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            )),
                            child: const FittedBox(
                                child: Text(
                              'forgot password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.07,
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen(),
                                  ));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text('No user found for that email.'),
                                    ));
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Wrong password provided for that user.'),
                                    ));
                                  }
                                }

                                globlekey.currentState!.validate();
                                globlekey1.currentState!.validate();
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      ]),
                )),
            Expanded(
                flex: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.07,
                          child: FittedBox(
                              child: InkWell(
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateScreen(),
                                      )),
                                  child:
                                      const Text('New user?Create Account')))),
                    ]))
          ]),
        ),
      ),
    );
  }
}

extension validateDigit on String {
  bool isValidAlpha() {
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
