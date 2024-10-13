import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/core/extension/datetime_extension.dart';
import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit({
    required this.remoteDatasource,
    ProductDto? product,
    bool isEdit = false,
  }) : super(
          CreateProductState(
            isEdit: isEdit,
            id: product?.id,
            response: ViewData.initial(),
            filePickerResult: ViewData.initial(),
            name: product?.name ?? '',
            description: product?.description ?? '',
            quantity: product?.quantity ?? 0,
            unitDisplay: product?.unitDisplay ?? UnitDisplayEnum.kg.name,
            stock: product?.stock ?? 0,
            price: product?.price ?? 0,
            imageUrl: product?.imageUrl ?? '',
            expiredDate: product?.expiredDate ?? DateTime.now().startOfDay(),
          ),
        );

  final RemoteDatasource remoteDatasource;

  void submitProduct() {
    if (state.isEdit) {
      _editProduct();
    } else {
      _createProduct();
    }
  }

  void _editProduct() {
    emit(state.copyWith(response: ViewData.loading()));
    remoteDatasource.updateProduct(product: state.product).then((value) {
      emit(state.copyWith(response: ViewData.loaded(data: value)));
      emit(state.copyWith(response: ViewData.initial()));
    }).catchError((e) {
      emit(state.copyWith(
          response: ViewData.error(message: 'Update the product is failed!')));
      emit(state.copyWith(response: ViewData.initial()));
    });
  }

  void _createProduct() {
    emit(state.copyWith(response: ViewData.loading()));
    remoteDatasource.createProduct(product: state.product).then((value) {
      emit(state.copyWith(response: ViewData.loaded(data: value)));
      emit(state.copyWith(response: ViewData.initial()));
    }).catchError((e) {
      emit(state.copyWith(
          response: ViewData.error(message: 'Create new product is failed!')));
      emit(state.copyWith(response: ViewData.initial()));
    });
  }

  void pickImage({
    required SourceImageEnum source,
    String lastState = '',
  }) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? result;
      if (source == SourceImageEnum.camera) {
        result = await picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
        );
      } else {
        result = await picker.pickImage(
          source: ImageSource.gallery,
        );
      }

      if (result == null) {
        return;
      }

      Uint8List bytes = await result.readAsBytes();
      final compressedImage = await ImageCompressorUtils.compress(bytes);
      final bytesLength = compressedImage.lengthInBytes;
      final kb = bytesLength / 1024;

      if (kb > 100) {
        emit(
          state.copyWith(
            filePickerResult: ViewData.error(
              message: 'Photo should be lower than 100Kb',
            ),
          ),
        );
        emit(state.copyWith(filePickerResult: ViewData.initial()));
        return;
      }

      String base64Image = ImageCompressorUtils.removeMetadataFromBase64(
        base64Encode(bytes),
      );

      emit(
        state.copyWith(
          filePickerResult: ViewData.loaded(data: result),
          imageUrl: base64Image,
        ),
      );
      emit(state.copyWith(filePickerResult: ViewData.initial()));
    } catch (e) {
      emit(
        state.copyWith(
          filePickerResult: ViewData.error(
            message: 'Gagal ambil file',
          ),
        ),
      );
      emit(state.copyWith(filePickerResult: ViewData.initial()));
    }
  }

  void onChangeName(String? name) {
    emit(state.copyWith(name: name));
  }

  void onChangeDesc(String? desc) {
    emit(state.copyWith(description: desc));
  }

  void onChangeQuantity(String? q) {
    if (q?.isEmpty ?? true) return;
    emit(state.copyWith(quantity: int.tryParse(q!)));
  }

  void onChangeUnit(String? name) {
    emit(state.copyWith(unitDisplay: name));
  }

  void onChangeStock(String? q) {
    if (q?.isEmpty ?? true) return;
    emit(state.copyWith(stock: int.tryParse(q!)));
  }

  void onChangePrice(String? q) {
    if (q?.isEmpty ?? true) return;
    emit(state.copyWith(price: double.tryParse(q!)));
  }

  void onChangeDateTime(DateTime? date) {
    emit(state.copyWith(expiredDate: date));
  }

  void onChangeImage(XFile? file) async {
    if (file == null) return;

    Uint8List bytes = await file.readAsBytes();
    String base64Image = base64Encode(bytes);

    emit(state.copyWith(imageUrl: base64Image));
  }
}
