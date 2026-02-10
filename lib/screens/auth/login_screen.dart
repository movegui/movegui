
import 'package:flutter/material.dart';
import 'package:movegui/screens/main/command_screen.dart';
import 'package:movegui/screens/main/develivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/reservation_screen.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/auth/login_email_page.dart';
import 'package:movegui/widgets/auth/login_phone_page.dart';
import 'package:movegui/widgets/menu/menu.dart';

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
        appBar: MoveguiAppBar(title: 'Login', itemCount: 0,),
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




