import 'package:fire_todo/core/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomFiled extends StatelessWidget {
  const CustomFiled(
      {super.key,
      this.keyboardType=TextInputType.text,
      required this.label,
      required this.controller,
      this.validator, this.obscureText=false});

  final TextInputType keyboardType;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.5,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
      ),
      validator: validator,
    );
  }

}
