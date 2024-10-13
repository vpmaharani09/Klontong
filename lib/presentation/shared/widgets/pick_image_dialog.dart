import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';

class PickImageDialog extends StatelessWidget {
  final Function() onClickGallery;
  final Function() onClickCamera;
  const PickImageDialog({
    super.key,
    required this.onClickCamera,
    required this.onClickGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onClickGallery,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.icGalleryLinear.svg(),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      'Galeri',
                      style: AppTextStyle.textStyle16Fw600(
                        color: ColorName.textPrimary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 2.w,
              height: 30.h,
              color: ColorName.divider,
            ),
            Expanded(
              child: GestureDetector(
                onTap: onClickCamera,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.icCameraLinear.svg(),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      'Kamera',
                      style: AppTextStyle.textStyle16Fw600(
                        color: ColorName.textPrimary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
