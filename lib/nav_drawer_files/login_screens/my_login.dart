import 'package:food_recipes_app/index.dart';
import 'package:rive/rive.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> with SingleTickerProviderStateMixin {
  var no1Cntroller = TextEditingController();
  var no2Cntroller = TextEditingController();
  bool isVisible = false;
  bool isChecked = false;

  late AnimationController mController;
  var riveLoginPath = 'assets/rive/bear_login.riv';
  StateMachineController? machineController;
  Artboard? mainArtboard;
  SMIBool? isChecking;
  SMIBool? isHandsUp;
  SMITrigger? trigSuccess;
  SMITrigger? trigFail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //isVisible = true;
    mController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    mController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        mController.reset();
      }
    });

    rootBundle.load(riveLoginPath).then((riveByteData) {
      var file = RiveFile.import(riveByteData);
      var artBoard = file.mainArtboard;
      machineController =
          StateMachineController.fromArtboard(artBoard, 'Login Machine');

      if (machineController != null) {
        artBoard.addController(machineController!);
        isChecking = machineController!.findSMI('isChecking');
        isHandsUp = machineController!.findSMI('isHandsUp');
        trigSuccess = machineController!.findSMI('trigSuccess');
        trigFail = machineController!.findSMI('trigFail');
        mainArtboard = artBoard;
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    mController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.yellow;
      }
      return Colors.orange.shade700;
    }

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bck.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, top: 60),
              child: Row(
                children: [
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Food Factory ',
                          textStyle: TextStyle(
                            color: Colors.red.shade800,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MulishBold',
                          ),
                          speed: Duration(milliseconds: 400))
                    ],
                    totalRepeatCount: 5,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.05,
                    right: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    mainArtboard == null
                        ? Container()
                        : Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (isChecking != null) {
                                      isChecking!.value = !isChecking!.value;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 24.0),
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.350,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.800,
                                        child: Rive(artboard: mainArtboard!)),
                                  )),
                            ],
                          ),
                    TextField(

                      controller: no1Cntroller,
                      onChanged: (textValue) {
                        isChecking!.value = true;
                        isHandsUp!.value = false;
                      },
                      onTapOutside: (event) {
                        isChecking!.value = false;
                      },
                      onSubmitted: (event) {
                        isChecking!.value = false;
                      },
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
                    TextField(
                      controller: no2Cntroller,
                      onChanged: (textValue) {
                        isChecking!.value = false;
                        isHandsUp!.value = false;
                      },
                      onTapOutside: (event) {
                        isHandsUp!.value = false;
                      },
                      onSubmitted: (event) {
                        isHandsUp!.value = false;
                      },
                      obscureText: !isVisible,
                      obscuringCharacter: '*',
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
                          hintText: 'Enter your password',
                          label: Text('Your password',
                              style: TextStyle(color: Colors.orange.shade700)),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.orange.shade700,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                                isHandsUp!.value = !isHandsUp!.value;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.orange.shade700,
                          ),
                          hintStyle: TextStyle(color: Colors.orange.shade700)),
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Checkbox(
                             side: BorderSide(color: Colors.orange.shade900),
                    checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {

                        setState(() {
                          isChecked = value!;
                        });
                      },

                          ),

                          Text("Remember Me",
                              style: TextStyle(
                                color: Colors.orange.shade800,
                                fontSize: 16,
                              ))
                        ]),






                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Or',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginWithOTP()));
                          },
                          child: Text(
                            'Signin with OTP',
                            style: TextStyle(
                                color: Colors.orange.shade900,
                                fontSize: 20,
                                fontFamily: 'MulishBold',
                                decoration: TextDecoration.underline
                                //fontWeight: FontWeight.bold
                                ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.orange.shade900,
                          child: IconButton(
                            onPressed: () async {
                              try {
                                if (no1Cntroller.text.toString() != '' &&
                                    no2Cntroller.text.toString() != '') {
                                  trigSuccess!.value = true;

                                  var auth = FirebaseAuth.instance;

                                  var cred =
                                      await auth.signInWithEmailAndPassword(
                                          email: no1Cntroller.text.toString(),
                                          password:
                                              no2Cntroller.text.toString());
                                  showDoneDialog(context);
                                  var pref = await SharedPreferences.getInstance();
                                  pref.setBool(SplashScreen.KEY_IS_LOGGED_IN, true);
                                  setState(() {
                                    mController.duration = Duration(seconds: 4);
                                    mController
                                        .forward()
                                        .whenComplete(() => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeScreen(
                                                      id: cred.user!.uid,
                                                    ))));


                                    print('User: ${cred.user!.uid}');
                                    no1Cntroller.clear();
                                    no2Cntroller.clear();
                                  });
                                  print('Success : User Logged in...');
                                }
                              } on FirebaseAuthException catch (e) {
                                trigFail!.value = true;
                                showWrongDialog(context);
                                setState(() {
                                  mController
                                      .forward()
                                      .whenComplete(() => no2Cntroller.clear());
                                  //no2Cntroller.clear();
                                });
                                print('Error: ${e.code}');
                              }
                            },
                            icon: Icon(Icons.arrow_forward,
                                size: 28, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontFamily: 'MulishBold',
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'forgotpassword');
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontFamily: 'MulishBold',
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Right Info
void showDoneDialog(context) => showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(41),
              color: Color(0x83065181),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/lotties_animation.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                  repeat: false,
                ),
                Text(
                  'Welcome to home screen',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(height: 100,),
              ],
            ),
          ),
        ));

// Wrong Info
void showWrongDialog(context) => showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: Color(0x67810606),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                Lottie.asset(
                  'assets/lottie/failed_login.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                  repeat: false,

                  //mController.forward();
                ),

                Text(
                  'Wrong Credentials !',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(height: 100,),
              ],
            ),
          ),
        ));

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
