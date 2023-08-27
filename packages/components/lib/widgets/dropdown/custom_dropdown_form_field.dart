import 'dart:core';

import 'package:components/res/res.dart';
import 'package:components/widgets/dropdown/dropdown_component.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormFieldComponent<T> extends StatelessWidget {
  const CustomDropdownFormFieldComponent(
      {Key? key,
      required this.items,
      required this.validator,
      required this.onSaved,
      required this.onChanged,
      required this.labelDefault})
      : super(key: key);
  final List<DropdownMenuItem<T>> items;

  final FormFieldValidator<T>? validator;

  final FormFieldSetter<T>? onSaved;

  final ValueChanged<T?>? onChanged;

  final String? labelDefault;

  @override
  Widget build(BuildContext context) {
    return DropdownFormFieldComponent<T>(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary)),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      isExpanded: true,
      dropdownMaxHeight: 320,
      hint: Text(
        labelDefault ?? "",
        style: TextStyle(fontSize: FontAlias.fontAlias14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      offset: Offset(0, -8),
      focusColor: AppColors.primary,
      iconSize: 30,
      buttonPadding: const EdgeInsets.only(left: 16, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      items: items,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
