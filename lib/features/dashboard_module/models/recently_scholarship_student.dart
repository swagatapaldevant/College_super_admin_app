class RecentlyScholarshipStudent {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? identificationNo;

  RecentlyScholarshipStudent(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.identificationNo});

  RecentlyScholarshipStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    identificationNo = json['identification_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['identification_no'] = this.identificationNo;
    return data;
  }
}