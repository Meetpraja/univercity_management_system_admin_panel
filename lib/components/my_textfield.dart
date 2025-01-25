import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    super.key,
    required this.hint,
    required this.obsecure,
    this.icon,
    this.noTapIcon,
    required this.keyboardType,
    required this.controller,
    required this.validator,
  });

  final String hint;
  final bool obsecure;
  final IconButton? icon;
  final Icon? noTapIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        keyboardType: keyboardType,
        obscureText: obsecure,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Color.fromRGBO(239, 103, 103, 1.0)
          ),
          filled: true,
          fillColor: Colors.blueGrey.withOpacity(0.9),
          hintText: hint,
          hintStyle: const TextStyle(height: 2),
          suffixIcon: icon ?? noTapIcon,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
