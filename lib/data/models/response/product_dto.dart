class ProductDto {
  String? id;
  String name;
  String description;
  int quantity;
  String unitDisplay;
  double price;
  int stock;
  String imageUrl;
  DateTime expiredDate;

  ProductDto({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.unitDisplay,
    required this.stock,
    required this.imageUrl,
    required this.description,
    required this.expiredDate,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
      id: json["_id"],
      name: json["name"],
      price: json["price"] == null
          ? null
          : json["price"] is int
              ? json["price"].toDouble()
              : json["price"],
      quantity: json["quantity"],
      unitDisplay: json["unitDisplay"],
      stock: json["stock"],
      imageUrl: json["imageUrl"] == null
          ? null
          : (json["imageUrl"] as String).startsWith('data:image')
              ? (json["imageUrl"] as String).split(',').last
              : json["imageUrl"],
      description: json["description"],
      expiredDate: DateTime.parse(json["expiredDate"]));

  Map<String, dynamic> toJson() => {
        if (id?.isNotEmpty ?? false) "_id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "unitDisplay": unitDisplay,
        "stock": stock,
        "imageUrl": imageUrl,
        "description": description,
        "expiredDate": expiredDate.toIso8601String(),
      };

  Map<String, dynamic> toJsonApi() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "unitDisplay": unitDisplay,
        "stock": stock,
        "imageUrl": imageUrl,
        "description": description,
        "expiredDate": expiredDate.toIso8601String(),
      };
}
