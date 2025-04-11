import 'package:school_managment/features/auth/model/student_class.dart';

class Student {
  final int id;
  final String parentPhoneNumber;
  final String name;
  final String rollNumber;
  final String academicYear;
  final DateTime dateOfAdmission;
  final String fatherName;
  final String motherName;
  final DateTime dateOfBirth;
  final String address;
  final String profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ClassModel classModel;

  Student({
    required this.id,
    required this.parentPhoneNumber,
    required this.name,
    required this.rollNumber,
    required this.academicYear,
    required this.dateOfAdmission,
    required this.fatherName,
    required this.motherName,
    required this.dateOfBirth,
    required this.address,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
    required this.classModel,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      parentPhoneNumber: json['parent_phone_number'],
      name: json['name'],
      rollNumber: json['roll_number'],
      academicYear: json['academic_year'],
      dateOfAdmission: DateTime.parse(json['date_of_admission']),
      fatherName: json['father_name'],
      motherName: json['mother_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      address: json['address'],
      profilePicture: json['profile_picture'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      classModel: ClassModel.fromJson(json['class']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_phone_number': parentPhoneNumber,
      'name': name,
      'roll_number': rollNumber,
      'academic_year': academicYear,
      'date_of_admission': dateOfAdmission.toIso8601String(),
      'father_name': fatherName,
      'mother_name': motherName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'address': address,
      'profile_picture': profilePicture,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'class': classModel.toJson(),
    };
  }
}
