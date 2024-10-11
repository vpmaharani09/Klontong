class ProductDto {
    String id;
    String name;
    String price;
    int quantity;
    String unitWeight;
    int stock;
    String imageUrl;
    String description;

    ProductDto({
        required this.id,
        required this.name,
        required this.price,
        required this.quantity,
        required this.unitWeight,
        required this.stock,
        required this.imageUrl,
        required this.description,
    });

    factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        unitWeight: json["unitWeight"],
        stock: json["stock"],
        imageUrl: json["imageUrl"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "unitWeight": unitWeight,
        "stock": stock,
        "imageUrl": imageUrl,
        "description": description,
    };
}
