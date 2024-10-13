import 'package:klontong/data/models/response/product_dto.dart';

class CreateArgs {
  CreateArgs({
    this.product,
    this.isEdit = false,
  });

  final ProductDto? product;
  final bool isEdit;
}
