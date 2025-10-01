import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/screens/auth/forgot_password.dart';
import 'package:movegui/screens/auth/register_screen.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/auth/google_btn.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/subtitle_text.dart';
import 'package:movegui/widgets/util/toogle_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  late Widget _scaffoldBody;
  int currentLoginScreen = 0;

  bool showFirst = true;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(title: 'Home'),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande'),
      DeveliveryScreen(title: 'Livraison'),
    ];
    controller = PageController();
    _scaffoldBody = LoginEmailPage();
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          print("je suis la dans ");
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          titleTextStyle: TextStyle(
            color: AppColors.textColor, // Set the title color
            fontSize: 20,
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                color: AppColors.textColor,
                tooltip: 'Navigation menu',
                onPressed: () {
                  //  _showMenu(context);
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: AppColors.backgroundColor, // Customize color
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: AppColors.textColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              color: AppColors.textColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(title: 'Notification'),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: AppColors.textColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
        drawer: MoveGuiMenu(),

        //     body: _scaffoldBody,
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppImage(),
                ToggleButtonExample(onStateChanged: updateState),
                currentLoginScreen == 0
                    ? LoginPhoneNumberPage()
                    : LoginEmailPage(),
                //  LoginPhoneNumberPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});
  @override
  State<StatefulWidget> createState() => LoginEmailPageState();
}

class LoginEmailPageState extends State<LoginEmailPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isHoveringForgetText = false;
  bool _isHoveringRegisterText = false;
  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      // Focus Nodes
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
     final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    
    if(isValid){
      try{
        setState(() {
          isloading = true;
        });
       await auth?.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
       Fluttertoast.showToast(
        msg: "An account has be created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => HomeScreen(title: 'Movegui')));
      }catch(error){
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: (){});
      }finally{
        isloading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      /*
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            */
      child: Column(
        children: [
          //  AppImage(),
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email address",
                    prefixIcon: Icon(IconlyLight.message),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.emailValidator(value);
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: obscureText,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    hintText: "***********",
                    prefixIcon: const Icon(IconlyLight.lock),
                  ),
                  onFieldSubmitted: (value) async {
                    await _loginFct();
                  },
                  validator: (value) {
                    return MyValidators.passwordValidator(value);
                  },
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: MouseRegion(
                    onEnter:
                        (_) => setState(() => _isHoveringForgetText = true),
                    onExit:
                        (_) => setState(() => _isHoveringForgetText = false),
                    child: TextButton(
                      onPressed: () {
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ForgotPasswordScreen()
                          ),
                        );
                      },
                      child: SubtitleTextWidget(
                        label: "Mot de pass oublier?",
                        fontStyle: FontStyle.italic,
                        textDecoration: TextDecoration.underline,
                        color:
                            _isHoveringForgetText
                                ? AppColors.selectionColor
                                : AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(6.0),
                      backgroundColor: AppColors.backgroundColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    icon: const Icon(Icons.login, color: AppColors.textColor),
                    label: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      await _loginFct();
                    },
                  ),
                ),

                const SizedBox(height: 16.0),

                SubtitleTextWidget(label: "Or connect using".toUpperCase()),
                const SizedBox(height: 4.0),
                SizedBox(
                  //     height: kBottomNavigationBarHeight + 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(child: GoogleButton()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(6.0),
                            backgroundColor: AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            "Invite ?",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () async {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const SubtitleTextWidget(label: "Nouveau ?"),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: MouseRegion(
                    onEnter:
                        (_) => setState(() => _isHoveringRegisterText = true),
                    onExit:
                        (_) => setState(() => _isHoveringRegisterText = false),
                    child: TextButton(
                      child: SubtitleTextWidget(
                        label: "Enregistrement",
                        fontStyle: FontStyle.italic,
                        textDecoration: TextDecoration.underline,
                        color:
                            _isHoveringRegisterText
                                ? AppColors.selectionColor
                                : AppColors.backgroundColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => RegisterScreen()
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    /*
        ),
      ),
    );
    */
  }
}

class LoginPhoneNumberPage extends StatefulWidget {
  const LoginPhoneNumberPage({super.key});

  @override
  State<LoginPhoneNumberPage> createState() => LoginPhoneNumberPageState();
}

class LoginPhoneNumberPageState extends State<LoginPhoneNumberPage> {
  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneNumberFocusNode;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    // Focus Nodes
    _phoneNumberFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _phoneNumberController.dispose();
      // Focus Nodes
      _phoneNumberFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    //   final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      /*
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            */
      child: Column(
        children: [
          /*
                const AppNameTextWidget(
                  fontSize: 40,
                ),
                */
          //  AppImage(),

          /*
                const Align(
                    alignment: Alignment.centerLeft,
                    child: TitlesTextWidget(label: "Welcome back!")),
                const SizedBox(
                  height: 16,
                ),
                */
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "00224 68 214 ",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.phoneNumberValidator(value);
                  },
                ),
                const SizedBox(height: 16.0),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(6.0),
                      backgroundColor: AppColors.backgroundColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    icon: const Icon(Icons.login, color: AppColors.textColor),
                    label: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      await _loginFct();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    /*
        ),
      ),
    );
  */
  }
}
