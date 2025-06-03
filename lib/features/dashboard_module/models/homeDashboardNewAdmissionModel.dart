class HomeDashboardNewAdmissionModel {
  String? name;
  String? gender;
  String? admissionDate;
  String? identificationNo;

  HomeDashboardNewAdmissionModel({this.name, this.gender, this.admissionDate, this.identificationNo});

  HomeDashboardNewAdmissionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    admissionDate = json['admission_date'];
    identificationNo = json['identification_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['admission_date'] = this.admissionDate;
    data['identification_no'] = this.identificationNo;
    return data;
  }
}