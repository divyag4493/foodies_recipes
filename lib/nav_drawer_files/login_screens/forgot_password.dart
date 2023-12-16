
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ForgorPassword extends StatefulWidget {
  const ForgorPassword({Key? key}) : super(key: key);

  @override
  State<ForgorPassword> createState() => _ForgorPasswordState();
}

class _ForgorPasswordState extends State<ForgorPassword> with SingleTickerProviderStateMixin{
  late AnimationController mController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mController = AnimationController(vsync: this, duration: Duration(seconds: 2));

    mController.addListener(() {
      setState(() { });
    });

    mController.forward();
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
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07, left: 90.0),
                child: Image(
                  image: AssetImage('assets/images/org_forgot.png'),
                  width: 250*mController.value,
                  height: 220*mController.value,

                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 35,
                      top: MediaQuery.of(context).size.height * 0.38,
                      right: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText('Forgot Your Password!',
                            textStyle: TextStyle(
                              color: Colors.yellow.shade900,
                              fontSize: 30,
                              fontFamily: 'MulishBold',
                              fontWeight: FontWeight.bold,
                            ),
                            speed: Duration(milliseconds: 100)
                        )

                      ],
                        totalRepeatCount: 5,
                      ),

                      /* Text(
                        'Forgot Your Password!',
                        style: TextStyle(
                          color: Colors.blue.shade500,
                          fontSize: 29,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                      SizedBox(
                        height: 15,
                      ),
                      Text('Enter your email account to reset password',
                        style: TextStyle(
                          color: Colors.orange.shade900,
                          fontSize: 15,
                        ),),
                      SizedBox(
                        height: 50,
                      ),
                      TextField(
                        onChanged: (textValue) {
                          print(textValue);
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                BorderSide(color: Colors.orange.shade900)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.yellow.shade900),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, 'login');
                          }, child: Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontFamily: 'MulishBold',
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),),


                          CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.orange.shade900,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward,
                                  size: 28, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
