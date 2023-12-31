import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static String KEY_IS_LOGGED_IN = 'isLogin';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async{

      SharedPreferences pref = await SharedPreferences.getInstance();
      var check = pref.getBool(SplashScreen.KEY_IS_LOGGED_IN) ?? false;
      if(check){
        Navigator.pushNamed(context, 'mainScreen');
      } else{
        Navigator.pushNamed(context, 'login');
      }
print(check);
      setState(() {

      });


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          color: Color(0XFFFFCF08),
            child: Image.network('https://img.freepik.com/premium-vector/recipe-food-fork-spoon-logo-template-vector-icon-illustration_7688-4338.jpg')),
      ),
    );
  }
}
