class FiberRequestModel{

  late String? spc_category_idfk;
  late String? spc_user_idfk;
  late String? spc_local_international;
  late String? spc_fiber_material_idfk;
  late String? spc_fiber_length_idfk;
  late String? spc_grade_idfk;
  late String? spc_micronaire_idfk;
  late String? spc_moisture_idfk;
  late String? spc_trash_idfk;
  late String? spc_rd_idfk;
  late String? spc_gpt_idfk;
  late String? spc_appearance_idfk;
  late String? spc_brand_idfk;
  late String? spc_production_year;
  late String? spc_origin_idfk;
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
  late String? spc_lot_number;
  late String? fbp_min_quantity;
  late String? fbp_description;

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
      this.spc_lot_number,
      this.fbp_min_quantity,
      this.fbp_description});

  Map<String, String> toJson() {
    Map<String, String> map = {
      'spc_category_idfk': spc_category_idfk??"",
      'spc_user_idfk': spc_user_idfk??"",
      'spc_local_international': spc_local_international??"",
      'spc_fiber_material_idfk': spc_fiber_material_idfk??"",
      'spc_fiber_length_idfk': spc_fiber_length_idfk??"",
      'spc_grade_idfk': spc_grade_idfk??"",
      'spc_micronaire_idfk': spc_micronaire_idfk??"",
      'spc_moisture_idfk': spc_moisture_idfk??"",
      'spc_trash_idfk': spc_trash_idfk??"",
      'spc_rd_idfk': spc_rd_idfk??"",
      'spc_gpt_idfk': spc_gpt_idfk??"",
      'spc_appearance_idfk': spc_appearance_idfk??"",
      'spc_brand_idfk': spc_brand_idfk??"",
      'spc_production_year': spc_production_year??"",
      'spc_origin_idfk': spc_origin_idfk??"",
      'spc_city_state_idfk': spc_city_state_idfk??"",
      'spc_certificate_idfk': spc_certificate_idfk??"",
      'fbp_price': fbp_price??"",
      'packing_idfk': packing_idfk??"",
      'payment_type_idfk': payment_type_idfk??"",
      'lc_type_idfk': lc_type_idfk??"",
      'fbp_count_unit_idfk': fbp_count_unit_idfk??"",
      'fbp_delivery_period_idfk': fbp_delivery_period_idfk??"",
      'fbp_available_for_market_idfk': fbp_available_for_market_idfk??"",
      'fbp_price_terms_idfk': fbp_price_terms_idfk??"",
      'spc_lot_number': spc_lot_number??"",
      'fbp_min_quantity': fbp_min_quantity??"",
      'fbp_description': fbp_description??""
    };

    return map;
  }
}