import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/images.dart';
import 'auth/auth_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   @override
    void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return AuthHome();
      }));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfff3e0bf),
        body: Stack(
      children: [
        Center(
          child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    Images.logo,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
        // Center(
        //   child: Column(
        //    mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         width: MediaQuery.of(context).size.width * 0.6,
        //         height: MediaQuery.of(context).size.width * 0.6,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.white,
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(20.0),
        //           child: Image.asset(
        //             Images.logo,
        //             fit: BoxFit.contain,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 10),
        //     //  Container(
        //     //     width: MediaQuery.of(context).size.width * 0.17,
        //     //     height: MediaQuery.of(context).size.width * 0.17,
        //     //     decoration: BoxDecoration(
        //     //       shape: BoxShape.circle,
        //     //       color: Colors.white,
        //     //     ),
              
        //     //   )
        //     ],
        //   ),
        // ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            Images.splash,
            width: MediaQuery.of(context).size.width * 0.8,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    ));
  }
}