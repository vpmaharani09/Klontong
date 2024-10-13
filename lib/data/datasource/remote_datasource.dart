import 'package:dio/dio.dart';
import 'package:klontong/core/network/app_api.dart';
import 'package:klontong/core/network/network.dart';
import 'package:klontong/data/data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class RemoteDatasource {
  Future<List<ProductDto>> getListProduct();
  Future<ProductDto> getDetailProduct({required String idProduct});
  Future<BaseResponseDto> createProduct({required ProductDto product});
  Future<BaseResponseDto> updateProduct({required ProductDto product});
  Future<BaseResponseDto> deleteProduct({required String idProduct});
}

class RemoteDataSourceImpl implements RemoteDatasource {
  RemoteDataSourceImpl({required this.dioHandler});
  DioHandler dioHandler;

  @override
  Future<BaseResponseDto> createProduct({required ProductDto product}) async {
    try {
      await dioHandler.dio.post(AppApi.products, data: product.toJsonApi());
      return BaseResponseDto(status: true);
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  @override
  Future<BaseResponseDto> deleteProduct({required String idProduct}) async {
    try {
      await dioHandler.dio.delete('${AppApi.products}/$idProduct');

      return BaseResponseDto(status: true);
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  @override
  Future<ProductDto> getDetailProduct({required String idProduct}) async {
    try {
      final Response response =
          await dioHandler.dio.get('${AppApi.products}/$idProduct');
      return ProductDto.fromJson(response.data);
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  @override
  Future<List<ProductDto>> getListProduct() async {
    try {
      final Response response = await dioHandler.dio.get(AppApi.products);
      final List<dynamic> data = response.data;
      return data.map((e) => ProductDto.fromJson(e)).toList();
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  @override
  Future<BaseResponseDto> updateProduct({required ProductDto product}) async {
    try {
      await dioHandler.dio
          .put('${AppApi.products}/${product.id}', data: product.toJsonApi());
      return BaseResponseDto(status: true);
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }
}
