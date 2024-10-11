import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle textStyle20Fw500({Color? color}) {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle textStyle14Fw600({Color? color}) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
}
