import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';

class LoginPhoneNumberPage extends StatefulWidget {
  const LoginPhoneNumberPage({super.key});

  @override
  State<LoginPhoneNumberPage> createState() => LoginPhoneNumberPageState();
}

class LoginPhoneNumberPageState extends State<LoginPhoneNumberPage> {
  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneNumberFocusNode;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    // Focus Nodes
    _phoneNumberFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _phoneNumberController.dispose();
      // Focus Nodes
      _phoneNumberFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    //   final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
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
          /*
                const AppNameTextWidget(
                  fontSize: 40,
                ),
                */
          //  AppImage(),

          /*
                const Align(
                    alignment: Alignment.centerLeft,
                    child: TitlesTextWidget(label: "Welcome back!")),
                const SizedBox(
                  height: 16,
                ),
                */
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "00224 68 214 ",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.phoneNumberValidator(value);
                  },
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