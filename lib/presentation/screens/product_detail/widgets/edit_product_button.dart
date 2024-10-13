import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/shared/widgets/klontong_custom_button.dart';

class EditProductButton extends StatelessWidget {
  const EditProductButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: KlontongCustomButton(
        backgroundColor: ColorName.primary,
        splashColor: ColorName.textPrimary,
        title: 'Edit Product',
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
      ),
    );
  }
}
