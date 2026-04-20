import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/auth/button_validation_widget.dart';
import 'package:movegui/widgets/auth/other_registration_widget.dart';
import 'package:movegui/widgets/auth/repeat_password_widget.dart';
import 'package:movegui/widgets/person/birthdate_picker.dart';
import 'package:movegui/widgets/person/gender_picker.dart';

class RegisterEmailPage extends StatefulWidget {
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final String? selectedGender;
  final Function(String) onTitleChange;

  const RegisterEmailPage({
    super.key,
    required this.onGenderChanged,
    this.onBirthDateChanged,
    this.selectedGender,
    required this.onTitleChange,
  });

  @override
  State<StatefulWidget> createState() => RegisterEmailPageState();
}

class RegisterEmailPageState extends State<RegisterEmailPage> {
  bool obscureText = true;
  late final TextEditingController
      _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    try {
      auth = FirebaseAuth.instance;
    } catch (e) {
              MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: AppLocalizations.of(context)!.error_firebase_initialisation.toString(), 
          fct: () {},
        );
     
    }
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
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
         await auth?.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
         // OtpVerificationScreen(verificationId:  _emailController.text, phoneNumber: '', );
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.success_registration_new_user,
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
                (context) => auth?.currentUser != null? ProfileScreen() : HomeScreen(onTitleChange: widget.onTitleChange),
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
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.input_hint_adress_email,
              prefixIcon: const Icon(IconlyLight.message),
            ),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            validator: (value) {
              return MyValidators.emailValidator(value);
            },
          ),

          const SizedBox(height: 8.0),
          RepeatPasswordWidget(
            passwordController: _passwordController,
            repeatPasswordController: _repeatPasswordController,
            passwordFocusNode: _passwordFocusNode,
            repeatPasswordFocusNode: _repeatPasswordFocusNode,
          ),

          const SizedBox(height: 18.0),
          ButtonValidationWidget(title: AppLocalizations.of(context)!.btn_register_label, onPress: _registerFCT),
          SizedBox(height: 16),
          OtherRegistrationWidget(),
        ],
      ),
    );
  }
}
