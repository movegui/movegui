import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/widgets/util/input_adress_widget.dart';
import 'package:movegui/widgets/util/input_name_widget.dart';

class PersonalBaseInfoWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController addressController;
  final FocusNode firstNameFocus;
  final FocusNode lastnameFocus;
  final FocusNode addressFocus;

  const PersonalBaseInfoWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.addressController,
    required this.firstNameFocus,
    required this.lastnameFocus,
    required this.addressFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputNameWidget(
          nameController: firstNameController,
          nameFocusNode: firstNameFocus,
          hinterText: AppLocalizations.of(context)!.input_hint_first_name,
          nextFocusNode: lastnameFocus,
        ),
        InputNameWidget(
          nameController: lastNameController,
          nameFocusNode: lastnameFocus,
          hinterText: AppLocalizations.of(context)!.input_hint_last_name,
          nextFocusNode: lastnameFocus,
        ),
        InputAdressWidget(
          adressController: addressController,
          adressFocusNode: addressFocus,
        ),
      ],
    );
  }
}
