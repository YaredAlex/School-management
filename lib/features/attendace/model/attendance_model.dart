class AttendanceModel {
  DateTime? date;
  int? totalRecords;
  int? absentCount;
  double? absentPercentage;
  List<AbsentRecord>? absentRecords;

  AttendanceModel({
    this.date,
    this.totalRecords,
    this.absentCount,
    this.absentPercentage,
    this.absentRecords,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      date: DateTime.tryParse(json['date']),
      totalRecords: json['total_records'],
      absentCount: json['absent_count'],
      absentPercentage: double.tryParse(json['absent_percentage'].toString()),
      absentRecords: (json['absent_records'] as List<dynamic>?)
          ?.map((e) => AbsentRecord.fromJson(e))
          .toList(),
    );
  }
}

class AbsentRecord {
  int? id;
  String? course;
  String? section;
  String? status;

  AbsentRecord({
    this.id,
    this.course,
    this.section,
    this.status,
  });

  factory AbsentRecord.fromJson(Map<String, dynamic> json) {
    return AbsentRecord(
      id: json['id'],
      course: json['course'],
      section: json['section'],
      status: json['status'],
    );
  }
}
