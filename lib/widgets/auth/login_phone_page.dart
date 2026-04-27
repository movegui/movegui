import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/providers/login_mod_provider.dart';
import 'package:movegui/screens/main/movegui_profile_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/auth/auth_link_widget.dart';
import 'package:movegui/widgets/auth/opt_screen.dart';
import 'package:movegui/widgets/auth/other_registration_widget.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/util/input_phone_widget.dart';
import 'package:provider/provider.dart';

class LoginPhoneNumberPage extends StatefulWidget {
  const LoginPhoneNumberPage({super.key});

  @override
  State<LoginPhoneNumberPage> createState() => LoginPhoneNumberPageState();
}

class LoginPhoneNumberPageState extends State<LoginPhoneNumberPage> {
  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneNumberFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;

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

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
    try {
      auth = FirebaseAuth.instance;
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle:
            AppLocalizations.of(
              context,
            )!.error_firebase_initialisation.toString(),
        fct: () {},
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _phoneNumberController.dispose();
      _phoneNumberFocusNode.dispose();
    }
    super.dispose();
  }

  String? verificationId;

  Future<void> _loginFct(BuildContext context, ButtonItem item) async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && item.enabled) {
      try {
        setState(() {
          isloading = true;
        });
        if (kIsWeb) {
          ConfirmationResult? confirmationResult = await auth
              ?.signInWithPhoneNumber(_phoneNumberController.text);

          final resultCode = await confirmationResult?.confirm('123456');
          if (resultCode?.user != null) {
            context.read<LoginModProvider>().setLoginMod(AppConstants.LOGIN_PHONE_MODE);
             Navigator.pushNamed(context, item.routeName!);
             /*
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MoveguiProfileScreen(loginMode: AppConstants.LOGIN_PHONE_MODE)),
            );
            */
          }
        } else {
          // 📱 MOBILE (ton code actuel)
          final confirmationResult = await auth?.verifyPhoneNumber(
            phoneNumber: _phoneNumberController.text,
            verificationCompleted: (PhoneAuthCredential credential) async {
              await auth?.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              print("Error: ${e.message}");
            },
            codeSent: (String verId, int? resendToken) {
              setState(() {
                verificationId = verId;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => OTPScreen(
                        verificationId: verId,
                        confirmationResult: null,
                      ),
                ),
              );
            },
            codeAutoRetrievalTimeout: (String verId) {
              verificationId = verId;
            },
          );
        }
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputPhoneWidget(
                  phoneController: _phoneNumberController,
                  phoneFocusNode: _phoneNumberFocusNode,
                  nextFocusNode: _phoneNumberFocusNode,
                ),
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 0.5),
                AuthLinkWidget(),
             //   SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 0.5),
                  Padding(
                  padding: const EdgeInsets.all(WidgetConstants.sepWidget),
                  child: ValidationButton(
                    fn: _loginFct,
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.label_login,
                      AppLocalizations.of(context)!.tooltip_sign_in,
                      true,
                      routeName: RouteContants.PROFILE_ROUTE,
                    ),
                    icon: IconlyLight.send,
                  ),
                ),
                OtherRegistrationWidget(),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
