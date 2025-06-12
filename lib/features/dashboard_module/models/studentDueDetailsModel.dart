class StudentDetailsByCourseDueModel {
  int? id;
  String? fullName;
  String? semesterName;
  int? tuitionFees;
  int? developmentFees;
  int? semesterFees;
  int? totalAmount;
  int? amountPaid;
  int? scholarshipAmount;
  int? concessionAmount;
  int? dueAmount;

  StudentDetailsByCourseDueModel(
      {this.id,
        this.fullName,
        this.semesterName,
        this.tuitionFees,
        this.developmentFees,
        this.semesterFees,
        this.totalAmount,
        this.amountPaid,
        this.scholarshipAmount,
        this.concessionAmount,
        this.dueAmount});

  StudentDetailsByCourseDueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    semesterName = json['semester_name'];
    tuitionFees = json['Tuition fees'];
    developmentFees = json['Development fees'];
    semesterFees = json['Semester Fees'];
    totalAmount = json['total_amount'];
    amountPaid = json['amount_paid'];
    scholarshipAmount = json['scholarship_amount'];
    concessionAmount = json['concession_amount'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['semester_name'] = this.semesterName;
    data['Tuition fees'] = this.tuitionFees;
    data['Development fees'] = this.developmentFees;
    data['Semester Fees'] = this.semesterFees;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['scholarship_amount'] = this.scholarshipAmount;
    data['concession_amount'] = this.concessionAmount;
    data['due_amount'] = this.dueAmount;
    return data;
  }
}