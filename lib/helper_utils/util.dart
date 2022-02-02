import 'package:logger/logger.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

class Utils{

  static double splitMin(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[0]);
  }

  static double splitMax(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[1]);
  }

  static String checkNullString(bool prefix) {
    var debug = false;
    var value = '';
    if(debug){
      if(prefix){
        value = ',N/A';
      }else{
        value = 'N/A';
      }
    }
    return value;
  }

  static String createStringFromList(List<String?> myList){
    var resultString = '';
    myList.asMap().forEach((index, value) {
      if(index==0){
        resultString = resultString+(value??checkNullString(false));
      }else{
        if(value==null){
          if(resultString.isNotEmpty){
            resultString = resultString+checkNullString(false);
          }else{
            resultString = resultString+checkNullString(true);
          }
        }else{
          if(resultString.isNotEmpty){
            resultString = resultString+',$value';
          }else{
            resultString = resultString+value;
          }
        }
      }
    });
    return resultString;
  }

  static String setFamilyData(YarnSpecification specification) {
    String familyData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '2':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '3':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '4':
        familyData =
        '${specification.dtyFilament ?? ""}${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '5':
        familyData =
        '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
    }
    /*if(familyData.isEmpty){
    familyData = "20/S Cotton";
  }*/
    return familyData;
  }

  static String setTitleData(YarnSpecification specification) {
    String titleData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        titleData =
        '${specification.yarnQuality ?? Utils.checkNullString(false)}${specification.yq_abrv != null ? ' for ' : ''}${specification.yarnUsage ?? Utils.checkNullString(false)}';
        break;
      case '2':
        titleData = specification.yarnBlend ?? Utils.checkNullString(false);
        break;
      case '3':
        titleData = specification.yarnOrientation ?? Utils.checkNullString(false);
        break;
      case '4':
        titleData = specification.yarnType ?? Utils.checkNullString(false);
        break;
      case '5':
        titleData = specification.yarnBlend ?? Utils.checkNullString(false);
        break;
    }
    /*if(titleData.isEmpty){
    titleData = "Combed Weaving";
  }*/
    return titleData;
  }

  static String setDetailsData(YarnSpecification specification) {
    String detailsData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        /*detailsData =
        '${specification.yarnOrientation ?? Utils.checkNullString(false)}'
            '${specification.yarnOrientation != null ? ',' : ''}'
            '${specification.yarnSpunTechnique != null ? '${specification.yarnSpunTechnique}' : Utils.checkNullString(true)}'
            '${specification.yarnSpunTechnique != null ? ',' : ''}'
            '${specification.yarnColorTreatmentMethod != null ? '${specification.yarnColorTreatmentMethod}' : Utils.checkNullString(true)}'
            '${specification.yarnColorTreatmentMethod != null ? ',' : ''}'
            '${specification.doublingMethod != null ? '${specification.doublingMethod}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.yarnOrientation,specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '2':
        /*detailsData =
        '${specification.yarnOrientation ?? Utils.checkNullString(false)}'
            '${specification.yarnOrientation != null ? ',' : ''}'
            '${specification.yarnSpunTechnique != null ? '${specification.yarnSpunTechnique}' : Utils.checkNullString(true)}'
            '${specification.yarnSpunTechnique != null ? ',' : ''}'
            '${specification.yarnColorTreatmentMethod != null ? '${specification.yarnColorTreatmentMethod}' : Utils.checkNullString(true)}'
            '${specification.yarnColorTreatmentMethod != null ? ',' : ''}'
            '${specification.doublingMethod != null ? '${specification.doublingMethod}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.yarnOrientation,specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '3':
        /*detailsData =
        '${specification.yarnSpunTechnique ?? Utils.checkNullString(false)}'
            '${specification.yarnSpunTechnique != null ? ',' : ''}'
            '${specification.yarnColorTreatmentMethod != null ? '${specification.yarnColorTreatmentMethod}' : Utils.checkNullString(true)}'
            '${specification.yarnColorTreatmentMethod != null ? ',' : ''}'
            '${specification.doublingMethod != null ? '${specification.doublingMethod}' : Utils.checkNullString(true)}';*/
        List<String?> list = [specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.doublingMethod,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '4':
        /*detailsData =
        '${specification.yarnSpunTechnique ?? Utils.checkNullString(false)}'
            '${specification.yarnSpunTechnique != null ? ',' : ''}'
            '${specification.yarnColorTreatmentMethod != null ? '${specification.yarnColorTreatmentMethod}' : Utils.checkNullString(true)}'
            '${specification.yarnColorTreatmentMethod != null ? ',' : ''}'
            '${specification.yarnApperance != null ? '${specification.yarnApperance}' : Utils.checkNullString(true)}'
            '${specification.yarnApperance != null ? ',' : ''}'
            '${specification.doublingMethod != null ? '${specification.doublingMethod}' : Utils.checkNullString(true)}'
            '${specification.doublingMethod != null ? ',' : ''}'
            '${specification.yarnGrade != null ? '${specification.yarnGrade}' : Utils.checkNullString(true)}';*/
          Logger().e(specification.yarnSpunTechnique.toString()+'5');
        List<String?> list = [specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.yarnApperance,specification.doublingMethod,specification.yarnGrade,];
        detailsData = Utils.createStringFromList(list);
        break;
      case '5':
        /*detailsData =
        '${specification.yarnSpunTechnique ?? Utils.checkNullString(false)}'
            '${specification.yarnSpunTechnique != null ? ',' : ''}'
            '${specification.yarnColorTreatmentMethod != null ? '${specification.yarnColorTreatmentMethod}' : Utils.checkNullString(true)}'
            '${specification.yarnColorTreatmentMethod != null ? ',' : ''}'
            '${specification.yarnPattern != null ? '${specification.yarnPattern}' : Utils.checkNullString(true)}';*/
        /*,${specification.doublingMethod??Utils.checkNullString(true)}*/
        List<String?> list = [specification.yarnSpunTechnique,specification.yarnColorTreatmentMethod,specification.yarnPattern,];
        detailsData = Utils.createStringFromList(list);
        break;
    }
    /*if(detailsData.isEmpty){
    detailsData = "Weaving,Ring Frame,Warp,Regular";
  }*/
    return detailsData;
  }


}