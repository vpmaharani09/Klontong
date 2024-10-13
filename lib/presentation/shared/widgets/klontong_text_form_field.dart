import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/gen/colors.gen.dart';

class KlontongTextFormField extends StatelessWidget {
  const KlontongTextFormField({
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.autofocus = false,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    required this.onChanged,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    required this.hintText,
    this.hintStyle,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.filled = true,
    this.controller,
    this.focusColor,
    this.contentPadding,
    required this.fieldName,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String? initialValue;
  final String? hintText;
  final String fieldName;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool autofocus;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String?> onChanged;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final OutlineInputBorder? border,
      enabledBorder,
      focusedBorder,
      disabledBorder,
      errorBorder,
      focusedErrorBorder;
  final Color? fillColor, focusColor;
  final bool filled, obscureText;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon, suffixIcon;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: ColorName.borderTextfield),
    );
    OutlineInputBorder errorBorderDefault = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: ColorName.red),
    );
    return FormBuilderTextField(
      name: fieldName,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      textInputAction: textInputAction ?? TextInputAction.done,
      autofocus: autofocus,
      enabled: enabled,
      obscureText: obscureText,
      style: style ??
          AppTextStyle.textStyle14Fw600(
            color: ColorName.textPrimary,
          ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            AppTextStyle.textStyle14Fw600(
              color: ColorName.textSecondary,
            ),
        border: border ?? defaultBorder,
        enabledBorder: enabledBorder ?? border ?? defaultBorder,
        focusedBorder: focusedBorder ?? border ?? defaultBorder,
        errorBorder: errorBorder ?? errorBorderDefault,
        focusedErrorBorder:
            focusedErrorBorder ?? errorBorder ?? errorBorderDefault,
        fillColor: fillColor ?? Colors.white,
        filled: filled,
        focusColor: focusColor,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 16.w,
            ),
      ),
    );
  }
}
