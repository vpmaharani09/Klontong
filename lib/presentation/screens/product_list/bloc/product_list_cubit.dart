import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit({
    required this.remoteDatasource,
    required this.debouncer,
  }) : super(
          ProductListState(
            productDisplay: PaginateList<ProductDto>(data: <ProductDto>[]),
            productListApi: ViewData.initial(),
            querySearch: '',
          ),
        );

  final RemoteDatasource remoteDatasource;
  final Debouncer debouncer;

  void fetchNextPage() async {
    if (state.productDisplay.itemCount >= state.productDisplay.itemMax) return;
    List<ProductDto> allProduct = state.productListApi.data!;
    emit(
        state.copyWith(productListApi: ViewData.lazyLoading(data: allProduct)));
    List<ProductDto> currentDisplay = state.productDisplay.data;
    List<ProductDto> newDisplay =
        allProduct.skip(currentDisplay.length).take(state.limit).toList();

    await Future.delayed(const Duration(seconds: 2));

    emit(
      state.copyWith(
        productDisplay: PaginateList<ProductDto>(
          data: currentDisplay + newDisplay,
          itemCount: currentDisplay.length + newDisplay.length,
          itemMax: allProduct.length,
        ),
        productListApi: ViewData.loaded(data: allProduct),
      ),
    );
  }

  void fetchProducts() {
    emit(
      state.copyWith(
        productListApi: ViewData.loading(),
        productDisplay: PaginateList<ProductDto>(data: <ProductDto>[]),
      ),
    );
    remoteDatasource.getListProduct().then((value) {
      List<ProductDto> allProduct = value;
      List<ProductDto> productDisplay = value.take(state.limit).toList();
      emit(
        state.copyWith(
          productDisplay: PaginateList<ProductDto>(
            data: productDisplay,
            itemCount: productDisplay.length,
            itemMax: allProduct.length,
          ),
          productListApi: ViewData.loaded(data: allProduct),
        ),
      );
    }).catchError((error) {
      emit(state.copyWith(
          productListApi: ViewData.error(message: 'Gagal memuat data')));
    });
  }

  void goToDetailProduct() {}

  void goToFormAddProduct() {}

  void onChangeSearch({String search = ''}) {
    emit(state.copyWith(querySearch: search));

    List<ProductDto> allProduct = state.productListApi.data!;

    if (state.querySearch.isEmpty) {
      List<ProductDto> productDisplay = allProduct.take(state.limit).toList();
      emit(
        state.copyWith(
          productDisplay: PaginateList<ProductDto>(
            data: productDisplay,
            itemCount: productDisplay.length,
            itemMax: allProduct.length,
          ),
        ),
      );
      return;
    }

    if (state.querySearch.length < 3) return;

    debouncer.run(() {
      List<ProductDto> listFilter = allProduct
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();

      emit(
        state.copyWith(
          productDisplay: PaginateList<ProductDto>(
            data: listFilter,
            itemCount: listFilter.length,
            itemMax: allProduct.length,
          ),
        ),
      );
    });
  }
}
