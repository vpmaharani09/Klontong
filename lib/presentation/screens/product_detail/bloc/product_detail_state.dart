import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';

class ProductDetailState {
  ProductDetailState({
    required this.statusDelete,
    required this.productDto,
    required this.idProduct,
  });

  final ViewState statusDelete;
  final ViewData<ProductDto> productDto;
  final String idProduct;

  bool get isLoadingScreen =>
      productDto.status.isLoading || statusDelete.isLoading;

  ProductDetailState copyWith({
    ViewState? statusDelete,
    ViewData<ProductDto>? productDto,
    String? idProduct,
  }) {
    return ProductDetailState(
      idProduct: idProduct ?? this.idProduct,
      statusDelete: statusDelete ?? this.statusDelete,
      productDto: productDto ?? this.productDto,
    );
  }
}
