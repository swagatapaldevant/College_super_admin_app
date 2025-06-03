class HomeDashboardNoticeModel {
  int? id;
  String? subject;
  String? body;
  String? mailedTo;
  String? publishedOn;
  int? franchiseId;
  String? createdAt;
  String? updatedAt;

  HomeDashboardNoticeModel(
      {this.id,
        this.subject,
        this.body,
        this.mailedTo,
        this.publishedOn,
        this.franchiseId,
        this.createdAt,
        this.updatedAt});

  HomeDashboardNoticeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    body = json['body'];
    mailedTo = json['mailed_to'];
    publishedOn = json['published_on'];
    franchiseId = json['franchise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['body'] = this.body;
    data['mailed_to'] = this.mailedTo;
    data['published_on'] = this.publishedOn;
    data['franchise_id'] = this.franchiseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}