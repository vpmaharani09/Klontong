import 'package:klontong/data/data.dart';

abstract class RemoteDatasource {
  Future<List<ProductDto>> getListProduct();
  Future<ProductDto> getDetailProduct({required String idProduct});
  Future<BaseResponseDto> createProduct({required ProductDto product});
  Future<BaseResponseDto> updateProduct({required ProductDto product});
  Future<BaseResponseDto> deleteProduct({required String idProduct});
}
