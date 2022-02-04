class MarkYgResponse {
  final bool? status;
  final int? responseCode;
  final Data? data;
  final String? message;

  MarkYgResponse({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  MarkYgResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        responseCode = json['response_code'] as int?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'response_code' : responseCode,
    'data' : data?.toJson(),
    'message' : message
  };
}

class Data {
  final String? userId;
  final String? categoryId;
  final String? specificationId;
  final int? id;

  Data({
    this.userId,
    this.categoryId,
    this.specificationId,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as String?,
        categoryId = json['category_id'] as String?,
        specificationId = json['specification_id'] as String?,
        id = json['id'] as int?;

  Map<String, dynamic> toJson() => {
    'user_id' : userId,
    'category_id' : categoryId,
    'specification_id' : specificationId,
    'id' : id
  };
}