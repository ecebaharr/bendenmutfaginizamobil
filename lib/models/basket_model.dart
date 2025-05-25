class BasketModel {
  final int basketID;
  final int productID;
  final int count;
  final double price;
  final double totalPrice;
  final int menuTableID;
  final String productName;

  BasketModel({
    required this.basketID,
    required this.productID,
    required this.count,
    required this.price,
    required this.totalPrice,
    required this.menuTableID,
    required this.productName,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      basketID: (json['basketID'] as num).toInt(),
      productID: (json['productID'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      menuTableID: (json['menuTableID'] as num).toInt(),
      productName: json['productName'] ?? 'Bilinmiyor',
    );
  }
}
