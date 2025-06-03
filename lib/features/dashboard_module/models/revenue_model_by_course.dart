class RevenueModelByCourse {
  String? month;
  int? total;

  RevenueModelByCourse({this.month, this.total});

  RevenueModelByCourse.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['total'] = this.total;
    return data;
  }
}