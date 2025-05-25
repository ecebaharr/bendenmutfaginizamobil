class ProductModel {
  final int productID;
  final String productName;
  final String description;
  final double price;
  final String imageUrl;
  final bool productStatus;
  final int categoryId;

  ProductModel({
    required this.productID,
    required this.productName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.productStatus,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String rawUrl = json['imageUrl'] ?? '';
    String cleanUrl = rawUrl.replaceFirst('~', '');

    // 🛡️ Eğer zaten http veya https ile başlıyorsa, olduğu gibi bırak
    String finalUrl = cleanUrl.startsWith('http')
        ? cleanUrl
        : "http://10.0.2.2:5044$cleanUrl";

    return ProductModel(
      productID: json['productID'],
      productName: json['productName'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl: finalUrl,
      productStatus: json['productStatus'] ?? true,
      categoryId: json['categoryID'],
    );
  }

}
