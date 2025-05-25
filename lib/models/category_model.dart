class CategoryModel {
  final int categoryID;
  final String categoryName;
  final bool status;

  CategoryModel({
    required this.categoryID,
    required this.categoryName,
    required this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryID: json['categoryID'],
      categoryName: json['categoryName'],
      status: json['status'],
    );
  }
}
