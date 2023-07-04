class CertificationModel {
  Certification? certification;

  CertificationModel({this.certification});

  CertificationModel.fromJson(Map<String, dynamic> json) {
    certification = json['certification'] != null
        ? Certification.fromJson(json['certification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (certification != null) {
      data['certification'] = certification!.toJson();
    }
    return data;
  }
}

class Certification {
  String? name;
  String? icon;

  Certification({this.name, this.icon});

  Certification.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}