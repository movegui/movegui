import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/auth/auth_link_widget.dart';
import 'package:movegui/widgets/auth/other_registration_widget.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/util/input_email_widget.dart';
import 'package:movegui/widgets/util/password_widget.dart';

class LoginEmailPage extends ConsumerStatefulWidget {
  const LoginEmailPage({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginEmailPageState();
  }



class LoginEmailPageState extends ConsumerState<LoginEmailPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late UserService userService;


  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;

  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
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
    userService = getIt<UserService>();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }


Future<void> _loginFct(BuildContext context, ButtonItem item) async {
  final isValid = _formkey.currentState!.validate();
  FocusScope.of(context).unfocus();

  if (!isValid || !item.enabled) return;

  final l10n = AppLocalizations.of(context)!;

  if (mounted) {
    setState(() {
      isloading = true;
    });
  }

  try {
    final userCredential = await auth!.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

   

    if (userCredential.user == null) {
      if (!mounted) return;

      Fluttertoast.showToast(
        msg: l10n.error_login_message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
      if(!mounted) return;
     await userService.checkLoginState(l10n.error_login_user_not_found);
    
    final currentUser = await userService.getByEmail(auth!.currentUser?.email! ?? '');
    if(currentUser == null) {
      if (!mounted) return;
      print('User not found in database, signing out...');
       await userService.signOut();
      Fluttertoast.showToast(
        msg: l10n.error_login_message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

/*
    await userService.initializeUserWithEmail(
      auth!.currentUser!.email!,
    ) as UserModel?;
    */

    if (!mounted) return;
    ref.read(userProviderState).setUser(currentUser);

    Fluttertoast.showToast(
      msg: l10n.success_login_message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green, // success besser grün :)
      textColor: Colors.white,
      fontSize: 16.0,
    );

    context.go(item.routeName!);
  } on FirebaseAuthException catch (e) {
    if (!mounted) return;

    MyAppFunctions.showErrorOrWarningDialog(
      context: context,
      subtitle: e.message ?? l10n.exception_login_message,
      fct: () {},
    );
  } finally {
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }
}

/*
  Future<void> _loginFct(BuildContext context, ButtonItem item) async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && item.enabled) {
      try {
        setState(() {
          isloading = true;
        });

        final userCredential = await auth?.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential?.user != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
             final currentUser =
                  await userService.initializeUserWithEmail(
                        auth!.currentUser!.email!,
                      )
                      as UserModel?;
              ref.read(userProviderState).setUser(currentUser!);
            });
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.success_login_message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          context.go(item.routeName!);

        } else {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.error_login_message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
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
  */

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
                InputEmailWidget(
                  nextFocusNode: _passwordFocusNode,
                  emailController: _emailController,
                  emailFocusNode: _emailFocusNode,
                  fontSize:
                      Responsive.isDesktop(context)
                          ? WidgetConstants.subTitleFontSize
                          : 16,
                  textColor: AppColors.backgroundColor,
                  fontweight: FontWeight.bold,
                ),
                PasswordWidget(
                  passwordController: _passwordController,
                  passwordFocusNode: _passwordFocusNode,
                  obscureText: obscureText,
                  onPressObscur: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  fontSize:
                      Responsive.isDesktop(context)
                          ? WidgetConstants.subTitleFontSize
                          : 16,
                  textColor: AppColors.backgroundColor,
                  fontweight: FontWeight.bold,
                ),
                Responsive.isDesktop(context)
                    ? SeparatorWidget(height: 20)
                    : SizedBox(),
                AuthLinkWidget(),
                Responsive.isDesktop(context)
                    ? SeparatorWidget(height: 20)
                    : SizedBox(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValidationButton(
                    fn: _loginFct,
                    buttonItem: ButtonItem(
                  title:     AppLocalizations.of(context)!.label_login,
                   tooltipText:    AppLocalizations.of(context)!.tooltip_sign_in,
                    enabled:   true,
                      routeName: RouteConstants.PROFILE_ROUTE,
                    ),
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
