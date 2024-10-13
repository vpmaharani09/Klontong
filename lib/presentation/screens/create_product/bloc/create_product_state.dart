import 'package:image_picker/image_picker.dart';
import 'package:klontong/data/data.dart';
import 'package:klontong/presentation/presentation.dart';

class CreateProductState {
  CreateProductState({
    this.id,
    required this.response,
    this.name = '',
    this.description = '',
    this.imageUrl = '',
    this.unitDisplay = 'kg',
    this.quantity = 0,
    this.stock = 0,
    this.price = 0,
    this.expiredDate,
    required this.filePickerResult,
    this.isEdit = false,
  });

  final ViewData<BaseResponseDto> response;
  final ViewData<XFile> filePickerResult;
  final String name;
  final String description;
  final int quantity;
  final String unitDisplay;
  final double price;
  final int stock;
  final String imageUrl;
  final DateTime? expiredDate;
  final String? id;
  final bool isEdit;

  ProductDto get product => ProductDto(
        id: id,
        name: name,
        description: description,
        quantity: quantity,
        unitDisplay: unitDisplay,
        price: price,
        stock: stock,
        imageUrl: imageUrl,
        expiredDate: expiredDate!,
      );

  bool get isValid =>
      name.isNotEmpty &&
      description.isNotEmpty &&
      quantity >= 0 &&
      imageUrl.isNotEmpty &&
      unitDisplay.isNotEmpty &&
      stock >= 0 &&
      price >= 0 &&
      expiredDate != null;

  CreateProductState copyWith({
    ViewData<BaseResponseDto>? response,
    String? name,
    String? description,
    int? quantity,
    String? unitDisplay,
    double? price,
    int? stock,
    String? imageUrl,
    DateTime? expiredDate,
    ViewData<XFile>? filePickerResult,
    String? id,
    bool? isEdit,
  }) {
    return CreateProductState(
      id: id ?? this.id,
      isEdit: isEdit ?? this.isEdit,
      response: response ?? this.response,
      expiredDate: expiredDate ?? this.expiredDate,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      stock: stock ?? this.stock,
      unitDisplay: unitDisplay ?? this.unitDisplay,
      filePickerResult: filePickerResult ?? this.filePickerResult,
    );
  }
}
