class DiscountModel {
  final int discountID;
  final String title;
  final String description;
  final int amount;
  final String imageUrl;

  DiscountModel({
    required this.discountID,
    required this.title,
    required this.description,
    required this.amount,
    required this.imageUrl,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      discountID: json['discountID'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      amount: int.tryParse(json['amount'].toString()) ?? 0,
      imageUrl: json['imageUrl'] ?? '', // artık API'den geliyor
    );
  }



  // Manuel olarak görsel URL'lerini setlemek için yardımcı
  DiscountModel copyWithImage(String url) {
    return DiscountModel(
      discountID: discountID,
      title: title,
      description: description,
      amount: amount,
      imageUrl: url,
    );
  }
}
