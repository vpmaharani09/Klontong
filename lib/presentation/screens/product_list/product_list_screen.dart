import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/presentation.dart';
import 'package:klontong/presentation/shared/navigation/args/args.dart';
import 'package:klontong/presentation/shared/widgets/base_empty_or_error.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        floatingActionButton: _generateAddButton(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Find Products',
            style: AppTextStyle.textStyleBold16Fw400(
              color: ColorName.textPrimary,
            ),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: _generateContent(),
        ),
      ),
    );
  }

  Widget _generateAddButton() {
    return BlocSelector<ProductListCubit, ProductListState, bool>(
        selector: (state) => state.productListApi.status.isHasData,
        builder: (context, isHasData) {
          if (!isHasData) {
            return const SizedBox();
          }
          return FloatingActionButton(
            backgroundColor: ColorName.primary,
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.createProduct,
                      arguments: CreateArgs(isEdit: false))
                  .then((value) {
                if (value != null && (value as bool) == true) {
                  context.read<ProductListCubit>().fetchProducts();
                }
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        });
  }

  Widget _generateContent() {
    return BlocSelector<ProductListCubit, ProductListState,
            Pair<bool, ViewState>>(
        selector: (state) =>
            Pair(state.isEmptyList, state.productListApi.status),
        builder: (context, state) {
          if (state.first) {
            return const Center(
              child: BaseEmptyOrErrorWidget(
                title: 'No Product Found',
                subtitle: 'Please add a product first',
              ),
            );
          }

          if (state.second.isError) {
            return Center(
              child: BaseEmptyOrErrorWidget(
                title: 'Ups, Something Went Wrong',
                subtitle: 'Please try again later',
                buttonText: 'Try Again',
                onTap: context.read<ProductListCubit>().fetchProducts,
              ),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.second.isHasData && !state.first)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: _generateSearch(),
                ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: _generateList(),
              ),
            ],
          );
        });
  }

  Widget _generateSearch() {
    return BlocSelector<ProductListCubit, ProductListState, bool>(
        selector: (state) => state.isHasQuery,
        builder: (context, isDirty) {
          return SearchProductField(
            isDirty: isDirty,
            onChanged: (String? val) {
              context
                  .read<ProductListCubit>()
                  .onChangeSearch(search: val ?? '');
            },
          );
        });
  }

  Widget _generateList() =>
      BlocSelector<ProductListCubit, ProductListState, bool>(
        selector: (state) => state.isEmptySearchList,
        builder: (context, isEmptySearchList) {
          return ProductListSection();
        },
      );
}
