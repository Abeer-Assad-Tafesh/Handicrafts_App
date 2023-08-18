class ProductImage {
  late int id;
  late int productId;
  late String imageUrl;

  ProductImage({
    required this.imageUrl,
  });

  ProductImage.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    productId= json['product_id'];
    imageUrl= json['image_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'image_url': imageUrl,
    };
  }
}
