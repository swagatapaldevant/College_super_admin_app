class SemesterDetailsByCourseModel {
  int? courseId;
  int? semesterId;
  String? courseName;
  String? semesterName;
  int? sessionId;
  int? sessionName;
  int? totalStudents;
  int? totalAmount;
  int? amountPaid;
  int? scholarshipAmount;
  int? concessionAmount;
  int? dueAmount;

  SemesterDetailsByCourseModel(
      {this.courseId,
        this.semesterId,
        this.courseName,
        this.semesterName,
        this.sessionId,
        this.sessionName,
        this.totalStudents,
        this.totalAmount,
        this.amountPaid,
        this.scholarshipAmount,
        this.concessionAmount,
        this.dueAmount});

  SemesterDetailsByCourseModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    semesterId = json['semester_id'];
    courseName = json['course_name'];
    semesterName = json['semester_name'];
    sessionId = json['session_id'];
    sessionName = json['session_name'];
    totalStudents = json['total_students'];
    totalAmount = json['total_amount'];
    amountPaid = json['amount_paid'];
    scholarshipAmount = json['scholarship_amount'];
    concessionAmount = json['concession_amount'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['semester_id'] = this.semesterId;
    data['course_name'] = this.courseName;
    data['semester_name'] = this.semesterName;
    data['session_id'] = this.sessionId;
    data['session_name'] = this.sessionName;
    data['total_students'] = this.totalStudents;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['scholarship_amount'] = this.scholarshipAmount;
    data['concession_amount'] = this.concessionAmount;
    data['due_amount'] = this.dueAmount;
    return data;
  }
}