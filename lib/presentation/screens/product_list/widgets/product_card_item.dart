import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/theme.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key,
    this.onTap,
    required this.name,
    required this.price,
    required this.unitDisplay,
    required this.imageUrl,
    required this.quantity,
  });

  final VoidCallback? onTap;
  final String name;
  final double price;
  final String unitDisplay;
  final String imageUrl;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 65.w,
              height: 65.w,
              child: Image.memory(const Base64Decoder().convert(imageUrl),
                  fit: BoxFit.contain),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyle.textStyleBold16Fw400(
                            color: ColorName.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '$quantity$unitDisplay, Price',
                          style: AppTextStyle.textStyleMedium14Fw400(
                            color: ColorName.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: AppTextStyle.textStyle16Fw600(
                      color: ColorName.textPrimary,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Assets.icons.icChevronRight.svg(
                    width: 14.w,
                    height: 14.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
