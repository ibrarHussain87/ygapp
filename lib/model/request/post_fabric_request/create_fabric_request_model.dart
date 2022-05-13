import '../../response/fiber_response/fiber_specification.dart';

class FabricCreateRequestModel {
  String? spc_category_idfk;
  String? fs_title;
  String? fs_details;
  String? fs_local_international;
  String? fs_user_idfk;
  String? fs_family_idfk;
  String? fabric_denim_type_idfk;
  String? fabric_weave_pattern_idfk;
  String? fs_blend_idfk;
  String? fs_fdt_idfk;
  String? fs_appearance_idfk;
  String? fs_fctm_idfk;
  String? fs_city_state_idfk;
  String? fs_loom_idfk;
  String? fs_knitting_type_idfk;
  String? fs_salvedge_idfk;
  String? fs_weave_idfk;
  String? fs_count;
  String? fs_gsm_count;
  String? fs_ratio;
  String? fs_warp_count;
  String? fs_warp_ply_idfk;
  String? fs_no_of_ends_warp;
  String? fs_weft_ply_idfk;
  String? fs_no_of_pick_weft;
  String? fs_width;
  String? fs_ply_idfk;
  String? fs_weft_count;
  String? fs_quality_idfk;
  String? fs_grade_idfk;
  String? fs_certification_idfk;
  String? fs_color_treatment_method_idfk;
  String? fs_dying_method_idfk;
  String? fs_color;
  String? fs_tuckin_width;
  String? fs_apperance_idfk;
  String? fs_once;
  String? fs_layyer_idfk;
  String? fs_origin_idfk;
  String? is_offering;
  String? fbp_price;
  String? fbp_count_unit_idfk;
  String? fpb_weight_cone;
  String? fpb_weight_bag;
  String? fpb_cones_bag;
  String? fpb_packing;
  String? fpb_payment_type_idfk;
  String? fpb_lc_type_idfk;
  String? fbp_delivery_period_idfk;
  String? fbp_available_for_market_idfk;
  String? fbp_price_terms_idfk;
  String? fbp_description;
  String? fbp_min_quantity;
  String? fbp_available_quantity;
  String? fbp_no_of_days;
  String? fbp_port_idfk;
  /*List<Pictures>? pictures;*/

  FabricCreateRequestModel(
      {
        this.spc_category_idfk,
        this.fs_title,
        this.fs_details,
        this.fs_local_international,
        this.fs_user_idfk,
        this.fs_family_idfk,
        this.fabric_denim_type_idfk,
        this.fabric_weave_pattern_idfk,
        this.fs_blend_idfk,
        this.fs_fdt_idfk,
        this.fs_appearance_idfk,
        this.fs_fctm_idfk,
        this.fs_city_state_idfk,
        this.fs_loom_idfk,
        this.fs_knitting_type_idfk,
        this.fs_salvedge_idfk,
        this.fs_weave_idfk,
        this.fs_count,
        this.fs_gsm_count,
        this.fs_ratio,
        this.fs_warp_count,
        this.fs_warp_ply_idfk,
        this.fs_no_of_ends_warp,
        this.fs_weft_ply_idfk,
        this.fs_no_of_pick_weft,
        this.fs_width,
        this.fs_ply_idfk,
        this.fs_weft_count,
        this.fs_quality_idfk,
        this.fs_grade_idfk,
        this.fs_certification_idfk,
        this.fs_color_treatment_method_idfk,
        this.fs_dying_method_idfk,
        this.fs_color,
        this.fs_tuckin_width,
        this.fs_apperance_idfk,
        this.fs_once,
        this.fs_layyer_idfk,
        this.fs_origin_idfk,
        this.is_offering,
        this.fbp_price,
        this.fbp_count_unit_idfk,
        this.fpb_weight_cone,
        this.fpb_weight_bag,
        this.fpb_cones_bag,
        this.fpb_packing,
        this.fpb_payment_type_idfk,
        this.fpb_lc_type_idfk,
        this.fbp_delivery_period_idfk,
        this.fbp_available_for_market_idfk,
        this.fbp_price_terms_idfk,
        this.fbp_description,
        this.fbp_min_quantity,
        this.fbp_available_quantity,
        this.fbp_no_of_days,
        this.fbp_port_idfk,
        /*this.pictures*/
      });

  Map<String, String> toJson() {
    Map<String, String> map = {
      'spc_category_idfk': spc_category_idfk ?? "",
      'fs_title': fs_title ?? "",
      'fs_details': fs_details ?? "",
      'fs_local_international': fs_local_international ?? "",
      'fs_user_idfk': fs_user_idfk ?? "",
      'fs_family_idfk': fs_family_idfk ?? "",
      'fabric_denim_type_idfk': fabric_denim_type_idfk ?? "",
      'fabric_weave_pattern_idfk': fabric_weave_pattern_idfk ?? "",
      'fs_blend_idfk': fs_blend_idfk ?? "",
      'fs_fdt_idfk': fs_fdt_idfk ?? "",
      'fs_appearance_idfk': fs_appearance_idfk ?? "",
      'fs_fctm_idfk': fs_fctm_idfk ?? "",
      'fs_city_state_idfk': fs_city_state_idfk ?? "",
      'fs_loom_idfk': fs_loom_idfk ?? "",
      'fs_knitting_type_idfk': fs_knitting_type_idfk ?? "",
      'fs_salvedge_idfk': fs_salvedge_idfk ?? "",
      'fs_weave_idfk': fs_weave_idfk ?? "",
      'fs_count': fs_count ?? "",
      'fs_gsm_count': fs_gsm_count ?? "",
      'fs_ratio': fs_ratio ?? "",
      'fs_warp_count': fs_warp_count ?? "",
      'fs_warp_ply_idfk': fs_warp_ply_idfk ?? "",
      'fs_no_of_ends_warp': fs_no_of_ends_warp ?? "",
      'fs_weft_ply_idfk': fs_weft_ply_idfk ?? "",
      'fs_no_of_pick_weft': fs_no_of_pick_weft ?? "",
      'fs_width': fs_width ?? "",
      'fs_ply_idfk': fs_ply_idfk ?? "",
      'fs_weft_count': fs_weft_count ?? "",
      'fs_quality_idfk': fs_quality_idfk ?? "",
      'fs_grade_idfk': fs_grade_idfk ?? "",
      'fs_certification_idfk': fs_certification_idfk ?? "",
      'fs_color_treatment_method_idfk': fs_color_treatment_method_idfk ?? "",
      'fs_dying_method_idfk': fs_dying_method_idfk ?? "",
      'fs_color': fs_color ?? "",
      'fs_tuckin_width': fs_tuckin_width ?? "",
      'fs_apperance_idfk': fs_apperance_idfk ?? "",
      'fs_once': fs_once ?? "",
      'fs_layyer_idfk': fs_layyer_idfk ?? "",
      'fs_origin_idfk': fs_origin_idfk ?? "",
      'is_offering': is_offering ?? "",
      'fbp_price': fbp_price ?? "",
      'fbp_count_unit_idfk': fbp_count_unit_idfk ?? "",
      'fpb_weight_cone': fpb_weight_cone ?? "",
      'fpb_weight_bag': fpb_weight_bag ?? "",
      'fpb_cones_bag': fpb_cones_bag ?? "",
      'fpb_packing': fpb_packing ?? "",
      'fpb_payment_type_idfk': fpb_payment_type_idfk ?? "",
      'fpb_lc_type_idfk': fpb_lc_type_idfk ?? "",
      'fbp_delivery_period_idfk': fbp_delivery_period_idfk ?? "",
      'fbp_available_for_market_idfk': fbp_available_for_market_idfk ?? "",
      'fbp_price_terms_idfk': fbp_price_terms_idfk ?? "",
      'fbp_description': fbp_description ?? "",
      'fbp_min_quantity': fbp_min_quantity ?? "",
      'fbp_available_quantity': fbp_available_quantity ?? "",
      'fbp_no_of_days': fbp_no_of_days ?? "",
      'fbp_port_idfk': fbp_port_idfk ?? "",
      /*'pictures': pictures?.map((e) => e.toJson()).toList(),*/
    };

    return map;
  }
}
