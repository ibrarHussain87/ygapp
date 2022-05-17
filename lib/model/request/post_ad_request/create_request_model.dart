import 'package:yg_app/model/blend_model.dart';

class CreateRequestModel {
  String? spc_category_idfk;
  String? spc_id;
  String? ys_id;
  String? spc_user_idfk;
  String? spc_local_international;
  String? ys_local_international;

  //Fiber Keys
  String? spc_fiber_family_idfk;
  String? spc_nature_idfk;
  String? spc_fiber_length_idfk;
  String? spc_grade_idfk;
  String? spc_micronaire_idfk;
  String? spc_moisture_idfk;
  String? spc_trash_idfk;
  String? spc_rd_idfk;
  String? spc_gpt_idfk;
  String? spc_production_year;
  String? spc_lot_number;
  String? spc_appearance_idfk;
  String? spc_brand_idfk;
  String? spc_no_of_days;
  String? spc_active;
  List<BlendModel>? formation;

  //Packing Details keys
  String? is_offering;
  String? spc_origin_idfk;
  String? spc_port_idfk;
  String? spc_city_state_idfk;
  String? spc_certificate_idfk;
  String? fbp_price;
  String? packing_idfk;
  String? payment_type_idfk;
  String? lc_type_idfk;
  String? fbp_count_unit_idfk;
  String? fbp_delivery_period_idfk;

  // String? fbp_available_for_market_idfk;
  String? fbp_price_terms_idfk;
  String? fbp_min_quantity;
  String? fbp_available_quantity;
  String? fbp_required_quantity;
  String? fbp_description;

  String? fpb_packing;
  String? fpb_payment_type_idfk;
  String? fpb_lc_type_idfk;
  String? cone_type_id;

  //Yarn keys

  String? ys_family_idfk;
  String? ys_user_idfk;
  String? ys_blend_idfk;
  String? ys_ratio;
  String? ys_usage_idfk;
  String? ys_pattern_idfk;
  String? ys_pattern_charectristic_idfk;
  String? ys_orientation_idfk;
  String? ys_twist_direction_idfk;
  String? ys_count;
  String? ys_dty_filament;
  String? ys_fdy_filament;
  String? ys_ply_idfk;
  String? ys_doubling_method_idFk;
  String? ys_grade_idfk;
  String? ys_yarn_type_idfk;
  String? ys_certification_idfk;
  String? ys_color_treatment_method_idfk;
  String? ys_dying_method_idfk;
  List<Map<String,String>>? ys_formation;

  // String? ys_color_idfk;
  String? ys_color_code;
  String? ys_apperance_idfk;
  String? ys_actual_yarn_count;
  String? ys_clsp;
  String? ys_uniformity;
  String? ys_cv;
  String? ys_thin_places;
  String? ys_thick_places;
  String? ys_naps;
  String? ys_ipm_km;
  String? ys_hairness;
  String? ys_rkm;
  String? ys_elongation;
  String? ys_tpi;
  String? ys_tm;
  String? ys_pattern_charectristic_thickness;
  String? ys_length_pattern_charactristics;
  String? ys_pause_patteren_charactristics;
  String? ys_grain_patteren_charactristics;
  String? ys_rice_patteren_charactristics;

  String? ys_quality_idfk;
  String? ys_spun_technique_idfk;

  String? fpb_weight_cone;
  String? fpb_weight_bag;
  String? fpb_cones_bag;
  String? ys_details;
  String? ys_origin_idfk;
  String? ys_title;

  CreateRequestModel(
      {this.spc_category_idfk,
      this.spc_id,
      this.ys_id,
      this.spc_user_idfk,
      this.spc_local_international,
      this.ys_local_international,
      this.spc_fiber_family_idfk,
      this.spc_nature_idfk,
      this.spc_fiber_length_idfk,
      this.spc_grade_idfk,
      this.spc_micronaire_idfk,
      this.spc_moisture_idfk,
      this.spc_trash_idfk,
      this.spc_rd_idfk,
      this.spc_gpt_idfk,
      this.cone_type_id,
      this.spc_no_of_days,
      this.spc_active,
      this.spc_production_year,
      this.spc_lot_number,
      this.spc_appearance_idfk,
      this.spc_brand_idfk,
      this.formation,
      this.is_offering,
      this.spc_origin_idfk,
      this.spc_port_idfk,
      this.spc_city_state_idfk,
      this.spc_certificate_idfk,
      this.fbp_price,
      this.packing_idfk,
      this.payment_type_idfk,
      this.lc_type_idfk,
      this.ys_color_code,
      this.fbp_count_unit_idfk,
      this.fbp_delivery_period_idfk,
      this.fbp_required_quantity,
      // this.fbp_available_for_market_idfk,
      this.fbp_price_terms_idfk,
      this.fbp_min_quantity,
      this.fbp_available_quantity,
      this.fbp_description,
      this.fpb_packing,
      this.ys_yarn_type_idfk,
      this.fpb_payment_type_idfk,
      this.fpb_lc_type_idfk,
      this.ys_ratio,
      this.ys_usage_idfk,
      this.ys_pattern_idfk,
      this.ys_pattern_charectristic_idfk,
      this.ys_pattern_charectristic_thickness,
      this.ys_length_pattern_charactristics,
      this.ys_pause_patteren_charactristics,
      this.ys_grain_patteren_charactristics,
      this.ys_rice_patteren_charactristics,
      this.ys_orientation_idfk,
      this.ys_twist_direction_idfk,
      this.ys_count,
      this.ys_dty_filament,
      this.ys_doubling_method_idFk,
      this.ys_fdy_filament,
      this.ys_ply_idfk,
      this.ys_grade_idfk,
      this.ys_certification_idfk,
      this.ys_color_treatment_method_idfk,
      this.ys_dying_method_idfk,
        this.ys_formation,
      // this.ys_color_idfk,
      this.ys_apperance_idfk,
      this.ys_actual_yarn_count,
      this.ys_clsp,
      this.ys_uniformity,
      this.ys_cv,
      this.ys_thin_places,
      this.ys_thick_places,
      this.ys_naps,
      this.ys_ipm_km,
      this.ys_hairness,
      this.ys_rkm,
      this.ys_elongation,
      this.ys_tpi,
      this.ys_tm,
      this.ys_quality_idfk,
      this.ys_spun_technique_idfk,
      this.fpb_weight_cone,
      this.fpb_weight_bag,
      this.fpb_cones_bag,
      this.ys_details,
      this.ys_origin_idfk,
      this.ys_title});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_category_idfk': spc_category_idfk ?? "",
      'ys_id': ys_id ?? "",
      'spc_id': spc_id ?? "",
      'spc_user_idfk': spc_user_idfk ?? "",
      'spc_local_international': spc_local_international ?? "",
      'ys_local_international': ys_local_international ?? "",
      'spc_fiber_family_idfk': spc_fiber_family_idfk ?? "",
      'spc_nature_idfk': spc_nature_idfk ?? "",
      'spc_fiber_length': spc_fiber_length_idfk ?? "",
      'spc_grade_idfk': spc_grade_idfk ?? "",
      'spc_micronaire': spc_micronaire_idfk ?? "",
      'spc_moisture': spc_moisture_idfk ?? "",
      'spc_trash_idfk': spc_trash_idfk ?? "",
      'spc_yct_id': cone_type_id ?? "",
      'spc_rd_idfk': spc_rd_idfk ?? "",
      'spc_gpt_idfk': spc_gpt_idfk ?? "",
      'spc_no_of_days': spc_no_of_days ?? "",
      'spc_active': spc_active ?? "",
      'is_offering': is_offering ?? "",
      'spc_appearance_idfk': spc_appearance_idfk ?? "",
      'spc_brand_idfk': spc_brand_idfk ?? "",
      'spc_production_year': spc_production_year ?? "",
      'spc_origin_idfk': spc_origin_idfk ?? "",
      'spc_port_idfk': spc_port_idfk ?? "",
      'spc_city_state_idfk': spc_city_state_idfk ?? "",
      'formation': formation ?? [],
      'certification_id ': spc_certificate_idfk ?? "",
      'fbp_price': fbp_price ?? "",
      'packing_idfk': packing_idfk ?? "",
      'payment_type_idfk': payment_type_idfk ?? "",
      'lc_type_idfk': lc_type_idfk ?? "",
      'fbp_count_unit_idfk': fbp_count_unit_idfk ?? "",
      'fbp_delivery_period_idfk': fbp_delivery_period_idfk ?? "",
      // 'fbp_available_for_market_idfk': fbp_available_for_market_idfk ?? "",
      'fbp_price_terms_idfk': fbp_price_terms_idfk ?? "",
      'spc_lot_number': spc_lot_number ?? "",
      'fbp_min_quantity': fbp_min_quantity ?? "",
      'fbp_available_quantity': fbp_available_quantity ?? "",
      'fbp_required_quantity': fbp_required_quantity ?? "",
      'fbp_description': fbp_description ?? "",
      'fpb_packing': fpb_packing ?? "",
      'fpb_payment_type_idfk': fpb_payment_type_idfk ?? "",
      'fpb_lc_type_idfk': fpb_lc_type_idfk ?? "",
      'ys_formation':ys_formation??[],

      //Yarn Keys
      'ys_family_idfk': ys_family_idfk ?? "",
      'ys_user_idfk': ys_user_idfk ?? "",
      'ys_blend_idfk': ys_blend_idfk ?? "",
      'ys_ratio': ys_ratio ?? "",
      'ys_usage_idfk': ys_usage_idfk ?? "",
      'ys_pattern_idfk': ys_pattern_idfk ?? "",
      'ys_pattern_charectristic_idfk': ys_pattern_charectristic_idfk ?? "",
      'ys_pattern_charectristic_thickness':
          ys_pattern_charectristic_thickness ?? "",
      'ys_pattern_charactristics_length':
          ys_length_pattern_charactristics ?? "",
      'ys_patteren_charactristics_pause':
          ys_pause_patteren_charactristics ?? "",
      'ys_patteren_charactristics_grain':
          ys_grain_patteren_charactristics ?? "",
      'ys_patteren_charactristics_rice': ys_rice_patteren_charactristics ?? "",
      'ys_orientation_idfk': ys_orientation_idfk ?? "",
      'ys_twist_direction_idfk': ys_twist_direction_idfk ?? "",
      'ys_count': ys_count ?? "",
      'ys_dty_filament': ys_dty_filament ?? "",
      'ys_fdy_filament': ys_fdy_filament ?? "",
      'ys_yarn_type_idfk': ys_yarn_type_idfk ?? "",
      'ys_ply_idfk': ys_ply_idfk ?? "",
      'ys_grade_idfk': ys_grade_idfk ?? "",
      'certification_id': ys_certification_idfk ?? "",
      'ys_color_treatment_method_idfk': ys_color_treatment_method_idfk ?? "",
      'ys_dying_method_idfk': ys_dying_method_idfk ?? "",
      // 'ys_color_idfk': ys_color_idfk ?? "",
      'ys_apperance_idfk': ys_apperance_idfk ?? "",
      'ys_actual_yarn_count': ys_actual_yarn_count ?? "",
      'ys_clsp': ys_clsp ?? "",
      'ys_uniformity': ys_uniformity ?? "",
      'ys_cv': ys_cv ?? "",
      'ys_thin_places': ys_thin_places ?? "",
      'ys_thick_places': ys_thick_places ?? "",
      'ys_doubling_method_idFk': ys_doubling_method_idFk ?? "",
      'ys_naps': ys_naps ?? "",
      'ys_ipm_km': ys_ipm_km ?? "",
      'ys_hairness': ys_hairness ?? "",
      'ys_color': ys_color_code ?? "",
      'ys_rkm': ys_rkm ?? "",
      'ys_elongation': ys_elongation ?? "",
      'ys_tpi': ys_tpi ?? "",
      'ys_tm': ys_tm ?? "",
      'ys_quality_idfk': ys_quality_idfk ?? "",
      'ys_spun_technique_idfk': ys_spun_technique_idfk ?? "",
      'fpb_weight_cone': fpb_weight_cone ?? "",
      'fpb_weight_bag': fpb_weight_bag ?? "",
      'fpb_cones_bag': fpb_cones_bag ?? "",
      'ys_details': ys_details ?? "",
      'ys_origin_idfk': ys_origin_idfk ?? "",
      'ys_title': ys_title ?? "",
    };

    return map;
  }
}
