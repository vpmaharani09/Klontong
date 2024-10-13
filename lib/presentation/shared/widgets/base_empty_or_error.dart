import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/shared/widgets/klontong_custom_button.dart';

class BaseEmptyOrErrorWidget extends StatelessWidget {
  const BaseEmptyOrErrorWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.buttonText,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.textStyleBold24Fw400(
            color: ColorName.textPrimary,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          subtitle,
          style: AppTextStyle.textStyleBold16Fw400(
            color: ColorName.textSecondary,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        if (onTap != null)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100.w),
            child: KlontongCustomButton(
              borderRadius: BorderRadius.circular(10.r),
              onTap: () {},
              title: buttonText ?? 'Try Again',
              padding: EdgeInsets.symmetric(vertical: 10.h),
            ),
          ),
      ],
    );
  }
}