import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/platform_widget.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/auth/login_email_page.dart';
import 'package:movegui/widgets/auth/login_phone_page.dart';

import 'package:movegui/widgets/util/toogle_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTitleChange});
  final Function(String) onTitleChange;

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(AppLocalizations.of(context)!.login_title);
    });
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
        });
      },
      child: Scaffold(
        body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget buildMobil() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppImage(heightScale: 0.10,),
             PlatformWidget.isAndroid(context) || PlatformWidget.isIos(context) || PlatformWidget.isWeb(context)? ToggleButtonExample(onStateChanged: updateState): const SizedBox(),
             SizedBox(height: 6.0),
                 currentLoginScreen == 0 ? LoginPhoneNumberPage(onTitleChange: widget.onTitleChange)
                  : LoginEmailPage(onTitleChange: widget.onTitleChange),
            ],
          ),
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
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleButtonExample(onStateChanged: updateState),
            currentLoginScreen == 0 
                ? LoginPhoneNumberPage(onTitleChange: widget.onTitleChange)
                : LoginEmailPage(onTitleChange: widget.onTitleChange),
          ],
        ),
      ),
    );
  }
}
