import 'package:chat/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/responsive.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool obscureText, readOnly;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Color? iconColor;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool useLabel;
  final VoidCallback? actionIcon;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool useSuffixIcon;
  final TextAlign? textAlign;
  final Color? fillColor;
  final bool? autoFocus;
  final TextStyle? textStyle;
  final int? maxLines;
  final void Function(String)? onChanged;
  final EdgeInsets? padding;
  final Color? textColor;
  final Widget? prefixIcon;

  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.controller,
    this.suffixIcon,
    this.iconColor,
    this.textInputType,
    this.maxLength,
    this.useLabel = false,
    this.actionIcon,
    this.onTap,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.useSuffixIcon = true,
    this.textAlign,
    this.fillColor,
    this.autoFocus,
    this.textStyle,
    this.maxLines,
    this.onChanged,
    this.padding,
    this.textColor,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return TextFormField(
      autofocus: autoFocus ?? false,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      style: textStyle ??
          GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: textColor ?? Theme.of(context).colorScheme.onSurface,
              fontSize: responsive.dp(1.5)),
      maxLength: maxLength,
      focusNode: focusNode,
      controller: controller,
      onEditingComplete: onEditingComplete,
      cursorColor: textColor ?? Theme.of(context).colorScheme.onSurface,
      inputFormatters: inputFormatters,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          isCollapsed: true,
          contentPadding: padding ??
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
          counterText: "",
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: textStyle ??
              GoogleFonts.quicksand(
                  color: Colors.grey, fontSize: responsive.dp(1.5)),
          prefixIcon: prefixIcon,
          prefixIconColor: CustomColors.purple,
          suffixIcon: useSuffixIcon
              ? IconButton(
                  icon: Icon(suffixIcon,
                      color: iconColor ?? Theme.of(context).iconTheme.color),
                  onPressed: actionIcon)
              : null,
          fillColor: fillColor ?? Theme.of(context).colorScheme.onSecondary,
          filled: true,
          errorStyle: GoogleFonts.quicksand(
              fontSize: responsive.dp(1.2),
              color: Colors.red,
              fontWeight: FontWeight.w500),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          )),
    );
  }
}
