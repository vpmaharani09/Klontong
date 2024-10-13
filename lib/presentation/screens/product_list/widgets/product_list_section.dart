import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';
import 'package:klontong/presentation/shared/widgets/base_shimmer.dart';
import 'package:klontong/presentation/shared/widgets/base_shimmer_item.dart';

class ProductListSection extends StatefulWidget {
  const ProductListSection({
    super.key,
  });

  @override
  State<ProductListSection> createState() => _ProductListSectionState();
}

class _ProductListSectionState extends State<ProductListSection> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients &&
          (_scrollController.position.pixels) >=
              (_scrollController.position.maxScrollExtent)) {
        context.read<ProductListCubit>().fetchNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 10.h,
      ),
      child: _generateList(),
    );
  }

  Widget _generateList() {
    return BlocSelector<ProductListCubit, ProductListState,
            Pair<ViewState, int>>(
        selector: (state) =>
            Pair(state.productListApi.status, state.productDisplay.itemMax),
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                state.second,
                (index) => _generateItem(index),
              ),
              if (state.first.isLoading)
                ...List.generate(
                  3,
                  (index) => BaseShimmer(
                    content: BaseShimmerItem(
                      borderRadius: 10,
                      width: double.infinity,
                      height: 100.h,
                    ),
                  ),
                ),
              if (state.first.isLazyLoading)
                BaseShimmer(
                  content: BaseShimmerItem(
                    borderRadius: 10,
                    width: double.infinity,
                    height: 100.h,
                  ),
                ),
            ].fold(
              [],
              (previousValue, element) => [
                ...previousValue,
                ...[
                  if (previousValue.isNotEmpty)
                    BaseDivider(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                  element,
                ]
              ],
            ),
          );
        });
  }

  Widget _generateItem(int index) {
    return BlocSelector<ProductListCubit, ProductListState,
            Map<String, dynamic>?>(
        selector: (state) =>
            (state.productDisplay.data.get(index) as ProductDto?)?.toJson(),
        builder: (context, state) {
          if (state == null) return const SizedBox.shrink();
          ProductDto product = ProductDto.fromJson(state);
          return ProductCardItem(
            name: product.name,
            price: product.price,
            unitDisplay: product.unitDisplay,
            imageUrl: product.imageUrl,
            quantity: product.quantity,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.productDetail,
                arguments: product.id,
              ).then((value) {
                if (value != null && (value as bool) == true) {
                  context.read<ProductListCubit>().fetchProducts();
                }
              });
            },
          );
        });
  }
}
