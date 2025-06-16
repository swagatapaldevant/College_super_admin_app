class CollectBySessionModel {
  String? date;
  int? totalSum;

  CollectBySessionModel({this.date, this.totalSum});

  CollectBySessionModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalSum = json['total_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['total_sum'] = this.totalSum;
    return data;
  }
}