import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_app/models/user_model.dart';


class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  bool isVisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/org_bck.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(image: AssetImage('assets/images/login_transparant.png')),
                    Icon(
                      Icons.supervised_user_circle_outlined,
                      color: Colors.orange.shade900,
                      size: 50,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Create new account',
                            textStyle: TextStyle(
                              color: Colors.orange.shade900,
                              fontSize: 30,
                              fontFamily: 'MulishBold',
                              fontWeight: FontWeight.bold,
                            ),
                            speed: Duration(milliseconds: 100))
                      ],
                      totalRepeatCount: 5,
                    ),
                    /* Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.orange.shade500,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.3,
                    right: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.orange.shade900)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.yellow.shade800)),
                          hintText: 'Enter your name',
                          label: Text('Your name',
                              style: TextStyle(color: Colors.orange.shade900)),
                          prefixIcon: Icon(
                            Icons.format_color_text,
                            color: Colors.orange.shade700,
                          ),
                          hintStyle: TextStyle(color: Colors.orange.shade900)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.orange.shade900)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800),
                          ),
                          hintText: 'Enter your email address',
                          label: Text(
                            'Email address',
                            style: TextStyle(color: Colors.orange.shade900),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.orange.shade900,
                          ),
                          hintStyle: TextStyle(color: Colors.orange.shade900)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: isVisible,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.orange.shade900)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.yellow.shade800),
                          ),
                          hintText: 'Enter your password',
                          label: Text('Your password',
                              style: TextStyle(color: Colors.orange.shade900)),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.orange.shade900,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Colors.orange.shade900,
                              onPressed: () {
                                setState(
                                      () {
                                    isVisible = !isVisible;
                                  },
                                );
                              }),
                          hintStyle: TextStyle(color: Colors.orange.shade900)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.orange.shade900,
                              fontSize: 25,
                              fontFamily: 'MulishBold',
                              fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.orange.shade900,
                          child: IconButton(
                            onPressed: () async {
                              if (emailController.text.toString() != '' &&
                                  passwordController.text.toString() != ''&& nameController.text.toString() != '') {
                                var auth = FirebaseAuth.instance;
                                var name = nameController.text.toString();
                                var email = emailController.text.toString();
                                var pass = passwordController.text.toString();
                                try {
                                  var cred =
                                  await auth.createUserWithEmailAndPassword(
                                      email:email,
                                      password: pass);

                                  var db = FirebaseFirestore.instance;
                                  db.collection('users').doc(cred.user!.uid).set(UserModel(
                                      email: email,
                                      name: name,
                                      id:cred.user!.uid
                                  ).toJson());

                                  print('User added.. ${cred.user!.uid}');
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  print('Error: ${e.code}');
                                }
                              }
                            },
                            icon: Icon(Icons.arrow_forward,
                                size: 28, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontFamily: 'MulishBold',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.facebook,
                            color: Colors.orange.shade900,
                            size: 30,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.insert_link,
                            size: 30,
                            color: Colors.orange.shade900,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.mobile_friendly,
                            size: 30,
                            color: Colors.orange.shade900,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
