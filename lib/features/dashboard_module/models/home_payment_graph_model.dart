class HomePaymentGraphModel {
  String? date;
  int? cash;
  int? others;

  HomePaymentGraphModel({this.date, this.cash, this.others});

  HomePaymentGraphModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    cash = json['cash'];
    others = json['others'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['cash'] = this.cash;
    data['others'] = this.others;
    return data;
  }
}