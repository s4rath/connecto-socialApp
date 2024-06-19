import 'package:flutter/material.dart';
import '../../utils/images.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth_login.dart';
import 'auth_signup.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.backgroundImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xfff3e0bf),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width *
                      0.2), 
              Text(
                "Welcome to",
                style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                    // lineHeight: 40.78,
                    // textAlign: TextAlign.center,
                    ),
              ),
             
              Text(
                "Connecto",
                style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: MediaQuery.of(context).size.width * 0.11,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              
              Text(
                "by Social Company Ltd",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.056,
                    color: Colors.white),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.2),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow[400],
                    ),
                    child: Center(
                        child: Text(
                      'Login',
                      style: GoogleFonts.getFont('Didact Gothic',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[800],
                    ),
                    child: Center(
                        child: Text(
                      'Sign Up',
                      style: GoogleFonts.getFont('Didact Gothic',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
