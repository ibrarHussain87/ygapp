class CreateRequestModel {
  late String? spc_category_idfk;
  late String? spc_user_idfk;
  late String? spc_local_international;

  //Fiber Keys
  late String? spc_fiber_material_idfk;
  late String? spc_fiber_length_idfk;
  late String? spc_grade_idfk;
  late String? spc_micronaire_idfk;
  late String? spc_moisture_idfk;
  late String? spc_trash_idfk;
  late String? spc_rd_idfk;
  late String? spc_gpt_idfk;
  late String? spc_production_year;
  late String? spc_lot_number;
  late String? spc_appearance_idfk;
  late String? spc_brand_idfk;

  //Packing Details keys
  late String? is_offering;
  late String? spc_origin_idfk;
  late String? spc_port_idfk;
  late String? spc_city_state_idfk;
  late String? spc_certificate_idfk;
  late String? fbp_price;
  late String? packing_idfk;
  late String? payment_type_idfk;
  late String? lc_type_idfk;
  late String? fbp_count_unit_idfk;
  late String? fbp_delivery_period_idfk;
  late String? fbp_available_for_market_idfk;
  late String? fbp_price_terms_idfk;
  late String? fbp_min_quantity;
  late String? fbp_description;

  late String? fpb_packing;
  late String? fpb_payment_type_idfk;
  late String? fpb_lc_type_idfk;

  //Yarn keys

  late String? ys_family_idfk;
  late String? ys_user_idfk;
  late String? ys_blend_idfk;
  late String? ys_ratio;
  late String? ys_usage_idfk;
  late String? ys_pattern_idfk;
  late String? ys_pattern_charectristic_idfk;
  late String? ys_orientation_idfk;
  late String? ys_twist_direction_idfk;
  late String? ys_count;
  late String? ys_dty_filament;
  late String? ys_fdy_filament;
  late String? ys_ply_idfk;
  late String? ys_grade_idfk;
  late String? ys_certification_idfk;
  late String? ys_color_treatment_method_idfk;
  late String? ys_dying_method_idfk;
  late String? ys_color_idfk;
  late String? ys_apperance_idfk;
  late String? ys_actual_yarn_count;
  late String? ys_qlt;
  late String? ys_clsp;
  late String? ys_uniformity;
  late String? ys_cv;
  late String? ys_thin_places;
  late String? ys_thick_places;
  late String? ys_naps;
  late String? ys_ipm_km;
  late String? ys_hairness;
  late String? ys_rkm;
  late String? ys_elongation;
  late String? ys_tpi;
  late String? ys_tm;

  late String? ys_quality_idfk;
  late String? ys_spun_technique_idfk;

  late String? fpb_weight_cone;
  late String? fpb_weight_bag;
  late String? fpb_cones_bag;
  late String? ys_details;
  late String? ys_origin_idfk;
  late String? ys_title;

  CreateRequestModel(
      {this.spc_category_idfk,
      this.spc_user_idfk,
      this.spc_local_international,
      this.spc_fiber_material_idfk,
      this.spc_fiber_length_idfk,
      this.spc_grade_idfk,
      this.spc_micronaire_idfk,
      this.spc_moisture_idfk,
      this.spc_trash_idfk,
      this.spc_rd_idfk,
      this.spc_gpt_idfk,
      this.spc_production_year,
      this.spc_lot_number,
      this.spc_appearance_idfk,
      this.spc_brand_idfk,
      this.is_offering,
      this.spc_origin_idfk,
      this.spc_port_idfk,
      this.spc_city_state_idfk,
      this.spc_certificate_idfk,
      this.fbp_price,
      this.packing_idfk,
      this.payment_type_idfk,
      this.lc_type_idfk,
      this.fbp_count_unit_idfk,
      this.fbp_delivery_period_idfk,
      this.fbp_available_for_market_idfk,
      this.fbp_price_terms_idfk,
      this.fbp_min_quantity,
      this.fbp_description,
      this.fpb_packing,
      this.fpb_payment_type_idfk,
      this.fpb_lc_type_idfk,
      this.ys_ratio,
      this.ys_usage_idfk,
      this.ys_pattern_idfk,
      this.ys_pattern_charectristic_idfk,
      this.ys_orientation_idfk,
      this.ys_twist_direction_idfk,
      this.ys_count,
      this.ys_dty_filament,
      this.ys_fdy_filament,
      this.ys_ply_idfk,
      this.ys_grade_idfk,
      this.ys_certification_idfk,
      this.ys_color_treatment_method_idfk,
      this.ys_dying_method_idfk,
      this.ys_color_idfk,
      this.ys_apperance_idfk,
      this.ys_actual_yarn_count,
      this.ys_qlt,
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

  Map<String, String> toJson() {
    Map<String, String> map = {
      'spc_category_idfk': spc_category_idfk ?? "",
      'spc_user_idfk': spc_user_idfk ?? "",
      'spc_local_international': spc_local_international ?? "",
      'spc_fiber_material_idfk': spc_fiber_material_idfk ?? "",
      'spc_fiber_length_idfk': spc_fiber_length_idfk ?? "",
      'spc_grade_idfk': spc_grade_idfk ?? "",
      'spc_micronaire_idfk': spc_micronaire_idfk ?? "",
      'spc_moisture_idfk': spc_moisture_idfk ?? "",
      'spc_trash_idfk': spc_trash_idfk ?? "",
      'spc_rd_idfk': spc_rd_idfk ?? "",
      'spc_gpt_idfk': spc_gpt_idfk ?? "",
      'is_offering': is_offering ?? "",
      'spc_appearance_idfk': spc_appearance_idfk ?? "",
      'spc_brand_idfk': spc_brand_idfk ?? "",
      'spc_production_year': spc_production_year ?? "",
      'spc_origin_idfk': spc_origin_idfk ?? "",
      'spc_port_idfk': spc_port_idfk ?? "",
      'spc_city_state_idfk': spc_city_state_idfk ?? "",
      'spc_certificate_idfk': spc_certificate_idfk ?? "",
      'fbp_price': fbp_price ?? "",
      'packing_idfk': packing_idfk ?? "",
      'payment_type_idfk': payment_type_idfk ?? "",
      'lc_type_idfk': lc_type_idfk ?? "",
      'fbp_count_unit_idfk': fbp_count_unit_idfk ?? "",
      'fbp_delivery_period_idfk': fbp_delivery_period_idfk ?? "",
      'fbp_available_for_market_idfk': fbp_available_for_market_idfk ?? "",
      'fbp_price_terms_idfk': fbp_price_terms_idfk ?? "",
      'spc_lot_number': spc_lot_number ?? "",
      'fbp_min_quantity': fbp_min_quantity ?? "",
      'fbp_description': fbp_description ?? "",
      'fpb_packing': fpb_packing ?? "",
      'fpb_payment_type_idfk': fpb_payment_type_idfk ?? "",
      'fpb_lc_type_idfk': fpb_lc_type_idfk ?? "",

      //Yarn Keys
      'ys_family_idfk': ys_family_idfk ?? "",
      'ys_user_idfk': ys_user_idfk ?? "",
      'ys_blend_idfk': ys_blend_idfk ?? "",
      'ys_ratio': ys_ratio ?? "",
      'ys_usage_idfk': ys_usage_idfk ?? "",
      'ys_pattern_idfk': ys_pattern_idfk ?? "",
      'ys_pattern_charectristic_idfk': ys_pattern_charectristic_idfk ?? "",
      'ys_orientation_idfk': ys_orientation_idfk ?? "",
      'ys_twist_direction_idfk': ys_twist_direction_idfk ?? "",
      'ys_count': ys_count ?? "",
      'ys_dty_filament': ys_dty_filament ?? "",
      'ys_fdy_filament': ys_fdy_filament ?? "",
      'ys_ply_idfk': ys_ply_idfk ?? "",
      'ys_grade_idfk': ys_grade_idfk ?? "",
      'ys_certification_idfk': ys_certification_idfk ?? "",
      'ys_color_treatment_method_idfk': ys_color_treatment_method_idfk ?? "",
      'ys_dying_method_idfk': ys_dying_method_idfk ?? "",
      'ys_color_idfk': ys_color_idfk ?? "",
      'ys_apperance_idfk': ys_apperance_idfk ?? "",
      'ys_actual_yarn_count': ys_actual_yarn_count ?? "",
      'ys_qlt': ys_qlt ?? "",
      'ys_clsp': ys_clsp ?? "",
      'ys_uniformity': ys_uniformity ?? "",
      'ys_cv': ys_cv ?? "",
      'ys_thin_places': ys_thin_places ?? "",
      'ys_thick_places': ys_thick_places ?? "",
      'ys_naps': ys_naps ?? "",
      'ys_ipm_km': ys_ipm_km ?? "",
      'ys_hairness': ys_hairness ?? "",
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
