class MenuTableModel {
  final int menuTableID;
  final String name;
  final bool status; // false = boş, true = dolu

  MenuTableModel({
    required this.menuTableID,
    required this.name,
    required this.status,
  });

  factory MenuTableModel.fromJson(Map<String, dynamic> json) {
    return MenuTableModel(
      menuTableID: json['menuTableID'],
      name: json['name'],
      status: json['status'],
    );
  }
}
