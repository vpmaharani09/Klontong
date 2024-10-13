import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/gen/colors.gen.dart';

class RemoveProductButton extends StatelessWidget {
  const RemoveProductButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: ColorName.primary,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        splashColor: ColorName.textPrimary,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 30.w,
            color: ColorName.primary,
          ),
        ),
      ),
    );
  }
}
