import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/colors.gen.dart';

class ProductTitlePriceSection extends StatelessWidget {
  const ProductTitlePriceSection({
    super.key,
    required this.name,
    required this.unitDisplay,
    required this.quantity,
    this.price,
  });

  final String name;
  final String unitDisplay;
  final int quantity;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyle.textStyleBold24Fw400(
                  color: ColorName.textPrimary,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                '$quantity$unitDisplay, Price',
                style: AppTextStyle.textStyle16Fw600(
                  color: ColorName.textSecondary,
                ),
              )
            ],
          ),
        ),
        Text(
          '\$${price!.toStringAsFixed(2)}',
          style: AppTextStyle.textStyleBold24Fw400(
            color: ColorName.textPrimary,
          ),
        )
      ],
    );
  }
}
