import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/screens/auth/forgot_password.dart';
import 'package:movegui/screens/auth/register_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/auth/google_btn.dart';
import 'package:movegui/widgets/subtitle_text.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({
    super.key,
    required this.onTitleChange,
    required this.navigatorKey,
  //  required this.observer,
  //  required this.homeCanPop,
  });

  final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;
 // final NavigatorObserver observer;
 // final ValueNotifier<bool> homeCanPop;

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

    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        await auth?.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "An account has be created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => HomeScreen(onTitleChange: widget.onTitleChange, navigatorKey: widget.navigatorKey,),
          ),
        );
      } catch (error) {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: () {},
        );
      } finally {
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
                            builder: (context) => ForgotPasswordScreen(),
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
                                (context) => Text(
                                  'hallo',
                                ), //RegisterScreenMovgui(onTitleChange: widget.onTitleChange, navigatorKey: widget.navigatorKey, homeCanPop: widget.homeCanPop, observer: widget.observer,)
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
