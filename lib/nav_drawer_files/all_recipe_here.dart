import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes_app/main_pages/detail_recipe_page.dart';
import 'package:food_recipes_app/main_pages/homescreen.dart';
import 'package:food_recipes_app/models/add_new_item_model.dart';
import 'package:food_recipes_app/utility/all_list.dart';
import 'package:food_recipes_app/utility/constant.dart';

class AllRecipeHere extends StatefulWidget {
  const AllRecipeHere({super.key});

  @override
  State<AllRecipeHere> createState() => _AllRecipeHereState();
}

class _AllRecipeHereState extends State<AllRecipeHere> {
  late FirebaseFirestore db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        //backgroundColor: kLightColor,
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'addnewitem');
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: kOrangeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0))),
            height: 55,
            child: Center(
              child: Text(
                'Back',
                style: TextStyle(
                  fontFamily: 'MulishBold',
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: db.collection('recipes').get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      var model = AddNewItemModel.fromJson(
                          snapshot.data!.docs[index].data());
                      return SingleChildScrollView(
                        //physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          height: 120.0,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 16.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(21.0),
                          ),
                          child: ListTile(
                            title: Text(
                              '${model.itemName}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'MulishBold',
                                  color: Colors.orange.shade900),
                            ),
                            subtitle: SingleChildScrollView(
                              child: Text(
                                '${model.itemDesc}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'MulishBold',
                                    color: Colors.grey.shade500),
                                softWrap: true,
                              ),
                            ),
                            leading: Container(
                                height: 80,
                                width: 80,
                                child: Image.network('${model.itemImage}',fit:BoxFit.cover)),
                            trailing: Text('${model.itemPrice}'),
                            // tileColor: Colors.yellow.shade500,
                          ),
                        ),
                      );
                    });
              }
              return Container(
                child: Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'MulishBold',
                        color: Colors.orange.shade900),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
