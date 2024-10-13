import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';

class ProductStockSection extends StatelessWidget {
  const ProductStockSection({
    super.key,
    required this.stock,
  });

  final int stock;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Stock',
          style: AppTextStyle.textStyle16Fw600(
            color: ColorName.textPrimary,
          ),
        ),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: ColorName.gray,
          ),
          child: Text(
            '${stock}pcs',
            style: AppTextStyle.textStyleMedium13Fw400(
                color: ColorName.textSecondary),
          ),
        )
      ],
    );
  }
}
