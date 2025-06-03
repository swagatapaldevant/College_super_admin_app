class AdmissionByMonthName {
  String? month;
  int? count;

  AdmissionByMonthName({this.month, this.count});

  AdmissionByMonthName.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['count'] = this.count;
    return data;
  }
}


class AdmissionByYear {
  int? year;
  int? count;

  AdmissionByYear({this.year, this.count});

  AdmissionByYear.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['count'] = this.count;
    return data;
  }
}