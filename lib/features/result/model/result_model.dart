class SemesterResultModel {
  String? semester;
  int? year;
  List<CourseResult> records;

  SemesterResultModel({this.semester, this.year, required this.records});

  factory SemesterResultModel.fromJson(Map<String, dynamic> json) {
    return SemesterResultModel(
      semester: json['semester'],
      year: json['year'],
      records: (json['records'] as List<dynamic>?)
              ?.map((e) => CourseResult.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'semester': semester,
        'year': year,
        'records': records?.map((e) => e.toJson()).toList(),
      };
}

class CourseResult {
  String? course;
  List<AssessmentResult> results;

  CourseResult({this.course, required this.results});

  factory CourseResult.fromJson(Map<String, dynamic> json) {
    return CourseResult(
      course: json['course'],
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => AssessmentResult.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'course': course,
        'results': results?.map((e) => e.toJson()).toList(),
      };
}

class AssessmentResult {
  String? assessmentType;
  double? score;
  String? remark;

  AssessmentResult({this.assessmentType, this.score, this.remark});

  factory AssessmentResult.fromJson(Map<String, dynamic> json) {
    return AssessmentResult(
      assessmentType: json['assessment_type'],
      score: json['score'] != null
          ? double.tryParse(json['score'].toString())
          : null,
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() => {
        'assessment_type': assessmentType,
        'score': score,
        'remark': remark,
      };
}
