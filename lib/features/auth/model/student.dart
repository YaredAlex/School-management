class StudentModel {
  final int id;
  final String? gradeName;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? nationalId;
  final DateTime? dateOfBirth;
  final String? birthPlace;
  final String? picture;
  final String? idNumber;
  final DateTime? dateOfAdmission;
  final String? nationality;
  final String? healthProblems;
  final String? previousSchool;
  final String? subCity;
  final String? woreda;
  final String? houseNumber;
  final String? academicYear;

  // Mother
  final String? motherFirstName;
  final String? motherLastName;
  final String? motherOccupation;
  final String? motherPhone;
  final String? motherOfficePhone;
  final String? motherEmail;

  // Father
  final String? fatherFirstName;
  final String? fatherLastName;
  final String? fatherOccupation;
  final String? fatherEmail;
  final String? fatherPhone;
  final String? fatherOfficePhone;

  // Emergency Contact
  final String? emergencyName;
  final String? emergencyPhone;

  final int? entranceExamScore;
  final DateTime? createdAt;

  final dynamic documents;

  final int? section;
  final String? section_name;
  final String? phone;

  StudentModel({
    required this.id,
    this.gradeName,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.nationalId,
    this.dateOfBirth,
    this.birthPlace,
    this.picture,
    this.idNumber,
    this.dateOfAdmission,
    this.nationality,
    this.academicYear,
    this.healthProblems,
    this.previousSchool,
    this.subCity,
    this.woreda,
    this.houseNumber,
    this.motherFirstName,
    this.motherLastName,
    this.motherOccupation,
    this.motherPhone,
    this.motherOfficePhone,
    this.motherEmail,
    this.fatherFirstName,
    this.fatherLastName,
    this.fatherOccupation,
    this.fatherEmail,
    this.fatherPhone,
    this.fatherOfficePhone,
    this.emergencyName,
    this.emergencyPhone,
    this.entranceExamScore,
    this.createdAt,
    this.documents,
    this.section,
    this.section_name,
    this.phone,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      gradeName: json['grade_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      nationalId: json['national_id'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'])
          : null,
      birthPlace: json['birth_place'],
      picture: json['picture'],
      idNumber: json['id_number'],
      dateOfAdmission: json['date_of_admission'] != null
          ? DateTime.tryParse(json['date_of_admission'])
          : null,
      nationality: json['nationality'],
      academicYear: json['academic_year'],
      healthProblems: json['health_problems'],
      previousSchool: json['previous_school'],
      subCity: json['sub_city'],
      woreda: json['woreda'],
      houseNumber: json['house_number'],
      motherFirstName: json['mother_first_name'],
      motherLastName: json['mother_last_name'],
      motherOccupation: json['mother_occupation'],
      motherPhone: json['mother_phone'],
      motherOfficePhone: json['mother_office_phone'],
      motherEmail: json['mother_email'],
      fatherFirstName: json['father_first_name'],
      fatherLastName: json['father_last_name'],
      fatherOccupation: json['father_occupation'],
      fatherEmail: json['father_email'],
      fatherPhone: json['father_phone'],
      fatherOfficePhone: json['father_office_phone'],
      emergencyName: json['emergency_name'],
      emergencyPhone: json['emergency_phone'],
      entranceExamScore: json['entrance_exam_score'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      documents: json['documents'],
      section: json['section'],
      section_name: json['section_name'],
      phone: json['phone']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grade_name': gradeName,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'national_id': nationalId,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'birth_place': birthPlace,
      'picture': picture,
      'id_number': idNumber,
      'date_of_admission': dateOfAdmission?.toIso8601String(),
      'nationality': nationality,
      'health_problems': healthProblems,
      'previous_school': previousSchool,
      'sub_city': subCity,
      'woreda': woreda,
      'house_number': houseNumber,
      'mother_first_name': motherFirstName,
      'mother_last_name': motherLastName,
      'mother_occupation': motherOccupation,
      'mother_phone': motherPhone,
      'mother_office_phone': motherOfficePhone,
      'mother_email': motherEmail,
      'father_first_name': fatherFirstName,
      'father_last_name': fatherLastName,
      'father_occupation': fatherOccupation,
      'father_email': fatherEmail,
      'father_phone': fatherPhone,
      'father_office_phone': fatherOfficePhone,
      'emergency_name': emergencyName,
      'emergency_phone': emergencyPhone,
      'entrance_exam_score': entranceExamScore,
      'created_at': createdAt?.toIso8601String(),
      'documents': documents,
      'section': section,
      'phone': phone,
    };
  }

  String get fatherName => "$fatherFirstName $fatherLastName";
  String get motherName => "$motherFirstName $motherLastName";
  String get fullName => "$firstName $lastName";
  String get address => "$subCity $woreda $houseNumber";
}
