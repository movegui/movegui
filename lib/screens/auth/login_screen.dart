import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/platform_widget.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/auth/login_email_page.dart';
import 'package:movegui/widgets/auth/login_phone_page.dart';
import 'package:movegui/widgets/subtitle_text.dart';
import 'package:movegui/widgets/util/toogle_buttons.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AppbarTitleProvider>().setTitle(
        AppLocalizations.of(context)!.login_title,
      );
    });
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
        setState(() {});
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
              //  AppImage(heightScale: 0.10),
              SeparatorWidget(),
              PlatformWidget.isAndroid(context) ||
                      PlatformWidget.isIos(context) ||
                      PlatformWidget.isWeb(context)
                  ? ToggleButtonExample(onStateChanged: updateState)
                  : const SizedBox(),
              SizedBox(height: 6.0),
              currentLoginScreen == 0
                  ? LoginPhoneNumberPage()
                  : LoginEmailPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeskop() {
    return Center(
      child: Container(
        width: 700,
        height: 600,
        decoration: BoxDecoration(
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.backgroundColor,
                margin: EdgeInsets.only(left: 100, right: 100),
                child: Padding(
                  padding: const EdgeInsets.only(left: 90 , right: 80),
                  child: SubtitleTextWidget(
                    label: AppLocalizations.of(context)!.login_title,
                    fontSize: WidgetConstants.subTitleFontSize * 3,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SeparatorWidget(height: 30,),

              ToggleButtonExample(onStateChanged: updateState),

             SeparatorWidget(height: 20,),

              currentLoginScreen == 0 
                  ? LoginPhoneNumberPage()
                  : LoginEmailPage(),
            ],
          ),
        ),
      ),
    );

  }
}
