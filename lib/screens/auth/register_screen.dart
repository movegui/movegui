import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/screens/auth/otp_verification_scxreen.dart';
import 'package:movegui/screens/main/command_screen.dart';
import 'package:movegui/screens/main/develivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/reservation_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/auth/image_picker_widget.dart';
import 'package:movegui/widgets/auth/register_email_page.dart';
import 'package:movegui/widgets/auth/register_phone_page.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/util/toogle_buttons.dart';


class RegisterScreenMovgui extends StatefulWidget {
  static const routName = "register";
  const RegisterScreenMovgui({super.key, required this.onTitleChange, required this.navigatorKey, required this.barCanPop, required this.observer});
    final Function(String) onTitleChange;
     final GlobalKey<NavigatorState> navigatorKey;
      final ValueNotifier<bool> barCanPop;
      final NavigatorObserver observer;

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
  late String gender ;
  late DateTime birthdate;


  @override
  void initState() {
    super.initState();
    /*
    screens = [
      HomeScreen(title: 'Home'),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande'),
      DeveliveryScreen(title: 'Livraison'),
    ];
    controller = PageController();
    */
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
     //   appBar: MoveguiAppBar(title: 'Enregistrement', itemCount: 0, navigatorKey: widget.navigatorKey, currentScreen: -1, homeCanPop: widget.homeCanPop,),
        drawer: MoveGuiMenu(),

        //     body: _scaffoldBody,
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // AppImage(),
                /*
                SizedBox(
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  child: PickImageWidget(
                    pickedImage: _pickedImage,
                    function: () async {
                      //    await localImagePicker();
                    },
                  ),
                ),
                */
                RegisterPage(onTitleChange: widget.onTitleChange, navigatorKey: widget.navigatorKey,observer: widget.observer, barCanPop: widget.barCanPop,),
                //  LoginPhoneNumberPage(),
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
      final NavigatorObserver observer;
      final ValueNotifier<bool> barCanPop;

  const RegisterPage({super.key, required this.onTitleChange, required this.navigatorKey, required this.observer, required this.barCanPop});
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
      child:  Column(
              children: [
                AppImage(),
                ToggleButtonExample(onStateChanged: updateState),
                SizedBox(height: 8,),
                currentLoginScreen == 0
                    ? RegisterPhonePage(onGenderChanged: (String? value) {  },)
                    : RegisterEmailPage(onGenderChanged: (String? value) {  }, onTitleChange: widget.onTitleChange, navigatorKey: widget.navigatorKey,observer: widget.observer, homeCanPop: widget.barCanPop,),
                //  LoginPhoneNumberPage(),
              ],
            ),
          );
    
       
  }

}
