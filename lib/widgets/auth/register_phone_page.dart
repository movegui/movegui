import 'package:flutter/material.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/widgets/auth/button_validation_widget.dart';
import 'package:movegui/widgets/person/birthdate_picker.dart';
import 'package:movegui/widgets/person/gender_picker.dart';
import 'package:movegui/widgets/person/personal_base_info_widget.dart';

class RegisterPhonePage extends StatefulWidget {
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final String? selectedGender;
  const RegisterPhonePage({
    super.key,
    required this.onGenderChanged,
    this.onBirthDateChanged,
    this.selectedGender,
  });

  @override
  State<RegisterPhonePage> createState() => RegisterPhonePageState();
}

class RegisterPhonePageState extends State<RegisterPhonePage> {
  late final TextEditingController _phoneNumberController,
      _nameController,
      _prenomController,
      _adressController;
  late final FocusNode _phoneNumberFocusNode,
      _nameFocusNode,
      _prenomFocusNode,
      _adressFocusNode;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _prenomController = TextEditingController();
    _adressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    // Focus Nodes
    _phoneNumberFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _prenomFocusNode = FocusNode();
    _adressFocusNode = FocusNode();
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

  Future<void> _registerFCT() async {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GenderPicker(
                  onGenderChanged: (value) {
                    widget.onGenderChanged(value);
                  },
                  gender: widget.selectedGender,
                ),
              ),
              SizedBox(width: 16), // optional spacing
              Expanded(
                child: BirthdatePicker(
                  onBirthDateChanged: (value) {
                    widget.onBirthDateChanged?.call(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 6),

          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 6),
                PersonalBaseInfoWidget(
                  nameController: _nameController,
                  prenomController: _prenomController,
                  addressController: _adressController,
                  nameFocus: _nameFocusNode,
                  prenomFocus: _prenomFocusNode,
                  addressFocus: _adressFocusNode,
                ),

                /*
                TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Nom',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_prenomFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.displayNamevalidator(value);
                  },
                ),

                TextFormField(
                  controller: _prenomController,
                  focusNode: _prenomFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Prenom',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_adressFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.displayNamevalidator(value);
                  },
                ),

                TextFormField(
                  controller: _adressController,
                  focusNode: _adressFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Adresse',
                    prefixIcon: Icon(Icons.home),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                  },
                  validator: (value) {
                    return MyValidators.displayNamevalidator(value);
                  },
                ),
                */
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

                 const SizedBox(height: 18.0),
          ButtonValidationWidget(title: 'Enregistrer', onPress: _registerFCT)

                /*
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
                */
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
