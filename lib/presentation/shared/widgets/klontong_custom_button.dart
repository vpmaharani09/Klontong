import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';

class KlontongCustomButton extends StatelessWidget {
  const KlontongCustomButton({
    super.key,
    this.backgroundColor,
    this.splashColor,
    required this.borderRadius,
    required this.onTap,
    required this.title,
    this.width,
    this.textStyle,
    this.padding,
    this.enabled = true,
  });

  final Color? backgroundColor;
  final Color? splashColor;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final String title;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          enabled ? (backgroundColor ?? ColorName.primary) : ColorName.f7f7f7,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: enabled ? onTap : null,
        splashColor: enabled ? (splashColor ?? ColorName.textPrimary) : null,
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: borderRadius,
          ),
          child: Text(
            title,
            style: textStyle ??
                AppTextStyle.textStyle18Fw600(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
