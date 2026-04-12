import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/auth/login_email_page.dart';
import 'package:movegui/widgets/auth/login_phone_page.dart';
import 'package:movegui/widgets/menu/menu.dart';

import 'package:movegui/widgets/util/toogle_buttons.dart';
import 'package:movegui/widgets/web/menu_bar_web.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onTitleChange,
    required this.navigatorKey,
  });
  final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;

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
     //   appBar: Responsive.isDesktop(context) ? MenuBarWeb() : null,
        drawer:
            Responsive.isDesktop(context)
                ? MenuBarWeb()
                : MoveGuiMenu(navigatorKey: widget.navigatorKey),
        body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
          resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget buildMobil() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child:
       SingleChildScrollView(
         physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            AppImage(),
            ToggleButtonExample(onStateChanged: updateState),
            currentLoginScreen == 0
                ? LoginPhoneNumberPage()
                : LoginEmailPage(
                  onTitleChange: widget.onTitleChange,
                  navigatorKey: widget.navigatorKey,
                  //   observer: widget.observer,
                  //   homeCanPop: widget.barCanPop,
                ),
          ],
        ),
      ),
    );
  }

  Widget buildDeskop() {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
          color: AppColors.textColor, // background color
          border: Border.all(
            color: AppColors.backgroundColor, // border color
            width: 10,
          ),
          borderRadius: BorderRadius.circular(15), // optional rounded corners
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // center content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
          children: [
            ToggleButtonExample(onStateChanged: updateState),
            currentLoginScreen == 0
                ? LoginPhoneNumberPage()
                : LoginEmailPage(
                  onTitleChange: widget.onTitleChange,
                  navigatorKey: widget.navigatorKey,
                ),
          ],
        ),
      ),
    );
  }
}
