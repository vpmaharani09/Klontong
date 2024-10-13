import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/shared/widgets/sliding_bottom_sheet.dart';

class KlontongDialog {
  static Future showSimpleActionBottomSheet(
    BuildContext context, {
    required Function() onNegative,
    required Widget body,
    String onNegativeTitle = 'Batal',
  }) {
    return SlidingBottomSheet.customSlidingBottomSheet(
      isDismissable: true,
      context,
      contentModal: SizedBox(
        width: double.infinity,
        child: body,
      ),
      footerModal: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 24.h, left: 15.w, right: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 32.h,
            ),
            GestureDetector(
              onTap: onNegative,
              child: Text(
                'Batal',
                style: AppTextStyle.textStyleBold16Fw400(
                  color: ColorName.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
