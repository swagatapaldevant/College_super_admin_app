class SessionListModel {
  int? id;
  int? name;
  int? franchiseId;
  String? createdAt;
  String? updatedAt;

  SessionListModel(
      {this.id, this.name, this.franchiseId, this.createdAt, this.updatedAt});

  SessionListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    franchiseId = json['franchise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['franchise_id'] = this.franchiseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}