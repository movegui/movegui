import 'package:flutter/material.dart';
import 'package:movegui/consts/validator.dart';

class PersonalBaseInfoWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController prenomController;
  final TextEditingController addressController;
  final FocusNode nameFocus;
  final FocusNode prenomFocus;
  final FocusNode addressFocus;

  const PersonalBaseInfoWidget({
    super.key,
    required this.nameController,
    required this.prenomController,
    required this.addressController,
    required this.nameFocus,
    required this.prenomFocus,
    required this.addressFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          focusNode: nameFocus,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: 'Nom',
            prefixIcon: Icon(Icons.person),
          ),
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(prenomFocus),
          validator: MyValidators.displayNamevalidator,
        ),
        TextFormField(
          controller: prenomController,
          focusNode: prenomFocus,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: 'Prénom',
            prefixIcon: Icon(Icons.person),
          ),
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(addressFocus),
          validator: MyValidators.displayNamevalidator,
        ),
        TextFormField(
          controller: addressController,
          focusNode: addressFocus,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: 'Adresse',
            prefixIcon: Icon(Icons.home),
          ),
          validator: MyValidators.displayNamevalidator,
        ),
      ],
    );
  }
}
