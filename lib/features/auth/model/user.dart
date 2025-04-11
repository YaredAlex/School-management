class User {
  final int id;
  final String userName;
  final String phoneNumber;
  final String role;
  final String firstName;
  final String lastName;
  final String? profileUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
    this.profileUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileUrl: json['profile_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'phone_number': phoneNumber,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'profile_url': profileUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
