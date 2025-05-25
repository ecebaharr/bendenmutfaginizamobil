class FooterModel {
  final int contactID;
  final String location;
  final String phone;
  final String mail;
  final String footerDescription;
  final String footerTitle;
  final String openDays;
  final String openDaysDescription;
  final String openHours;

  FooterModel({
    required this.contactID,
    required this.location,
    required this.phone,
    required this.mail,
    required this.footerDescription,
    required this.footerTitle,
    required this.openDays,
    required this.openDaysDescription,
    required this.openHours,
  });

  factory FooterModel.fromJson(Map<String, dynamic> json) {
    return FooterModel(
      contactID: json['contactID'],
      location: json['location'],
      phone: json['phone'],
      mail: json['mail'],
      footerDescription: json['footerDescripton'], // ← düzeltildi
      footerTitle: json['footerTitle'],
      openDays: json['openDays'],
      openDaysDescription: json['openDaysDescripton'], // ← düzeltildi
      openHours: json['openHours'],
    );
  }


}
