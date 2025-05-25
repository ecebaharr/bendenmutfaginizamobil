class TestimonialModel {
  final int testimonialID;
  final String name;
  final String title;
  final String comment;
  final String imageUrl;
  final bool status;

  TestimonialModel({
    required this.testimonialID,
    required this.name,
    required this.title,
    required this.comment,
    required this.imageUrl,
    required this.status,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    String rawUrl = json['imageUrl'] ?? '';
    String cleanUrl = rawUrl.replaceFirst('~', '');

    // ✅ Eğer zaten http ile başlıyorsa dokunma, değilse baseUrl ekle
    String finalUrl = cleanUrl.startsWith('http')
        ? cleanUrl
        : "http://10.0.2.2:5044$cleanUrl";

    return TestimonialModel(
      testimonialID: json['testimonialID'],
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      comment: json['comment'] ?? '',
      imageUrl: finalUrl,
      status: json['status'] ?? false,
    );
  }

}
