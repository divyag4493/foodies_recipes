/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipes_app/nav_drawer_files/add_items.dart';
import 'package:food_recipes_app/nav_drawer_files/all_recipe_here.dart';
import 'package:food_recipes_app/nav_drawer_files/image_gallary.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/forgot_password.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/homepage.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/login_with_otp.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/my_login.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/signup_screen.dart';
import 'package:food_recipes_app/splash_screen.dart';
import 'package:food_recipes_app/utility/constant.dart';
import 'package:food_recipes_app/main_pages/homescreen.dart';
import 'package:food_recipes_app/firebase_options.dart';*/
import 'package:food_recipes_app/index.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Mulish'),
      initialRoute: 'splashScreen',
      routes: {
        'mainScreen': (context) => HomeScreen(),
        'signup': (context) => MySignUp(),
        'forgotpassword': (context) => ForgorPassword(),
        'notepage': (context) => HomePage(),
        //'userpage': (context) => UserPage(),
        'login_with_otp': (context) => LoginWithOTP(),
        'login': (context) => MyLogin(),
        'addnewitem': (context) => AddNewItem(),
        'allRecipes': (context) => AllRecipeHere(),
        'imageGallary': (context) => ImagePage(),
        'splashScreen': (context) => SplashScreen(),
      },
    );
  }
}
