/*import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/homepage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';*/
import 'package:food_recipes_app/index.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/login_with_otp.dart';

class LoginWithOTP extends StatefulWidget {
  const LoginWithOTP({Key? key}) : super(key: key);

  @override
  State<LoginWithOTP> createState() => _LoginWithOTPState();
}

class _LoginWithOTPState extends State<LoginWithOTP> {
  var numController = TextEditingController();
  FocusNode focusNode = FocusNode();
  var firebaseAuth = FirebaseAuth.instance;
  var mverificationId = '';
  var otpNo1 = TextEditingController();
  var otpNo2 = TextEditingController();
  var otpNo3 = TextEditingController();
  var otpNo4 = TextEditingController();
  var otpNo5 = TextEditingController();
  var otpNo6 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/org_bck.jpg'),
              fit: BoxFit.fill)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              /*Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Phone Authentication',
                      textStyle: TextStyle(
                        color: Colors.orange.shade900,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: Duration(milliseconds: 100))
                ],
                totalRepeatCount: 5,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: IntlPhoneField(
                  controller: numController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    /*label: Text(
                      'Phone Number',
                      style: TextStyle(color: Colors.orange.shade900),
                    ),*/
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.orange.shade900)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.yellow.shade800)),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialCountryCode: 'IN',
                  cursorColor: Colors.orange,
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    firebaseAuth.verifyPhoneNumber(
                      phoneNumber: '+91${numController.text.toString()}',
                      verificationCompleted: (PhoneAuthCredential credential) {
                        firebaseAuth
                            .signInWithCredential(credential)
                            .then((value) {
                          print('Logged in : ${value.user!.uid}');
                          print('+91${numController.text.toString()}');
                        });
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print('VerificationFailed : ${e.message}');
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        mverificationId = verificationId;
                        print('CodeSent : ${mverificationId}');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                        color: Colors.orange.shade900,
                        fontFamily: 'MulishBold',
                        fontSize: 16),
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 58,
                    width: 54,
                    child: TextField(
                      controller: otpNo1,
                      autofocus: true,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      cursorColor: Colors.indigo,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '0',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.orange.shade900)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 54,
                    child: TextField(
                      controller: otpNo2,
                      autofocus: true,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      cursorColor: Colors.indigo,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '0',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.orange.shade900)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 54,
                    child: TextField(
                      controller: otpNo3,
                      autofocus: false,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      cursorColor: Colors.indigo,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '0',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.orange.shade900)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 54,
                    child: TextField(
                      controller: otpNo4,
                      autofocus: false,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      cursorColor: Colors.indigo,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '0',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.orange.shade900)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 54,
                    child: TextField(
                      controller: otpNo5,
                      autofocus: false,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      cursorColor: Colors.indigo,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '0',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.orange.shade900)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 54,
                    child: TextField(
                      controller: otpNo6,
                      autofocus: false,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      cursorColor: Colors.indigo,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '0',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.orange.shade900)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (otpNo1.text != '' &&
                        otpNo2.text != '' &&
                        otpNo3.text != '' &&
                        otpNo4.text != '' &&
                        otpNo5.text != '' &&
                        otpNo6.text != '') {
                      var otp =
                          '${otpNo1.text.toString()}${otpNo2.text.toString()}${otpNo3.text.toString()}${otpNo4.text.toString()}${otpNo5.text.toString()}${otpNo6.text.toString()}';
                      print('OTP: ${otp}');

                      var cred = PhoneAuthProvider.credential(
                          verificationId: mverificationId, smsCode: otp);
                      firebaseAuth.signInWithCredential(cred).then((value) {
                        print('Logged in : ${value.user!.uid}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.orange.shade900,
                        fontFamily: 'MulishBold',
                        fontSize: 18),),
                  ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
