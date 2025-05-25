class SliderModel {
  final int sliderID;
  final String title1;
  final String title2;
  final String title3;
  final String description1;
  final String description2;
  final String description3;
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;

  SliderModel({
    required this.sliderID,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      sliderID: json['sliderID'],
      title1: json['title1'] ?? '',
      title2: json['title2'] ?? '',
      title3: json['title3'] ?? '',
      description1: json['description1'] ?? '',
      description2: json['description2'] ?? '',
      description3: json['description3'] ?? '',
      imageUrl1: 'https://www.ilkhaber-gazetesi.com/static/2024/06/08/izmir-kofte-tarifi-geleneksel-lezzetin-ev-yapimi-sirri-1717873973-643_large.webp', // örnek görsel
      imageUrl2: 'https://picsum.photos/400/200?2',
      imageUrl3: 'https://picsum.photos/400/200?3',
    );
  }
}
