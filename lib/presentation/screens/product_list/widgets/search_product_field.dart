import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/theme/app_text_style.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';

class SearchProductField extends StatefulWidget {
  const SearchProductField({
    super.key,
    required this.onChanged,
    this.isDirty = false,
  });

  final ValueChanged<String?> onChanged;
  final bool isDirty;

  @override
  State<SearchProductField> createState() => _SearchProductFieldState();
}

class _SearchProductFieldState extends State<SearchProductField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyle.textStyle14Fw600(
        color: ColorName.textPrimary,
      ),
      onChanged: widget.onChanged,
      controller: _controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 16.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: ColorName.backgroundTextfield,
        hintText: 'Search Products',
        hintStyle: AppTextStyle.textStyle14Fw600(
          color: ColorName.textSecondary,
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16.w,
            ),
            Assets.icons.icSearch.svg(
              width: 18.w,
              height: 18.w,
              color: ColorName.textPrimary,
            ),
          ],
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16.w,
            ),
            if (widget.isDirty)
              GestureDetector(
                onTap: () {
                  _controller.clear();
                  widget.onChanged('');
                },
                child: Assets.icons.icCloseCircle.svg(
                  width: 16.w,
                  height: 16.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
