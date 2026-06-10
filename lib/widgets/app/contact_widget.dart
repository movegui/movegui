import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/message_service.dart';
import 'package:movegui/widgets/error/message_widget.dart';

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContactScreen();
  }
}

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late final TextEditingController _vorNameController,
      _nameController,
      _emailController,
      _telefonController,
      _reclamationController;

  late final FocusNode _vorNameFocusNode,
      _nameFocusNode,
      _emailFocusNode,
      _telefonFocusNode,
      _reclamationFocusNode;

  late final _formKey;

  @override
  void initState() {
    _vorNameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _telefonController = TextEditingController();
    _reclamationController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _vorNameFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _telefonFocusNode = FocusNode();
    _reclamationFocusNode = FocusNode();

    super.initState();
  }

  Future<void> _envoyerReclamation() async {
    if (_formKey.currentState!.validate()) {
      final message = _reclamationController.text;
      final firstanme = _vorNameController.text;
      final lastname = _nameController.text;
      final phone = _telefonController.text;
      final email = _emailController.text;
      final subject = 'Contact $firstanme $lastname';
      try {
        HttpsCallableResult result = await sendMessage(
          firstanme,
          lastname,
          email,
          phone,
          subject,
          message,
        );
        print(result.data);
      } catch (e) {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_send_mail_title,
          AppLocalizations.of(context)!.error_send_mail_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.success_send_message_title,
              ),
              content: Text(
                AppLocalizations.of(context)!.success_send_message_message,
              ),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.btn_close_label),
                  onPressed: () =>  context.pop()  
                ),
              ],
            ),
      );
      _reclamationController.clear();
      _vorNameController.clear();
      _nameController.clear();
      _emailController.clear();
      _telefonController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _reclamationController.dispose();
    _vorNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _telefonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.form_contact_title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: Color(0xFF871A1C)),
              ),
            ),
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.input_hint_name,
                prefixIcon: const Icon(Icons.person),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_vorNameFocusNode);
              },
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _vorNameController,
              focusNode: _vorNameFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.input_hint_prenom,
                prefixIcon: Icon(Icons.person),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
            ),
            const SizedBox(height: 16.0),

            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.input_hint_adress_email,
                prefixIcon: Icon(IconlyLight.message),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_telefonFocusNode);
              },
              validator: (value) {
                return MyValidators.emailValidator(value);
              },
            ),

            const SizedBox(height: 16.0),
            TextFormField(
              controller: _telefonController,
              focusNode: _telefonFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.company_label_phone,
                prefixIcon: Icon(Icons.phone),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_reclamationFocusNode);
              },
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
            ),
            const SizedBox(height: 16.0),

            SizedBox(height: 16),
            TextFormField(
              controller: _reclamationController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.input_hint_message,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.error_input_hint_message;
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.send),
                label: Text(
                  AppLocalizations.of(context)!.btn_send_label,
                  style: TextStyle(color: AppColors.textColor, fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  iconColor: AppColors.textColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _envoyerReclamation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
