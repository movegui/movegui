import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/auth/register_email_page.dart';
import 'package:movegui/widgets/auth/register_phone_page.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/util/toogle_buttons.dart';

class RegisterScreenMovgui extends StatefulWidget {
  const RegisterScreenMovgui({
    super.key,
    required this.onTitleChange,
    required this.navigatorKey,
  });
  final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;
  //   final ValueNotifier<bool> barCanPop;
  //   final NavigatorObserver observer;

  @override
  State<RegisterScreenMovgui> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreenMovgui> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;

  bool showFirst = true;
  XFile? _pickedImage;
  late String gender;
  late DateTime birthdate;

  @override
  void initState() {
    super.initState();
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          print("je suis la dans ");
        });
      },
      child: Scaffold(
        drawer: MoveGuiMenu(navigatorKey: widget.navigatorKey,),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RegisterPage(
                  onTitleChange: widget.onTitleChange,
                  navigatorKey: widget.navigatorKey,
                //  observer: widget.observer,
                //  barCanPop: widget.barCanPop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;
 // final NavigatorObserver observer;
 // final ValueNotifier<bool> barCanPop;

  const RegisterPage({
    super.key,
    required this.onTitleChange,
    required this.navigatorKey,
  //  required this.observer,
  //  required this.barCanPop,
  });
  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  int currentLoginScreen = 0;
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
      child: Column(
        children: [
          AppImage(),
          ToggleButtonExample(onStateChanged: updateState),
          SizedBox(height: 8),
          currentLoginScreen == 0
              ? RegisterPhonePage(onGenderChanged: (String? value) {})
              : RegisterEmailPage(
                onGenderChanged: (String? value) {},
                onTitleChange: widget.onTitleChange,
                navigatorKey: widget.navigatorKey,
            //    observer: widget.observer,
            //    homeCanPop: widget.barCanPop,
              ),
          //  LoginPhoneNumberPage(),
        ],
      ),
    );
  }
}
