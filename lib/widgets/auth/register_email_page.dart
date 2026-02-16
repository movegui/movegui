import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/auth/button_validation_widget.dart';
import 'package:movegui/widgets/auth/other_registration_widget.dart';
import 'package:movegui/widgets/auth/repeat_password_widget.dart';
import 'package:movegui/widgets/person/birthdate_picker.dart';
import 'package:movegui/widgets/person/gender_picker.dart';
import 'package:movegui/widgets/person/personal_base_info_widget.dart';

class RegisterEmailPage extends StatefulWidget {
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final String? selectedGender;
  final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;
  final NavigatorObserver observer;
  final ValueNotifier<bool> homeCanPop;

  const RegisterEmailPage({
    super.key,
    required this.onGenderChanged,
    this.onBirthDateChanged,
    this.selectedGender,
    required this.onTitleChange,
    required this.navigatorKey,
    required this.observer,
    required this.homeCanPop,
  });

  @override
  State<StatefulWidget> createState() => RegisterEmailPageState();
}

class RegisterEmailPageState extends State<RegisterEmailPage> {
  bool obscureText = true;
  late final TextEditingController _nameController,
      _prenomController,
      _adressController,
      _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode _nameFocusNode,
      _prenomFocusNode,
      _adressFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _nameController = TextEditingController();
    _prenomController = TextEditingController();
    _adressController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _prenomFocusNode = FocusNode();
    _adressFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    try {
      auth = FirebaseAuth.instance;
    } catch (e) {
      print('FirebaseAuth initialization failed: $e');
    }
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      // Focus Nodes
      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _registerFCT() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        // await auth?.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
        //  OtpVerificationScreen(verificationId:  _emailController.text, );
        Fluttertoast.showToast(
          msg: "Votre Compte a été créer avec succes",
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
                (context) => HomeScreen(
                  onTitleChange: widget.onTitleChange,
                  //navigatorKey: widget.navigatorKey,
                 // observer: widget.observer, homeCanPop: widget.homeCanPop,
                ),
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
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GenderPicker(
                  onGenderChanged: (value) {
                    widget.onGenderChanged(value);
                  },
                  gender: widget.selectedGender,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: BirthdatePicker(
                  onBirthDateChanged: (value) {
                    widget.onBirthDateChanged?.call(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          PersonalBaseInfoWidget(
            nameController: _nameController,
            prenomController: _prenomController,
            addressController: _adressController,
            nameFocus: _nameFocusNode,
            prenomFocus: _prenomFocusNode,
            addressFocus: _adressFocusNode,
          ),

          const SizedBox(height: 8.0),
          RepeatPasswordWidget(
            passwordController: _passwordController,
            repeatPasswordController: _repeatPasswordController,
            passwordFocusNode: _passwordFocusNode,
            repeatPasswordFocusNode: _repeatPasswordFocusNode,
          ),

          const SizedBox(height: 18.0),
          ButtonValidationWidget(title: 'Enregistrer', onPress: _registerFCT),
          SizedBox(height: 16),
          OtherRegistrationWidget(),

          /*
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                backgroundColor: AppColors.backgroundColor,
                // backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              icon: const Icon(IconlyLight.addUser, color: AppColors.textColor, ),
              label: const Text(
                "Enregister",
                style: TextStyle(color: AppColors.textColor, fontSize: 28),
              ),
              onPressed: () async {
                  await _registerFCT();
              },
            ),
          ),
          */
        ],
      ),
    );
  }
}
