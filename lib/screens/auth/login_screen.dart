
import 'package:flutter/material.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/auth/login_email_page.dart';
import 'package:movegui/widgets/auth/login_phone_page.dart';
import 'package:movegui/widgets/menu/menu.dart';

import 'package:movegui/widgets/util/toogle_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTitleChange, required this.navigatorKey, required this.observer, required this.barCanPop});
    final Function(String) onTitleChange;
    final GlobalKey<NavigatorState> navigatorKey;
    final NavigatorObserver observer;
    final ValueNotifier<bool> barCanPop;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;

  bool showFirst = true;

  @override
  void initState() {
    super.initState();
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
        drawer: MoveGuiMenu(),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppImage(),
                ToggleButtonExample(onStateChanged: updateState),
                currentLoginScreen == 0
                    ? LoginPhoneNumberPage()
                    : LoginEmailPage(onTitleChange: widget.onTitleChange, navigatorKey: widget.navigatorKey, observer: widget.observer, homeCanPop: widget.barCanPop,),            
              ],
            ),
          ),
        ),
      ),
    );
  }
}




