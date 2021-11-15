class FiberRequestModel{

  String? spc_category_idfk;
  String? spc_user_idfk;
  String? spc_local_international;
  String? spc_fiber_material_idfk;
  String? spc_fiber_length_idfk;
  String? spc_grade_idfk;
  String? spc_micronaire_idfk;
  String? spc_moisture_idfk;
  String? spc_trash_idfk;
  String? spc_rd_idfk;
  String? spc_gpt_idfk;
  String? spc_appearance_idfk;
  String? spc_brand_idfk;
  String? spc_production_year;
  String? spc_origin_idfk;
  String? spc_certificate_idfk;
  String? fbp_price;
  String? fbp_count_unit_idfk;
  String? fbp_delivery_period_idfk;
  String? fbp_available_for_market_idfk;
  String? fbp_price_terms_idfk;
  String? fbp_min_quantity;
  String? fbp_description;

  FiberRequestModel({
      this.spc_category_idfk,
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
      this.spc_appearance_idfk,
      this.spc_brand_idfk,
      this.spc_production_year,
      this.spc_origin_idfk,
      this.spc_certificate_idfk,
      this.fbp_price,
      this.fbp_count_unit_idfk,
      this.fbp_delivery_period_idfk,
      this.fbp_available_for_market_idfk,
      this.fbp_price_terms_idfk,
      this.fbp_min_quantity,
      this.fbp_description});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'spc_category_idfk': spc_category_idfk!.trim(),
      'spc_user_idfk': spc_user_idfk!.trim(),
      'spc_local_international': spc_local_international!.trim(),
      'spc_fiber_material_idfk': spc_fiber_material_idfk!.trim(),
      'spc_fiber_length_idfk': spc_fiber_length_idfk!.trim(),
      'spc_grade_idfk': spc_grade_idfk!.trim(),
      'spc_micronaire_idfk': spc_micronaire_idfk!.trim(),
      'spc_moisture_idfk': spc_moisture_idfk!.trim(),
      'spc_trash_idfk': spc_trash_idfk!.trim(),
      'spc_rd_idfk': spc_rd_idfk!.trim(),
      'spc_gpt_idfk': spc_gpt_idfk!.trim(),
      'spc_appearance_idfk': spc_appearance_idfk!.trim(),
      'spc_brand_idfk': spc_brand_idfk!.trim(),
      'spc_production_year': spc_production_year!.trim(),
      'spc_origin_idfk': spc_origin_idfk!.trim(),
      'spc_certificate_idfk': spc_certificate_idfk!.trim(),
      'fbp_price': fbp_price!.trim(),
      'fbp_count_unit_idfk': fbp_count_unit_idfk!.trim(),
      'fbp_delivery_period_idfk': fbp_delivery_period_idfk!.trim(),
      'fbp_available_for_market_idfk': fbp_available_for_market_idfk!.trim(),
      'fbp_price_terms_idfk': fbp_price_terms_idfk!.trim(),
      'fbp_min_quantity': fbp_min_quantity!.trim(),
      'fbp_description': fbp_description!.trim()
    };

    return map;
  }
}