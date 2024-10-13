import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/data/datasource/remote_datasource.dart';
import 'package:klontong/presentation/presentation.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    required this.remoteDatasource,
    this.id = '',
  }) : super(ProductDetailState(
            statusDelete: ViewState.initial,
            idProduct: id,
            productDto: ViewData.initial()));

  final RemoteDatasource remoteDatasource;
  final String id;

  void fetchDetailProduct() {
    emit(state.copyWith(productDto: ViewData.loading()));
    remoteDatasource.getDetailProduct(idProduct: state.idProduct).then((value) {
      emit(state.copyWith(productDto: ViewData.loaded(data: value)));
    }).catchError((e) {
      emit(state.copyWith(
          productDto: ViewData.error(message: 'Something went wrong')));
    });
  }

  void deleteProduct() {
    emit(state.copyWith(statusDelete: ViewState.loading));
    remoteDatasource.deleteProduct(idProduct: state.idProduct).then((value) {
      emit(state.copyWith(statusDelete: ViewState.hasData));
      emit(state.copyWith(statusDelete: ViewState.initial));
    }).catchError((e) {
      emit(state.copyWith(statusDelete: ViewState.error));
      emit(state.copyWith(statusDelete: ViewState.initial));
    });
  }
}
