class StocklotWasteModel {

  String? id;
  String? description;
  String? name;
  String? quantity;
  String? unitOfCount;
  String? price;

  StocklotWasteModel({this.id, this.description,this.name,this.quantity,this.unitOfCount,this.price});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id!.trim(),
      'description': description!.trim(),
      'name': name!.trim(),
      'quantity': quantity!.trim(),
      'unitOfCount': unitOfCount!.trim(),
      'price': price!.trim(),
    };

    return map;
  }
}
