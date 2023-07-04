import 'package:floor/floor.dart';


@Entity(tableName: 'categories')
class UserCategories {
  @PrimaryKey(autoGenerate:false)
  int? catId;
  String? catName;


  UserCategories(
      {this.catId,
        this.catName,
      });

  UserCategories.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;

    return data;
  }


}