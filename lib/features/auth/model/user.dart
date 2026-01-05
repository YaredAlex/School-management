class User {
  final String id;
  final String? username;
  final String phone;
  final String role;
  final String firstName;
  final String lastName;
  final String? email;
  final String? nationalId;
  final DateTime? dateOfBirth;
  final String? address;
  final String? gender;
  final String? profilePicture;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.nationalId,
    this.dateOfBirth,
    this.address,
    this.gender,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String address = "";
    if (json['address'] != null) {
      address =
          "${json['address']['sub_city']} ${json['address']['woreda']} ${json['address']['house_number']}";
    }
    return User(
      id: json['id'].toString(),
      username: json['username'] ?? "",
      phone: json['phone'] ?? "",
      role: json['role_name'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'],
      nationalId: json['national_id'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      address: address,
      gender: json['gender'],
      profilePicture: json['profile_pic'],
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
      'username': username,
      'phone': phone,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'national_id': nationalId,
      'date_of_birth': dateOfBirth,
      'address': address,
      'gender': gender,
      'profile_picture': profilePicture,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
