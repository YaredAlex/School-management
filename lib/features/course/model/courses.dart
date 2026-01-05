class Course {
  final int id;
  final String courseName;
  int classId;
  String? courseCode;
  int? instructorId;
  String? description;
  int? creditHours;
  bool? isActive;
  List<String>? metaData;
  String? imgUlr;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Course({
    required this.id,
    required this.courseName,
    required this.classId,
    this.instructorId,
    this.courseCode,
    this.description,
    this.creditHours,
    this.isActive,
    this.metaData,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imgUlr,
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        classId: json['grade'],
        courseName: json['subject'],
        creditHours: json['credit_hour'],
        courseCode: json['code'],
        instructorId: json['instructor_id'],
        description: json['description'],
        isActive: json['is_active'],
        // metaData: (json['metadata'] as List)?.cast<String>(),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        deletedAt: json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'])
            : null,
        imgUlr: json['course_img']);
  }
}
