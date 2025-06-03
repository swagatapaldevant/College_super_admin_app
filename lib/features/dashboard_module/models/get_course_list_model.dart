class GetCourseListModel {
  int? id;
  String? courseName;
  int? duration;
  List<Semester>? semester;

  GetCourseListModel({this.id, this.courseName, this.duration, this.semester});

  GetCourseListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    duration = json['duration'];
    if (json['semester'] != null) {
      semester = <Semester>[];
      json['semester'].forEach((v) {
        semester!.add(new Semester.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['duration'] = this.duration;
    if (this.semester != null) {
      data['semester'] = this.semester!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Semester {
  int? id;
  String? name;

  Semester({this.id, this.name});

  Semester.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}