class MessageModel {
  final String nameSurname;
  final String mail;
  final String phone;
  final String subject;
  final String messageContent;

  MessageModel({
    required this.nameSurname,
    required this.mail,
    required this.phone,
    required this.subject,
    required this.messageContent,
  });

  Map<String, dynamic> toJson() {
    return {
      "nameSurname": nameSurname,
      "mail": mail,
      "phone": phone,
      "subject": subject,
      "messageContent": messageContent,
      "messageSendDate": DateTime.now().toIso8601String(),
      "status": true,
    };
  }

}
