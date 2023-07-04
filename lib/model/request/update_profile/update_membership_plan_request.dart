class MembershipRequestModel {
  String? spId;

  MembershipRequestModel({this.spId});

  MembershipRequestModel.fromJson(Map<String, dynamic> json) {
    spId = json['sp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sp_id'] = spId;
    return data;
  }
}