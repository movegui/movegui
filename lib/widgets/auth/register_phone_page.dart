import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/auth/other_registration_widget.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/util/input_phone_widget.dart';

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({super.key});

  @override
  State<RegisterPhonePage> createState() => RegisterPhonePageState();
}

class RegisterPhonePageState extends State<RegisterPhonePage> {
  FirebaseAuth? auth;

  late final TextEditingController _phoneNumberController;
  late final FocusNode _phoneNumberFocusNode;
  late UserService userService;
  late UserModel currentUser;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
    auth = FirebaseAuth.instance;
    userService = getIt<UserService>();
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

  Future<void> _registerFCT(BuildContext context, ButtonItem item) async {
    currentUser = await userService.initializeUserWithPhone(
      _phoneNumberController.text,
    );
    print(currentUser.toJson());
    await userService.registerWithPhone(context, currentUser);
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Column(
      children: [
        Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputPhoneWidget(
                phoneController: _phoneNumberController,
                phoneFocusNode: _phoneNumberFocusNode,
              ),
              Responsive.isDesktop(context)
                  ? SeparatorWidget(height: 20)
                  : SizedBox(),
              ValidationButton(
                fn: (BuildContext context, ButtonItem item) async {
                  ;
                  await _registerFCT(context, item);
                },
                buttonItem: ButtonItem(
                 title:  AppLocalizations.of(context)!.btn_register_label,
                tooltipText:  AppLocalizations.of(context)!.tooltip_registration,
                 enabled:  true,
                  routeName: RouteConstants.REGISTER_ROUTE,
                ),
              ),
              Responsive.isDesktop(context)
                  ? SeparatorWidget(height: 20)
                  : SizedBox(),
              OtherRegistrationWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
