import 'package:floor/floor.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

@dao
abstract class FabricColorTreatmentMethodDao {
  @Query('SELECT * FROM fiber_color_treatment_method')
  Future<List<FabricColorTreatmentMethod>> findAllFabricColorTreatmentMethod();

  @Query('SELECT * FROM fiber_color_treatment_method where fctmId = :id')
  Future<List<FabricColorTreatmentMethod>> findFabricColorTreatmentMethod(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFabricColorTreatmentMethod(FabricColorTreatmentMethod fabricColorTreatmentMethod);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllFabricFiberColorTreatmentMethod(List<FabricColorTreatmentMethod> fabricColorTreatmentMethod);

  @Query("delete from fiber_color_treatment_method where fctmId = :id")
  Future<void> deleteFabricFiberColorTreatmentMethod(int id);

  @Query("delete from fiber_color_treatment_method")
  Future<void> deleteFabricFiberColorTreatmentMethods();

}