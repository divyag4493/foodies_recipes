import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes_app/nav_drawer_files/welcome_page.dart';
import 'package:food_recipes_app/utility/constant.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Food Recipes',
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'MulishBold',
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.yellow.shade300,

                image: DecorationImage(
                  image: AssetImage('assets/images/menu_Indian_food.png'),
                  fit: BoxFit.contain,
                )),
          ),
          ListTile(
            leading: Icon(Icons.input, color: Colors.grey.shade900),
            title: Text(
              'Welcome',
              style: TextStyle(fontFamily: 'MulishBold'),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WelcomePage()),
              ),
            },
          ),
          ListTile(
            leading:
                Icon(Icons.verified_user_rounded, color: Colors.grey.shade900),
            title: Text(
              'Profile',
              style: TextStyle(fontFamily: 'MulishBold'),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.add_box, color: Colors.grey.shade900),
            title: Text(
              'Add New Item',
              style: TextStyle(fontFamily: 'MulishBold'),
            ),
            onTap: () => {Navigator.pushNamed(context, 'addnewitem')},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey.shade900),
            title: Text(
              'Settings',
              style: TextStyle(fontFamily: 'MulishBold'),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color, color: Colors.grey.shade900),
            title: Text(
              'Feedback',
              style: TextStyle(fontFamily: 'MulishBold'),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/logout.svg',
              width: 20,
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade900, BlendMode.srcIn),
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontFamily: 'MulishBold'),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
