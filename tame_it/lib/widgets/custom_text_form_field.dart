import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../values/values.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final TextStyle? titleStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? title;
  final bool obscured;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final bool hasTitle;
  final bool hasTitleIcon;
  final Widget? titleIcon;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder border;
  final InputBorder enabledBorder;
  final InputBorder focusedBorder;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? textFormFieldMargin;
  final TextEditingController? controller;

  const CustomTextFormField({
    Key? key,
    this.obscureText = true, // Make it optional with a default value
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.hintTextStyle,
    this.labelStyle,
    this.titleStyle,
    this.titleIcon,
    this.hasTitleIcon = false,
    this.title,
    this.contentPadding,
    this.textFormFieldMargin,
    this.hasTitle = false,
    this.border = Borders.primaryInputBorder,
    this.focusedBorder = Borders.focusedBorder,
    this.enabledBorder = Borders.enabledBorder,
    this.hintText,
    this.labelText,
    this.hasPrefixIcon = false,
    this.hasSuffixIcon = false,
    this.obscured = false,
    this.textInputType,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.width,
    this.height,
    this.controller,
  })  : assert((!hasTitleIcon && titleIcon == null) ||
            (hasTitleIcon && titleIcon != null)),
        assert((!hasTitle && title == null) || (hasTitle && title != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            hasTitleIcon ? titleIcon! : Container(),
            hasTitle ? Text(title!, style: titleStyle!) : Container(), // Added null check for titleStyle
          ],
        ),
        Container(
          width: width,
          height: height,
          margin: textFormFieldMargin,
          child: TextFormField(
            style: textStyle,
            keyboardType: textInputType,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              labelText: labelText,
              labelStyle: labelStyle,
              border: border,
              enabledBorder: enabledBorder,
              focusedBorder: focusedBorder,
              prefixIcon: hasPrefixIcon ? prefixIcon : null,
              suffixIcon: hasSuffixIcon
                  ? GestureDetector(
                      onTap: () {
                        // Toggle password visibility
                        onChanged?.call((!obscureText!) as String);
                      },
                      child: suffixIcon,
                    )
                  : null,
              hintText: hintText,
              hintStyle: hintTextStyle,
            ),
            obscureText: obscured && obscureText, // Apply password visibility
            controller: controller, // Added controller here
          ),
        ),
      ],
    );
  }
}
