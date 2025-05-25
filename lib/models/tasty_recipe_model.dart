class TastyRecipeModel {
  final String name;
  final String originalVideoUrl;
  final int totalTimeMinutes;
  final String thumbnailUrl;

  TastyRecipeModel({
    required this.name,
    required this.originalVideoUrl,
    required this.totalTimeMinutes,
    required this.thumbnailUrl,
  });

  factory TastyRecipeModel.fromJson(Map<String, dynamic> json) {
    return TastyRecipeModel(
      name: json['name'] ?? '',
      originalVideoUrl: json['original_video_url'] ?? '',
      totalTimeMinutes: json['total_time_minutes'] ?? 0,
      thumbnailUrl: json['thumbnail_url'] ?? '',
    );
  }
}
