class FabricSpecificationRequestModel {
  String? user_id;
  String? category_id;
  List<int>? fs_family_idfk;
  List<int>? fs_appearance_idfk;
  List<int>? fs_blend_idfk;
  List<int>? fs_fdt_idfk;
  List<int>? fs_fctm_idfk;
  List<int>? selling_region_id;
  List<int>? fs_loom_idfk;
  List<int>? fs_knitting_type_idfk;
  List<int>? fs_salvedge_idfk;
  List<int>? fs_weave_idfk;
  List<int>? fs_warp_ply_idfk;
  List<int>? fs_weft_ply_idfk;
  List<int>? fs_ply_idfk;
  List<int>? fs_quality_idfk;
  List<int>? fs_grade_idfk;
  List<int>? certification_id;
  List<int>? fs_layyer_idfk;
  List<int>? fs_origin_idfk;
  String? fs_featured;
  String? locality;
  String? is_offering;
  String? fs_premium;


  FabricSpecificationRequestModel(
      {
      this.user_id,
      this.category_id,
      this.fs_family_idfk,
      this.fs_appearance_idfk,
      this.fs_blend_idfk,
      this.fs_fdt_idfk,
      this.fs_fctm_idfk,
      this.selling_region_id,
      this.fs_loom_idfk,
      this.fs_knitting_type_idfk,
      this.fs_salvedge_idfk,
      this.fs_weave_idfk,
      this.fs_warp_ply_idfk,
      this.fs_weft_ply_idfk,
      this.fs_ply_idfk,
      this.fs_quality_idfk,
      this.fs_grade_idfk,
      this.certification_id,
      this.fs_layyer_idfk,
      this.fs_origin_idfk,
      this.fs_featured,
      this.locality,
      this.is_offering,
      this.fs_premium,
      });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': user_id!.trim(),
      'category_id': category_id!.trim(),
      'fs_family_idfk': fs_family_idfk,
      'fs_appearance_idfk': fs_appearance_idfk,
      'fs_blend_idfk': fs_blend_idfk,
      'fs_fdt_idfk': fs_fdt_idfk,
      'fs_fctm_idfk': fs_fctm_idfk,
      'selling_region_id': selling_region_id,
      'fs_loom_idfk': fs_loom_idfk,
      'fs_knitting_type_idfk': fs_knitting_type_idfk,
      'fs_salvedge_idfk': fs_salvedge_idfk,
      'fs_weave_idfk': fs_weave_idfk,
      'fs_warp_ply_idfk': fs_warp_ply_idfk,
      'fs_weft_ply_idfk': fs_weft_ply_idfk,
      'fs_ply_idfk': fs_ply_idfk,
      'fs_quality_idfk': fs_quality_idfk,
      'fs_grade_idfk': fs_grade_idfk,
      'certification_id': certification_id,
      'fs_layyer_idfk': fs_layyer_idfk,
      'fs_origin_idfk': fs_origin_idfk,
      'fs_featured': fs_featured,
      'locality': locality,
      'is_offering': is_offering,
      'fs_premium': fs_premium,

    };

    return map;
  }
}
