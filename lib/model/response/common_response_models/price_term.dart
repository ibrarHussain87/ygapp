import 'package:floor/floor.dart';

@Entity(tableName: 'price_terms_table')
class FPriceTerms {
  FPriceTerms({
    required this.ptrId,
    required this.ptrCategoryIdfk,
    this.ptrCountryIdfk,
    required this.ptrName,
    required this.ptrIsActive,
    this.ptrSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int ptrId;
  String? ptrCategoryIdfk;
  @ignore
  Null ptrCountryIdfk;
  String? ptrName;
  String? ptrIsActive;
  @ignore
  Null ptrSortid;
  @ignore
  Null createdAt;
  @ignore
  Null updatedAt;
  @ignore
  Null deletedAt;

  FPriceTerms.fromJson(Map<String, dynamic> json){
    ptrId = json['ptr_id'];
    ptrCategoryIdfk = json['ptr_category_idfk'];
    ptrCountryIdfk = null;
    ptrName = json['ptr_name'];
    ptrIsActive = json['ptr_is_active'];
    ptrSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ptr_id'] = ptrId;
    _data['ptr_category_idfk'] = ptrCategoryIdfk;
    _data['ptr_country_idfk'] = ptrCountryIdfk;
    _data['ptr_name'] = ptrName;
    _data['ptr_is_active'] = ptrIsActive;
    _data['ptr_sortid'] = ptrSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ptrName??"";
  }
}