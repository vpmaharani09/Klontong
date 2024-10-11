import 'package:flutter/material.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Find Products',
          style: AppTextStyle.textStyle20Fw500(
            color: ColorName.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search product',
              hintStyle: AppTextStyle.textStyle14Fw600(
                color: ColorName.textSecondary,
              ),
              prefixIcon: Assets.icons.icSearch.svg(
                
              ),
            ),
          )
        ],
      ),
    );
  }
}
