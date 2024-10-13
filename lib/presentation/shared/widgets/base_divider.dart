import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/gen/colors.gen.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({
    super.key,
    this.margin,
  });

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 24.h),
      height: 1.h,
      width: double.infinity,
      color: ColorName.divider.withOpacity(0.7),
    );
  }
}
