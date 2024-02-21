import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:pichunt/Screens/loginscreen.dart';

import 'homescreen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  static String id = 'LoginScreen';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 10000),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFFEB3B),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: RichText(
                      text: TextSpan(
                    text: 'Welcome to ',
                    style: GoogleFonts.poppins(
                      fontSize: 38,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'PicHunt',
                        style: GoogleFonts.poppins(
                          fontSize: 38,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: 320,
                  child: SvgPicture.asset(
                    'assets/Svg/onboard.svg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 1,
                right: 1,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width - 1.5,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'PicHunt is a platform where you can find the best images for your projects. You can also save your favorite images and share them with your friends.',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    NeuTextButton(
                      borderRadius: BorderRadius.circular(12),
                      buttonColor: Colors.yellow,
                      buttonHeight: 60,
                      buttonWidth: 290,
                      enableAnimation: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      text: Text(
                        "Get Started",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
