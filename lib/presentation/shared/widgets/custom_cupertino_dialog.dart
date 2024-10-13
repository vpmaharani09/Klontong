import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';

// ignore: must_be_immutable
class CustomCupertinoDatePicker extends StatelessWidget {
  CustomCupertinoDatePicker({
    super.key,
    required this.onSelectedDate,
    this.headerTitle,
    this.height,
    this.confirmationLabel,
    this.newDateValue,
    this.minimumDate,
    this.maximumDate,
    this.maximumYear,
  });

  final Function(DateTime) onSelectedDate;
  DateTime? newDateValue;
  DateTime? minimumDate, maximumDate;
  String? headerTitle;
  double? height;
  String? confirmationLabel;
  int? maximumYear;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // height: height ?? 0.5.sh,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 32.h, bottom: 40.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              headerTitle ?? 'Choose date and time',
              style: AppTextStyle.textStyleBold16Fw400(
                color: ColorName.textSecondary,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 200.h,
              child: CupertinoDatePicker(
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: newDateValue ?? DateTime.now(),
                dateOrder: DatePickerDateOrder.dmy,
                maximumYear: maximumYear,
                onDateTimeChanged: (DateTime newDate) {
                  newDateValue = newDate;
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
              onTap: () {
                onSelectedDate(newDateValue ?? DateTime.now());
              },
              child: Text(
                confirmationLabel ?? 'Pilih',
                style: AppTextStyle.textStyleBold16Fw400(
                  color: ColorName.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
