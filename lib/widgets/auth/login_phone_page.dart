import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/opt_args_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/auth/auth_link_widget.dart';
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
  late UserService userService;

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
    userService = getIt<UserService>();
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

          UserModel user = await userService.initializeUserWithPhone(
            _phoneNumberController.text,
          );
          OptArgsModel args = OptArgsModel(
            verificationId: confirmationResult!.verificationId,
            currentUser: user,
            confirmationResult: confirmationResult,
          );
          Navigator.pushNamed(context, item.routeName!, arguments: args);
        } else {
          userService.registerWithPhone(
            context,
            userService.initializeUserWithPhone(_phoneNumberController.text)
                as UserModel,
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
                  fontSize: Responsive.isDesktop(context) ? WidgetConstants.subTitleFontSize : 14
                ),
                Responsive.isDesktop(context) ? SeparatorWidget(height: 20,) : SizedBox(),
                AuthLinkWidget(),
                Responsive.isDesktop(context) ? SeparatorWidget(height: 20,) : SizedBox(),
                ValidationButton(
                  fn: _loginFct,
                  buttonItem: ButtonItem(
                    AppLocalizations.of(context)!.label_login,
                    AppLocalizations.of(context)!.tooltip_sign_in,
                    true,
                    routeName: RouteContants.OTP_SCREEN_ROUTE,
                  ),
                  icon: IconlyLight.send,
              
                ),
                Responsive.isDesktop(context) ? SeparatorWidget(height: 20,) : SizedBox(),
                OtherRegistrationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
