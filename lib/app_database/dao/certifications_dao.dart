import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';

@dao
abstract class CertificationsDao{
  @Query('SELECT * FROM certifications')
  Future<List<Certification>> findAllCertifications();

  @Query('SELECT * FROM certifications where brdId = :id')
  Future<Certification?> findCertificationWithId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCertification(Certification certifications);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllCertification(List<Certification> certifications);

  @Query("delete from certifications where cerId = :id")
  Future<void> deleteCertification(int id);

  @Query("delete * from certifications")
  Future<void> deleteAll();
}