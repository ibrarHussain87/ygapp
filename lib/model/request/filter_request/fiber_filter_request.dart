class FiberFilterRequestModel {

  String? userId;
  String? isOffering;
  String? productionYear;
  List<int>? gradeId;
  List<int>? fiberMaterialId;
  List<int>? originId;
  List<int>? apperanceId;
  List<int>? certificationId;
  List<int>? packingId;
  List<int>? micronaire;
  List<int>? moisture;

  FiberFilterRequestModel({this.userId, this.gradeId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId!.trim(),
      'grade_id[]': gradeId,
      'fiber_material_id[]': fiberMaterialId,
      'origin_id[]': originId??"",
      'apperance_id[]': apperanceId,
      'production_year': productionYear,
      'certification_id[]': certificationId,
      'packing_id[]': packingId,
      'micronaire[]': micronaire,
      'moisture[]': moisture,
    };

    return map;
  }

}
