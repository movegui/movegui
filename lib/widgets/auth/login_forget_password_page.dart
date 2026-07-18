import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/subtitle_text.dart';
import 'package:movegui/widgets/title_text.dart';

class LoginForgetPasswordPage extends StatefulWidget {

  const LoginForgetPasswordPage({super.key,});
  @override
  State<StatefulWidget> createState() => LoginForgetPasswordPageState();
}

class LoginForgetPasswordPageState extends State<LoginForgetPasswordPage> {
  late final TextEditingController _emailController;

  late final FocusNode _emailFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;

  bool isloading = false;
  FirebaseAuth? auth;

  Future<void> _resetFct(BuildContext context, ButtonItem item) async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && item.enabled) {
      try {
        setState(() {
          isloading = true;
        });

        await auth?.sendPasswordResetEmail(email: _emailController.text.trim());

        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.success_login_reset_password,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        context.push(item.routeName!);
      } on FirebaseAuthException {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: AppLocalizations.of(context)!.exception_login_message,
          fct: () {},
        );
      } finally {
        isloading = false;
      }
    }
  }

  /*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppbarTitleProvider>().setTitle(
        AppLocalizations.of(context)!.forget_password_title,
      );
    });
  }
  */

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
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
                TitlesTextWidget(
                  label: AppLocalizations.of(context)!.forget_password_title,
                  fontSize: WidgetConstants.subTitleFontSize * 1.5,
                ),
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 2),
                SubtitleTextWidget(
                  label:
                      AppLocalizations.of(context)!.login_forget_password_txt,
                  fontSize: WidgetConstants.subTitleFontSize,
                ),
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 2),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.input_hint_adress_email,
                    prefixIcon: const Icon(IconlyLight.message),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.emailValidator(value);
                  },
                ),
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 2),

                SeparatorWidget(height: WidgetConstants.sepWidgetHeight),

                ValidationButton(
                  fn: _resetFct,

                  buttonItem: ButtonItem(
                   title:  AppLocalizations.of(context)!.label_login,
                   tooltipText:   AppLocalizations.of(context)!.tooltip_sign_in,
                   enabled:  true,
                    routeName: RouteConstants.LOGIN_ROUTE,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
