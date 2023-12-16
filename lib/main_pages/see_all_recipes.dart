import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipes_app/main_pages/homescreen.dart';
import 'package:food_recipes_app/utility/constant.dart';
import 'package:food_recipes_app/utility/all_list.dart';
import 'package:food_recipes_app/main_pages/detail_recipe_page.dart';


class SeeAllRecipes extends StatefulWidget {
  const SeeAllRecipes({Key? key}) : super(key: key);

  @override
  State<SeeAllRecipes> createState() => _SeeAllRecipesState();
}

class _SeeAllRecipesState extends State<SeeAllRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen(),
                    ),
                  ),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.0),
                        color: kOrangeColor,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/back-arrow.svg',
                        height: 15.0,
                        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),

                      ),
                    ),
                  ),
                  Text(
                    'All Recommended Recipes',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'MulishBold',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('See All'),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'MulishBold',
                        color: kOrangeColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26.0,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: recommendedList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailRecipePage(
                              index,
                              recommendedList[index]['name'],
                              recommendedList[index]['image'],
                              recommendedList[index]['recipe'],
                              recommendedList[index]['youtubeLink'],
                              recommendedList[index]['price'],
                              HomeScreen.tag = false),
                        ),
                      );
                    },
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
                      child: Row(
                        children: [
                          Hero(
                            tag: 'recommen$index',
                            child: Image.asset(
                              recommendedList[index]['image'],
                              height: 180.0,
                              width: 110.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recommendedList[index]['title'],
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'MulishBold',
                                      color: kBlueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Container(
                                    width: 170.0,
                                    child: Text(
                                      recommendedList[index]['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'MulishBold',
                                        color: kDarkColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(
                                            5,
                                                (index) => Icon(
                                              Icons.star,
                                              color: kOrangeColor,
                                              size: 18.0,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '120 Calories',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'Mulish',
                                          color: kOrangeColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.grey,
                                            size: 16.0,
                                          ),
                                          SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            '10 mins',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Mulish',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 16.0,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/food-tray.svg',
                                            height: 14.0,
                                            //  color: Colors.grey,
                                            colorFilter: ColorFilter.mode(
                                                Colors.grey,
                                                BlendMode.srcIn),
                                          ),
                                          SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            '1 Serving',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Mulish',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                height: 30.0,
                                width: 36.0,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
