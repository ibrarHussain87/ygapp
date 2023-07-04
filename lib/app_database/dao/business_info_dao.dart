import 'package:floor/floor.dart';
import 'package:yg_app/model/response/login/login_response.dart';


//@TypeConverters([JsonConverter])
@dao
abstract class BusinessInfoDao{
  @Query('SELECT * FROM business_info_table')
  Future<BusinessInfo?> getBusinessInfo();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBusinessInfo(BusinessInfo businessInfo);

  @Query('delete FROM business_info_table')
  Future<void> deleteBusinessInfoData();
}