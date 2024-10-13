import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';

class KlontongDropdownButton<T> extends StatelessWidget {
  const KlontongDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<DropdownMenuItem<T>> items;
  final T value;
  final ValueChanged<T?> onChanged;

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

    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        alignment: Alignment.center,
        icon: Assets.icons.icChevronBottom.svg(
          width: 6.w,
          height: 6.w,
          color: ColorName.textSecondary,
        ),
        borderRadius: BorderRadius.circular(10.r),
        decoration: InputDecoration(
          border: defaultBorder,
          enabledBorder: defaultBorder,
          focusedBorder: defaultBorder,
          errorBorder: errorBorderDefault,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
        ),
        value: value,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}