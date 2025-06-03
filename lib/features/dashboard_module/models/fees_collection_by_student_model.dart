class FeesCollectionBystudentModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? identificationNo;
  int? amount;
  String? paidOn;

  FeesCollectionBystudentModel(
      {this.firstName,
        this.middleName,
        this.lastName,
        this.identificationNo,
        this.amount,
        this.paidOn});

  FeesCollectionBystudentModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    identificationNo = json['identification_no'];
    amount = json['amount'];
    paidOn = json['paid_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['identification_no'] = this.identificationNo;
    data['amount'] = this.amount;
    data['paid_on'] = this.paidOn;
    return data;
  }
}