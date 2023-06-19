import 'package:flutter/material.dart';

import 'loginscreen.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgr.jpg'),
                  fit: BoxFit.fill)),
          child: Column(children: [
            Expanded(
                flex: 5,
                child: Container(
                  child: LayoutBuilder(
                    builder: (context, boxConstraint) => Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: boxConstraint.maxHeight * 0.4,
                            width: boxConstraint.maxWidth * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white54),
                            child: Image.asset('assets/images/pix.png'),
                          ),
                          SizedBox(
                            height: boxConstraint.maxHeight * 0.1,
                            child: const FittedBox(
                                child: Text(
                              'Hotel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ),
                          SizedBox(
                            height: boxConstraint.maxHeight * 0.07,
                            child: const FittedBox(
                                child: Text(
                              'Best hotel deals for your holiday',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          )
                        ]),
                  ),
                )),
            const Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: LayoutBuilder(
                  builder: (context, boxConstraint) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: boxConstraint.maxHeight * 0.2,
                          width: boxConstraint.maxWidth * 0.7,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen(),
                                    ));
                              },
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          height: boxConstraint.maxHeight * 0.4,
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            )),
                            child: const Text(
                              'Already have account?Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
