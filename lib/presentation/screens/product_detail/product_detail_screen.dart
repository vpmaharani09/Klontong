import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/data/data.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/presentation.dart';
import 'package:klontong/presentation/shared/navigation/args/args.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductDetailCubit, ProductDetailState>(
          listener: (context, state) {
            if (state.statusDelete.isHasData) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Delete product is success!',
                  style: AppTextStyle.textStyleMedium14Fw400(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: ColorName.primary,
              ));
              Navigator.pop(context, true);
            }

            if (state.statusDelete.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorName.pink,
                  showCloseIcon: true,
                  closeIconColor: ColorName.red,
                  content: Text(
                    'Delete product is failed!',
                    style: AppTextStyle.textStyleMedium14Fw400(
                      color: ColorName.red,
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
      child: Stack(
        children: [
          Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 371.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorName.backgroundTextfield,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Transform.scale(
                              scaleX: -1,
                              child: Assets.icons.icChevronRight.svg(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: _generateImage(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: _generateDetailProduct(),
                        ),
                        Row(
                          children: [
                            _generateEditButton(),
                            SizedBox(
                              width: 20.w,
                            ),
                            RemoveProductButton(
                              onTap: () {
                                context
                                    .read<ProductDetailCubit>()
                                    .deleteProduct();
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _generateLoading()
        ],
      ),
    );
  }

  Widget _generateEditButton() {
    return BlocSelector<ProductDetailCubit, ProductDetailState, ProductDto?>(
        selector: (state) => state.productDto.data,
        builder: (context, product) {
          return EditProductButton(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.createProduct,
                arguments: CreateArgs(
                  isEdit: true,
                  product: product,
                ),
              ).then((value) {
                if (value != null && (value as bool) == true) {
                  Navigator.pop(context, value);
                }
              });
            },
          );
        });
  }

  Widget _generateDetailProduct() {
    return BlocSelector<ProductDetailCubit, ProductDetailState,
            Pair<ViewState, Map<String, dynamic>?>>(
        selector: (state) =>
            Pair(state.productDto.status, state.productDto.data?.toJson()),
        builder: (context, state) {
          if (state.first.isLoading) return const SizedBox.shrink();

          ProductDto productDto = ProductDto.fromJson(state.second!);
          return Column(
            children: [
              ProductTitlePriceSection(
                name: productDto.name,
                quantity: productDto.quantity,
                unitDisplay: productDto.unitDisplay,
                price: productDto.price,
              ),
              ProductDetailSection(
                description: productDto.description,
              ),
              ExpiredDateSection(
                dateTimeString: DateFormat('MMMM dd, yyyy', 'en_US')
                    .format(productDto.expiredDate),
              ),
              ProductStockSection(
                stock: productDto.stock,
              ),
            ].fold(
                [],
                (previousValue, element) => [
                      ...previousValue,
                      ...[
                        if (previousValue.isNotEmpty) const BaseDivider(),
                        element,
                      ]
                    ]),
          );
        });
  }

  Widget _generateImage() {
    return BlocSelector<ProductDetailCubit, ProductDetailState, String>(
        selector: (state) => state.productDto.data?.imageUrl ?? '',
        builder: (context, imageUrl) {
          if (imageUrl.isEmpty) return const SizedBox.shrink();
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 42.w,
              right: 42.w,
              bottom: 69.w,
            ),
            child: Image.memory(const Base64Decoder().convert(imageUrl)),
          );
        });
  }

  Widget _generateLoading() {
    return BlocSelector<ProductDetailCubit, ProductDetailState, bool>(
        selector: (state) => state.isLoadingScreen,
        builder: (context, isLoading) {
          return Visibility(
            visible: isLoading,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorName.primary,
                ),
              ),
            ),
          );
        });
  }
}
