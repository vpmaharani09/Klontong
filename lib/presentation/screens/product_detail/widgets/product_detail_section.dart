import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/shared/widgets/klontong_expandable_widget.dart';

class ProductDetailSection extends StatelessWidget {
  const ProductDetailSection({
    super.key, required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Detail',
              style: AppTextStyle.textStyle16Fw600(
                color: ColorName.textPrimary,
              ),
            ),
            Assets.icons.icChevronBottom.svg()
          ],
        ),
        ExpandedSection(
          height: 300.h,
          expand: true,
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            description,
            style: AppTextStyle.textStyleMedium13Fw400(
              color: ColorName.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}