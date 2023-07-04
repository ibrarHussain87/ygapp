class StocklotWasteModel {

  String? id;
  // String? description;
  String? name;
  String? quantity;
  String? unitOfCount;
  String? price;

  StocklotWasteModel({this.id,this.name,this.quantity,this.unitOfCount,this.price});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'stocklot_family_idfk': id??'',
      // 'description': description!.trim(),
      // 'name': name!.trim(),
      'quantity': quantity??'',
      'unit_id': unitOfCount??'',
      'price': price??'',
    };

    return map;
  }
}
