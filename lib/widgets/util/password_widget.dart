import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/consts/widget_constants.dart';

class PasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final bool obscureText;
  final VoidCallback onPressObscur;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontweight;
  const PasswordWidget({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.obscureText,
    required this.onPressObscur,
    this.textColor = AppColors.textColor,
    this.fontSize = 14,
    this.fontweight = FontWeight.normal,
  });
  @override
  State<StatefulWidget> createState() => PasswordWidgetState();
}

class PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: WidgetConstants.sepWidgetHeight * 1.5,
        right: WidgetConstants.sepWidgetHeight * 1.5,
      ),
      child: TextFormField(
        obscureText: widget.obscureText,
        controller: widget.passwordController,
        focusNode: widget.passwordFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: widget.onPressObscur,
            /*
                         () {
                          setState(() {
                            widget.obscureText = !obscureText;
                          });
                        },
                        */
            icon: Icon(
              widget.obscureText ? Icons.visibility : Icons.visibility_off,
              color: widget.textColor,
            ),
          ),
          hintText: "***********",
          prefixIcon: Icon(Icons.lock, color: widget.textColor),
        ),
        validator: (value) {
          return MyValidators.passwordValidator(value);
        },
        style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.textColor,
          fontWeight: widget.fontweight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
