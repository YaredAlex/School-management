class GalleryModel {
  final int id;
  final String title;
  final String? description;
  final String image; // full URL from API
  final int? uploadedBy;
  final DateTime createdAt;

  GalleryModel({
    required this.id,
    required this.title,
    this.description,
    required this.image,
    this.uploadedBy,
    required this.createdAt,
  });

  /// ---- JSON Factory ----
  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      image: json['image'] ?? '',
      uploadedBy: json['uploaded_by'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// ---- Convert to JSON ----
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "uploaded_by": uploadedBy,
      "created_at": createdAt.toIso8601String(),
    };
  }
}
