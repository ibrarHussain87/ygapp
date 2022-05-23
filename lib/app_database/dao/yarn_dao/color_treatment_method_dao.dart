import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

@dao
abstract class ColorTreatmentMethodDao{
  @Query('SELECT * FROM color_treatment_method')
  Future<List<ColorTreatmentMethod>> findAllColorTreatmentMethod();

  @Query('SELECT * FROM color_treatment_method where familyId = :id')
  Future<List<ColorTreatmentMethod>> findYarnColorTreatmentMethodWithFamilyId(int id);

  @Query('SELECT * FROM color_treatment_method where yctmId = :id')
  Future<ColorTreatmentMethod?> findYarnColorTreatmentMethodWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertColorTreatmentMethod(ColorTreatmentMethod colorTm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllColorTreatmentMethod(List<ColorTreatmentMethod> colorTm);

  @Query("delete from color_treatment_method where yctmId = :id")
  Future<void> deleteColorTreatmentMethod(int id);

  @Query("delete from color_treatment_method")
  Future<void> deleteAll();
}