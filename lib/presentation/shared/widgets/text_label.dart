import 'package:flutter/material.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({
    super.key,
    required this.label,
    this.isRequired = false,
  });

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyle.textStyleBold15Fw400(
            color: ColorName.textSecondary,
          ),
        ),
        if (isRequired)
          Text(
            ' *',
            style: AppTextStyle.textStyleBold18Fw400(
              color: ColorName.red,
            ),
          ),
      ],
    );
  }
}
