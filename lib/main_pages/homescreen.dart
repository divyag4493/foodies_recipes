import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes_app/main_pages/see_all_fresh_recipes.dart';
import 'package:food_recipes_app/main_pages/see_all_recipes.dart';
import 'package:food_recipes_app/utility/constant.dart';
import 'package:food_recipes_app/nav_drawer_files/nav_drawer.dart';
import '../utility/all_list.dart';
import '../main_pages/detail_recipe_page.dart';

class HomeScreen extends StatefulWidget {
  static late bool tag = false;

  String? id;

  HomeScreen({this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); //
  var searchController = TextEditingController();
  late AnimationController? heroController;
  bool isLikeRec = false;
  bool isLike = false;
  final int currUserId = 0;

  @override
  void initState() {
    super.initState();
    heroController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    heroController!.forward();
    heroController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/ylwbck.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawerEnableOpenDragGesture: false,
        key: _key,
        drawer: NavDrawer(),
        //backgroundColor: kLightColor,
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 55.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NavDrawer(),
                          ),
                        ),
                        child: InkWell(
                          onTap: () => _key.currentState!.openDrawer(),
                          child: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            color: Colors.orange.shade800,
                            height: 36.0,
                          ),
                        ),
                      ),
                      Container(
                          height: 60,
                          width: 100,
                          child: Image.asset(
                            'assets/images/recipe_logo.png',
                            fit: BoxFit.fill,
                          )),
                      /*GestureDetector(
                        onTap: () => print('Notification'),
                        child: SvgPicture.asset(
                          'assets/icons/notification.svg',
                          height: 32.0,
                        ),
                      ),*/
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/login.svg',
                              height: 26.0,
                              color: Colors.orange.shade800,
                            ),
                            Text('Login',style: TextStyle(
                              fontFamily: 'MulishBold',
                              color: Colors.orange.shade800
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Divya Gajera',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'MulishBold'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'What would you like to cook today?',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.black87,
                      fontFamily: 'MulishBold',
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: TextField(
                              controller: SearchController(),
                              cursorColor: kDarkColor,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey.shade500,
                                    size: 34.0,
                                  ),
                                  hintText: 'Search for recipes',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontFamily: 'MulishBold',
                                    fontSize: 18.0,
                                  ))),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      GestureDetector(
                        onTap: () => print('Filter'),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/settings.svg',
                              height: 28.0,
                              width: 60.0,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Fresh Recipes',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'MulishBold',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SeeAllFreshRecipes()),
                          ),
                        },
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
                    height: 16.0,
                  ),
                  Container(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: freshList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailRecipePage(
                                    index,
                                    freshList[index]['name'],
                                    freshList[index]['image'],
                                    freshList[index]['recipe'],
                                    freshList[index]['youtubeLink'],
                                    freshList[index]['price'],
                                    HomeScreen.tag = true),
                              ),
                            );
                          },
                          child: Container(
                              height: 250.0,
                              width: 200.0,
                              margin: EdgeInsets.only(right: 36.0),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(21.0),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: 16.0,
                                    left: 16.0,
                                    child: InkWell(
                                      onTap: () {
                                            isLike = !isLike;
                                      },
                                      child: Icon(!isLike?
                                        Icons.favorite_border:Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 16.0,
                                      right: -40.0,
                                      child: Hero(
                                        tag: 'fresh${index}',
                                        child: Image.asset(
                                          freshList[index]['image'],
                                          // 'assets/images/Chutney-vada-pav.png',
                                          scale: 3,
                                        ),
                                      )),
                                  Positioned(
                                    top: 110,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            freshList[index]['title'],
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'MulishBold',
                                              color: kBlueColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Container(
                                            width: 170.0,
                                            child: Text(
                                              freshList[index]['name'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'MulishBold',
                                                color: kDarkColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
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
                                            height: 6.0,
                                          ),
                                          Text(
                                            '120 Calories',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Mulish',
                                              color: kOrangeColor,
                                            ),
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
                                                    colorFilter:
                                                        ColorFilter.mode(
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
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'MulishBold',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SeeAllRecipes()),
                          ),
                        },
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
                    height: 6.0,
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
                              height: 130.0,
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
                                            height: 5.0,
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
                                                    colorFilter:
                                                        ColorFilter.mode(
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
                                            onPressed: () {
                                              isLikeRec = !isLikeRec;
                                              
                                              setState(() {

                                              });
                                            },
                                            icon: Icon(!isLikeRec?
                                            Icons.favorite_border:Icons.favorite,
                                              color: Colors.red,
                                            ))),
                                  )
                                ],
                              ),
                            ),
                          ))
                ],
              )),
        ),
      ),
    );
  }
}
