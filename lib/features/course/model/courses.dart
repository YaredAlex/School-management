class Course {
  final int id;
  final String courseName;
  int classId;
  int? instructorId;
  String courseCode;
  String description;
  int creditHours;
  bool isActive;
  List<String>? metaData;
  String? imgUlr;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  Course({
    required this.id,
    required this.courseName,
    required this.classId,
    this.instructorId,
    required this.courseCode,
    required this.description,
    required this.creditHours,
    required this.isActive,
    this.metaData,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.imgUlr,
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        classId: json['class_id'],
        courseName: json['course_name'],
        instructorId: json['instructor_id'],
        courseCode: json['course_code'],
        description: json['description'],
        creditHours: json['credit_hours'],
        isActive: json['is_active'],
        metaData: (json['metadata'] as List)?.cast<String>(),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'])
            : json['deleted_at'],
        imgUlr: json['course_img']);
  }
}
