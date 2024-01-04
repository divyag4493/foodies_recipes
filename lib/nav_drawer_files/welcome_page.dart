/*import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/my_login.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/signup_screen.dart';*/
import 'dart:ui';
import 'package:food_recipes_app/index.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final backImage = 'assets/images/welcom3.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(backImage),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.9,
                margin: EdgeInsets.all(22.0),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 38.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 150.0),
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(21.0),
                            ),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade800,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.restaurant_menu,
                          color: Colors.grey.shade800,
                          size: 80.0,
                        ),
                        Text(
                          'Good Food Recipes',
                          style: TextStyle(
                            fontFamily: 'MulishBold',
                            fontSize: 30.0,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                              'Divine cooking is fit for the gods, heavenly, godly, '
                              'celestial, great, marvelous, delightful, lovely, '
                              'blissful. Nothing earthly.',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Mulish',
                                color: Colors.grey.shade800,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context,'signup');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade500,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21.0)),
                              ),
                              child: Text('Create Account',
                                  style: TextStyle(
                                    fontFamily: 'MulishBold',
                                    fontSize: 18,
                                    color: Colors.grey.shade800,
                                  ),
                                  textAlign: TextAlign.justify)),
                        ),
                        SizedBox(height: 30.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have account?',
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 13,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              WidgetSpan(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,'login');
                                      },
                                      child: Text(
                                        ' Log In',
                                        style: TextStyle(
                                          fontFamily: 'MulishBold',
                                          fontSize: 14,
                                          color: Colors.grey.shade800,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
