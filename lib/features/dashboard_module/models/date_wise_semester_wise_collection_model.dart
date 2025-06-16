class DateWiseSemesterWiseCollectionModel {
  int? courseId;
  String? courseName;
  int? semesterId;
  String? semesterName;
  int? totalSum;

  DateWiseSemesterWiseCollectionModel(
      {this.courseId,
        this.courseName,
        this.semesterId,
        this.semesterName,
        this.totalSum});

  DateWiseSemesterWiseCollectionModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    semesterId = json['semester_id'];
    semesterName = json['semester_name'];
    totalSum = json['total_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['semester_id'] = this.semesterId;
    data['semester_name'] = this.semesterName;
    data['total_sum'] = this.totalSum;
    return data;
  }
}