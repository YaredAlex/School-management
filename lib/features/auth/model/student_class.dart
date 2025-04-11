import 'package:school_managment/features/auth/model/teacher.dart';

class ClassModel {
  final int id;
  final String className;
  final String section;
  final String academicYear;
  final String description;
  final int? homeroomTeacherId;
  final int? secondaryTeacherId;
  final int maxStudents;
  final bool isActive;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TeacherModel? homeroomTeacher;
  final TeacherModel? secondaryTeacher;

  ClassModel({
    required this.id,
    required this.className,
    required this.section,
    required this.academicYear,
    required this.description,
    this.homeroomTeacherId,
    this.secondaryTeacherId,
    required this.maxStudents,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.homeroomTeacher,
    this.secondaryTeacher,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      className: json['class_name'],
      section: json['section'],
      academicYear: json['academic_year'],
      description: json['description'],
      homeroomTeacherId: json['homeroom_teacher_id'],
      secondaryTeacherId: json['secondary_teacher_id'],
      maxStudents: json['max_students'],
      isActive: json['is_active'] == 1,
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      homeroomTeacher: json['homeroom_teacher'] != null
          ? TeacherModel.fromJson(json['homeroom_teacher'])
          : null,
      secondaryTeacher: json['secondary_teacher'] != null
          ? TeacherModel.fromJson(json['secondary_teacher'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_name': className,
      'section': section,
      'academic_year': academicYear,
      'description': description,
      'homeroom_teacher_id': homeroomTeacherId,
      'secondary_teacher_id': secondaryTeacherId,
      'max_students': maxStudents,
      'is_active': isActive ? 1 : 0,
      'deleted_at': deletedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'homeroom_teacher': homeroomTeacher?.toJson(),
      'secondary_teacher': secondaryTeacher?.toJson(),
    };
  }
}
