
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
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

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
    auth = FirebaseAuth.instance;
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

  Future<void> _registerFCT() async {
    FocusScope.of(context).unfocus();
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

              Padding(
                padding: const EdgeInsets.all(WidgetConstants.sepWidget),
                child: ValidationButton(
                  fn: (BuildContext context, ButtonItem item) async {
                    _registerFCT();
                  },
                  buttonItem: ButtonItem(
                    AppLocalizations.of(context)!.btn_register_label,
                    AppLocalizations.of(context)!.tooltip_registration,
                    true,
                    routeName: RouteContants.REGISTER_ROUTE,
                  ),
                ),
              ),
              OtherRegistrationWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
