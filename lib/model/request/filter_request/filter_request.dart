class GetSpecificationRequestModel {
  // String? userId;
  String? categoryId;
  String? spcFiberFamilyIdfk;
  String? isOffering;
  String? productionYear;
  String? locality;

  String? ys_color_code;
  List<int>? ys_dying_method_idfk;
  List<int>? yarnYypeId;
  List<int>? yuId;
  List<int>? plyId;
  List<int>? colorTreatmentId;
  List<int>? orientationId;
  List<int>? twistDirectionId;
  List<int>? spunTechId;
  List<int>? qualityId;
  List<int>? patternId;
  List<int>? doublingMethodId;

  List<int>? gradeId;
  List<int>? fbBlendIdfk;
  List<int>? originId;
  List<int>? apperanceId;
  List<int>? apperanceYarnId;
  List<int>? certificationId;
  List<int>? packingId;
  List<int>? patternCharId;
  List<double>? micronaire;
  List<double>? moisture;
  List<double>? rd;
  List<double>? gpt;

  //Yarn Keys
  List<int>? ysBlendIdFk;
  List<int>? ysFamilyIdFk;

  GetSpecificationRequestModel(
      {
//      this.categoryId,
      this.isOffering,
      this.productionYear,
      this.ys_dying_method_idfk,
      this.locality,
      this.gradeId,
      this.spcFiberFamilyIdfk,
      this.apperanceYarnId,
      this.fbBlendIdfk,
      this.originId,
      this.apperanceId,
      this.certificationId,
      this.packingId,
      this.micronaire,
      this.moisture,
      this.rd,
      this.gpt,
      this.ysBlendIdFk,
      this.patternCharId,
      this.ys_color_code,
      this.yarnYypeId,
      this.yuId,
      this.plyId,
      this.colorTreatmentId,
      this.orientationId,
      this.twistDirectionId,
      this.spunTechId,
      this.qualityId,
      this.doublingMethodId,
      this.patternId,
      this.ysFamilyIdFk});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      // 'user_id': userId!.trim(),
      'category_id': categoryId!.trim(),
      'grade_id[]': gradeId,
      'spc_fiber_family_idfk[]': spcFiberFamilyIdfk,
      'locality': locality,
      'is_offering': isOffering,
      'fb_blend_idfk': fbBlendIdfk,
      'origin_id[]': originId ?? "",
      'apperance_id': apperanceId,
      'production_year': productionYear,
      'certification_id[]': certificationId,
      'packing_id[]': packingId,
      'micronaire[]': micronaire,
      'moisture[]': moisture,
      'rd': rd,
      'ys_dying_method_idfk': ys_dying_method_idfk,
      'gpt': gpt,
      'ys_family_idfk': ysFamilyIdFk,
      'ys_apperance_idfk': apperanceYarnId,
      'ys_pattern_charectristic_idfk': patternCharId,
      'ys_color': ys_color_code,
      'ys_usage_idfk': yuId,
      'ys_yarn_type_idfk': yarnYypeId,
      'ys_ply_idfk': plyId,
      'ys_color_treatment_method_idfk': colorTreatmentId,
      'ys_orientation_idfk': orientationId,
      'ys_twist_direction_idfk': twistDirectionId,
      'ys_spun_technique_idfk': spunTechId,
      'ys_quality_idfk': qualityId,
      'ys_pattern_idfk': patternId,
      'ys_blend_idfk': ysBlendIdFk,
      'ys_doubling_method_idFk': doublingMethodId,
    };

    return map;
  }
}
