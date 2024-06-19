import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/images.dart';
import '../../widgets/animate.dart';
import '../home.dart';
import 'auth_forgotpswd.dart';
import 'auth_signup.dart';


enum FormData {
  Email,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = Colors.grey;
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Stack(children: [
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
          top: 170,
          left: 0,
          right: 0,
          bottom: 0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Container(
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
                    ],
                  ),
                ),
                Container(
                  // width: 400,
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Log into your account",
                          style: TextStyle(
                            fontFamily: 'Abel',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Username",
                          style: TextStyle(
                            fontFamily: 'Abel',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 1,
                        child: Container(
                         width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: emailController,
                            onTap: () {
                              setState(() {
                                selected = FormData.Email;
                              });
                            },
                            decoration: InputDecoration(contentPadding: EdgeInsets.only(top: 15,bottom: 17),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              ),
                            
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontFamily: 'Abel',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 1,
                        child: Container(
                         width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: passwordController,
                            onTap: () {
                              setState(() {
                                selected = FormData.password;
                              });
                            },
                            decoration: InputDecoration( contentPadding: EdgeInsets.only(top: 15,bottom: 17),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_open_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: ispasswordev
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                onPressed: () => setState(
                                    () => ispasswordev = !ispasswordev),
                              ),
                           
                            ),
                            obscureText: ispasswordev,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                ),
               
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height*0.85,
          left: 0,
          right:0,
        //  bottom: 300,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeAnimation(
                delay: 1,
                child: GestureDetector(
                  onTap: (() {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ForgotPassword();
                    }));
                  }),
                  child: Text("Forgot Username or Password",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 0.5,
                      )),
                ),
              ),
              // const SizedBox(height: 10),
              FadeAnimation(
                delay: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      // if (_output.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                      // }
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
              ),

              const SizedBox(
                height: 10,
              ),

              FadeAnimation(
                delay: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SignUpScreen();
                        }));
                      },
                      child: Text("Sign up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.5,
                              fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
