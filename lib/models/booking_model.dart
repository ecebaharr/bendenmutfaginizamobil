class BookingModel {
  final String name;
  final String phone;
  final String mail;
  final int personCount;
  final String description; // ✅ yeni eklendi
  final String date;

  BookingModel({
    required this.name,
    required this.phone,
    required this.mail,
    required this.personCount,
    required this.description, // ✅ yeni eklendi
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "mail": mail,
      "personCount": personCount,
      "description": description, // ✅
      "date": date,
    };
  }
}
