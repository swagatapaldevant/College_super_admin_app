class DateWiseCourseCollectionModel {
  int? courseId;
  String? courseName;
  int? totalSum;

  DateWiseCourseCollectionModel(
      {this.courseId, this.courseName, this.totalSum});

  DateWiseCourseCollectionModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    totalSum = json['total_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['total_sum'] = this.totalSum;
    return data;
  }
}