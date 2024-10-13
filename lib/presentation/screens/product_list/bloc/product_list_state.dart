import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';

class ProductListState {
  ProductListState({
    required this.productListApi,
    required this.productDisplay,
    this.querySearch = '',
    this.limit = 10,
  });

  ViewData<List<ProductDto>> productListApi;
  PaginateList<ProductDto> productDisplay;
  String querySearch;
  int limit;

  bool get isEmptySearchList =>
      querySearch.isNotEmpty && productDisplay.data.isEmpty;

  bool get isHasQuery => querySearch.isNotEmpty;

  bool get isEmptyList =>
      productListApi.status.isHasData &&
      productDisplay.itemMax == 0 &&
      querySearch.isEmpty;

  ProductListState copyWith({
    ViewData<List<ProductDto>>? productListApi,
    PaginateList<ProductDto>? productDisplay,
    String? querySearch,
  }) {
    return ProductListState(
      productListApi: productListApi ?? this.productListApi,
      productDisplay: productDisplay ?? this.productDisplay,
      querySearch: querySearch ?? this.querySearch,
    );
  }
}
