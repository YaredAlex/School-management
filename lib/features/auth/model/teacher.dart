class TeacherModel {
  final String fullName;
  final String? profileUrl;
  final String? username;

  TeacherModel({
    required this.fullName,
    this.profileUrl,
    this.username,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      fullName: json['full_name'] ?? '',
      profileUrl: json['profile_url'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'profile_url': profileUrl,
      'username': username,
    };
  }
}
