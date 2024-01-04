/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_recipes_app/main_pages/homescreen.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/my_login.dart';

import 'package:shared_preferences/shared_preferences.dart';*/
import 'index.dart';

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
       // Navigator.pushNamed(context, 'mainScreen');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else{
       // Navigator.pushNamed(context, 'login');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLogin()));
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
