import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/images.dart';
import '../../widgets/animate.dart';
import '../home.dart';
import 'auth_passwordreset.dart';

// ignore: must_be_immutable
class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  bool? isemail = false;

  PinCodeVerificationScreen({Key? key, this.phoneNumber, this.isemail})
      : super(key: key);

  @override
  State<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState
    extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Timer? _timer;
  bool _canResend = false;
  int _remainingSeconds = 20;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer!.cancel();
          _canResend = true;
        }
      });
    });
  }

  void handleResend() {
    if (_canResend) {
      startTimer();
      snackBar("OTP resent!");
      setState(() {
        _canResend = false;
        _remainingSeconds = 20;
      });
    }
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.24),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
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
                    padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        !widget.isemail!
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Verify your phone",
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text(""),
                        !widget.isemail!
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "number",
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Please check your email",
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        SizedBox(height: 10),
                        !widget.isemail!
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "We’ve sent an SMS with an activation",
                                  style: TextStyle(
                                    fontFamily: 'Abel',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: "We’ve sent a code to  ",
                                    children: [
                                      TextSpan(
                                        text: "${widget.phoneNumber}",
                                        style: TextStyle(
                                          fontFamily: 'Abel',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                        !widget.isemail!
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: "code to your phone ",
                                    children: [
                                      TextSpan(
                                        text: "${widget.phoneNumber}",
                                        style: TextStyle(
                                          fontFamily: 'Abel',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Text(""),
                        SizedBox(height: 20),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: PinCodeTextField(
                              appContext: context,
                              textStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.08,
                                fontWeight: FontWeight.normal,
                              ),
                              pastedTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: MediaQuery.of(context).size.width * 0.059,
                              ),
                              length: 5,
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 3) {
                                  return "Try Again";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                disabledColor: Colors.grey,
                                inactiveColor: Colors.white,
                                activeColor: Colors.yellow,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: MediaQuery.of(context).size.width * 0.145,
                                fieldWidth: MediaQuery.of(context).size.width * 0.13,
                                activeFillColor: Colors.transparent,
                                inactiveFillColor: Colors.transparent,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: const Duration(milliseconds: 300),
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                ),
                              ],
                              onCompleted: (v) {
                                debugPrint("Completed");
                              },
                              onChanged: (value) {
                                debugPrint(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            hasError ? "Wrong Code, please again" : "",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I didn’t receive a code ",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                handleResend();
                              },
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                  color: _canResend ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        FadeAnimation(
                          delay: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (currentText.length != 5 ||
                                    currentText != "12345") {
                                  errorController!.add(ErrorAnimationType.shake);
                                  setState(() => hasError = true);
                                } else {
                                  setState(() {
                                    hasError = false;
                                    snackBar("OTP Verified!!");
                                  });
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                      if (!widget.isemail!) {
                                        return HomeScreen();
                                      } else {
                                        return PasswordReset();
                                      }
                                    }),
                                  );
                                }
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
                                    'Verify',
                                    style:  GoogleFonts.getFont('Didact Gothic',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send code again    ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "00:$_remainingSeconds",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),  Positioned(
            top: 30,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
