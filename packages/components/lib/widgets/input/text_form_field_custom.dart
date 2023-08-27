import 'package:components/res/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom(
      {Key? key,
      this.obscureText = false,
      this.autofocus = false,
      this.focusNode,
      this.nextFocus,
      this.onFieldSubmitted,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none,
      this.inputFormatters,
      this.maxLength,
      this.maxLines = 1,
      this.enabled,
      this.validator,
      this.suffixIcon,
      this.hintText,
      this.labelText,
      this.disabledLabelColor,
      this.errorText,
      this.counterText = ""})
      : super(key: key);

  final bool obscureText;
  final bool autofocus;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int maxLines;
  final bool? enabled;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final bool? disabledLabelColor;
  final String? errorText;
  final String? counterText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: obscureText,
        autofocus: autofocus,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        maxLines: maxLines,
        enabled: enabled,
        validator: validator,
        style: Theme.of(context).textTheme.subtitle2,
        buildCounter: (BuildContext context,
            {int? currentLength, int? maxLength, bool? isFocused}) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "$currentLength",
                style: TextStyle(
                  color: currentLength == 0
                      ? Color(0xffcccccc)
                      : AppColors.colorTextSecondary,
                  fontSize: 16,
                ),
              ),
              Text(
                "/$maxLength",
                style: TextStyle(
                  color: Color(0xffcccccc),
                  fontSize: 16,
                ),
              ),
            ],
          );
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
          counterText: counterText,
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          errorMaxLines: 2,
          errorStyle: const TextStyle(color: Colors.red),
          labelStyle: Theme.of(context)
              .textTheme
              .subtitle3
              .copyWith(color: AppColors.black),
          hintStyle: Theme.of(context).textTheme.button,
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
