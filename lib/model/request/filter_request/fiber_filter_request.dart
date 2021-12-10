class GetSpecificationRequestModel {
  String? userId;
  String? categoryId;
  String? isOffering;
  String? productionYear;
  String? locality;
  List<int>? gradeId;
  List<int>? fiberMaterialId;
  List<int>? originId;
  List<int>? apperanceId;
  List<int>? certificationId;
  List<int>? packingId;
  List<int>? micronaire;
  List<int>? moisture;

  GetSpecificationRequestModel(
      {this.userId,
      this.categoryId,
      this.isOffering,
      this.productionYear,
      this.locality,
      this.gradeId,
      this.fiberMaterialId,
      this.originId,
      this.apperanceId,
      this.certificationId,
      this.packingId,
      this.micronaire,
      this.moisture});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId!.trim(),
      'category_id': categoryId!.trim(),
      'grade_id[]': gradeId,
      'locality': locality,
      'is_offering': isOffering,
      'fiber_material_id[]': fiberMaterialId,
      'origin_id[]': originId ?? "",
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
