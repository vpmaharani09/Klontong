import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/shared/widgets/widgets.dart';

class LabelWithTextField extends StatelessWidget {
  const LabelWithTextField({
    super.key,
    required this.label,
    this.hintText = '',
    required this.fieldName,
    required this.onChanged,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.isRequiredField = false,
    this.enabled = true,
    this.inputFormatters,
    this.initialValue,
  });

  final String label;
  final String hintText;
  final String fieldName;
  final ValueChanged<String?> onChanged;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isRequiredField;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(label: label, isRequired: isRequiredField),
        SizedBox(
          height: 4.h,
        ),
        KlontongTextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          hintText: hintText,
          fieldName: fieldName,
          fillColor: Colors.white,
          hintStyle: AppTextStyle.textStyleMedium13Fw400(
            color: ColorName.hintColor,
          ),
          style: AppTextStyle.textStyleMedium14Fw400(
            color: ColorName.textSecondary,
          ),
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          enabled: enabled,
          inputFormatters: inputFormatters,
          validator: isRequiredField
              ? FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: '$label is required'),
                ])
              : null,
        ),
      ],
    );
  }
}
