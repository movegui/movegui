import 'package:flutter/material.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/widgets/util/input_widget.dart';

class InputPhoneWidget extends StatelessWidget{
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final FocusNode? nextFocusNode;

  const InputPhoneWidget({super.key, required this.phoneController, required this.phoneFocusNode, this.nextFocusNode});

  @override
  Widget build(BuildContext context) {

/*
  return  Padding(
        padding: EdgeInsets.all(16),
        child: InternationalPhoneNumberInput(
          onInputChanged: (number) {
            print(number.phoneNumber);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DROPDOWN,
          ),
          textFieldController: phoneController,
          inputDecoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
          ),
        ),
      ),
*/

    return  InputWidget(
      controller: phoneController,
      focusNode: phoneFocusNode,
      icon: Icons.phone,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.phone,
      hinterText: '+224 601 00 00 00',
      validator: (value) {
        return MyValidators.phoneNumberValidator(value);
      },
    );
    
  }
}

