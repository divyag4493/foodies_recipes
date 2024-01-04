/*import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes_app/models/add_new_item_model.dart';
import 'package:food_recipes_app/models/user_model.dart';
import 'package:food_recipes_app/nav_drawer_files/all_recipe_here.dart';*/
import 'package:food_recipes_app/index.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  late FirebaseFirestore db;
  bool isVisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var mealsController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();
  var imageController = TextEditingController();
  var youtubeLinkController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisible = true;
    db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/org_bck.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: db.collection('recipes').get(),
          builder: (_, snapshot) {
            return SingleChildScrollView(
                child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, top: 65),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image(image: AssetImage('assets/images/login_transparant.png')),
                      Icon(
                        Icons.fastfood_rounded,
                        color: Colors.orange.shade900,
                        size: 100,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('ADD NEW RECIPE',
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 35,
                      top: MediaQuery.of(context).size.height * 0.22,
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
                            hintText: 'Enter recipe name',
                            label: Text('Recipe name',
                                style:
                                    TextStyle(color: Colors.orange.shade900)),
                            prefixIcon: Icon(
                              Icons.format_color_text,
                              color: Colors.orange.shade700,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.orange.shade900)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: mealsController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Colors.orange.shade900)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade800),
                            ),
                            hintText: 'Enter your recipe meals',
                            label: Text(
                              'Recipe meals',
                              style: TextStyle(color: Colors.orange.shade900),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.orange.shade900,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.orange.shade900)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Colors.orange.shade900)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade800),
                            ),
                            hintText: 'Enter your recipe price',
                            label: Text(
                              'Recipe price',
                              style: TextStyle(color: Colors.orange.shade900),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.orange.shade900,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.orange.shade900)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Colors.orange.shade900)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade800),
                            ),
                            hintText: 'Enter your recipe description',
                            label: Text(
                              'Recipe description',
                              style: TextStyle(color: Colors.orange.shade900),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.orange.shade900,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.orange.shade900)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: youtubeLinkController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Colors.orange.shade900)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade800),
                            ),
                            hintText: 'Enter your recipe youtube link',
                            label: Text(
                              'Youtube Recipe link',
                              style: TextStyle(color: Colors.orange.shade900),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.orange.shade900,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.orange.shade900)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    /*  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          *//*InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'imageGallary');
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.orange.shade900,
                              )),*//*

                        ],
                      ),*/
                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Colors.orange.shade900)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade800),
                            ),
                            hintText: 'Enter your image path',
                            label: Text(
                              'Image Path',
                              style: TextStyle(color: Colors.orange.shade900),
                            ),
                            prefixIcon: Icon(
                              Icons.image,
                              color: Colors.orange.shade900,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.orange.shade900)),
                      ),
                      SizedBox(height: 20,),

                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.orange.shade900,
                        child: IconButton(
                          onPressed: () {
                            var nameRecipe = nameController.text.toString();
                            var meal = mealsController.text.toString();
                            var price = priceController.text.toString();
                            var descRecipe = descController.text.toString();
                            var imagePath = imageController.text.toString();
                            var youtueLink =
                            youtubeLinkController.text.toString();
                            if (nameRecipe != '' &&
                                meal != '' &&
                                price != '' &&
                                descRecipe != '' &&
                                youtueLink != '' &&
                                imagePath != '') {
                              db
                                  .collection('recipes')
                                  .add(AddNewItemModel(
                                  itemName: nameRecipe,
                                  itemMeal: meal,
                                  itemPrice: price,
                                  itemDesc: descRecipe,
                                  itemImage: imagePath,
                                  itemLink: youtueLink)
                                  .toJson())
                                  .then((value) => {print(value)});
                              Navigator.pushNamed(context, 'allRecipes');
                              nameRecipe == '';
                              meal == '';
                              price == '';
                              descRecipe == '';
                              youtueLink == '';
                              imagePath == '';
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.add,
                              size: 28, color: Colors.white),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'allRecipes');
                          },
                          child: Text(
                            'All Recipe Here...',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'MulishBold',
                                color: Colors.orange.shade900),
                          ))
                    ],
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
