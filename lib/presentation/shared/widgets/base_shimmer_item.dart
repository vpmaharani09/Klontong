import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/gen/colors.gen.dart';

class BaseShimmerItem extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double borderRadius;

  const BaseShimmerItem({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = ColorName.colorShimmer,
    this.borderRadius = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        color: color ?? Colors.grey[300],
      ),
    );
  }
}
