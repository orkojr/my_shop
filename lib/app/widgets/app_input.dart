import 'package:flutter/material.dart';
import 'package:myshop/app/utils/app_colors.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? placeholder;
  final bool obscureText;
  final TextInputType? textInputType;
  const AppInput({
    Key? key,
    required this.controller,
    this.validator,
    required this.label,
    this.placeholder,
    this.obscureText = false,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryGrayText,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 24, 31, 128),
          ),
          decoration: InputDecoration(
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.grayScale,
            ),
            fillColor: const Color.fromARGB(125, 232, 234, 235),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.hexToColor("#DDDDDD")),
              borderRadius: BorderRadius.circular(6),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.hexToColor("#DDDDDD")),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          validator: validator,
          obscureText: obscureText,
          keyboardType: textInputType,
        )
      ],
    );
  }
}
