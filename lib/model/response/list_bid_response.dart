import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

class ListBidResponse {
  final bool? status;
  final int? responseCode;
  final List<BidData>? data;
  final String? message;

  ListBidResponse({
    this.status,
    this.responseCode,
    this.data,
    this.message,
  });

  ListBidResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        responseCode = json['response_code'] as int?,

        data = json['data'] != null ? (json['data'] as List?)!.isNotEmpty ? (json['data'] as List?)
            ?.map((dynamic e) => BidData.fromJson(e as Map<String, dynamic>))
            .toList() : List.empty() : null,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
        'status': status,
        'response_code': responseCode,
        'data': data?.map((e) => e.toJson()).toList(),
        'message': message
      };
}

class BidData {
  final int? bidId;
  final String? category;
  final String? categoryId;
  final String? specificationId;
  final String? userName;
  final String? userId;
  final String? price;
  final String? quantity;
  final String? status;
  final String? date;
  final dynamic specification;

  BidData({
    this.bidId,
    this.category,
    this.categoryId,
    this.specificationId,
    this.userName,
    this.userId,
    this.price,
    this.quantity,
    this.status,
    this.date,
    this.specification,
  });

  BidData.fromJson(Map<String, dynamic> json)
      : bidId = json['bid_id'] as int?,
        category = json['category'] as String?,
        categoryId = json['category_id'] as String?,
        specificationId = json['specification_id'] as String?,
        userName = json['user_name'] as String?,
        userId = json['user_id'] as String?,
        price = json['price'] as String?,
        quantity = json['quantity'],
        status = json['status'] as String?,
        date = json['date'] as String?,
        /*specification = (json['specification'] as Map<String, dynamic>?) != null
            ? json['category_id'] == "1"
                ? Specification.fromJson(
                    json['specification'] as Map<String, dynamic>)
                : YarnSpecification.fromJson(
                    json['specification'] as Map<String, dynamic>)
            : null;*/
        specification = json['specification'] != null
            ? json['category_id'] == "1"
            ? (json['specification'] as Map<String, dynamic>).isNotEmpty ? Specification.fromJson(
            json['specification'] as Map<String, dynamic>):null
            : json['category_id'] == "2" ?
            (json['specification'] as Map<String, dynamic>).isNotEmpty ? YarnSpecification.fromJson(
            json['specification'] as Map<String, dynamic>):null
            :json['category_id'] == "3" ? (json['specification'] as Map<String, dynamic>).isNotEmpty ? FabricSpecification.fromJson(
            json['specification'] as Map<String, dynamic>):null
            :(json['specification'] as Map<String, dynamic>).isNotEmpty ? StockLotSpecification.fromJson(
            json['specification'] as Map<String, dynamic>):null
            : null;

  Map<String, dynamic> toJson() => {
        'bid_id': bidId,
        'category': category,
        'category_id': categoryId,
        'specification_id': specificationId,
        'user_name': userName,
        'user_id': userId,
        'price': price,
        'quantity': quantity,
        'status': status,
        'date': date,
        'specification': specification?.toJson()
      };
}

class BidSpecification {
  final int? spcId;
  final String? spcUserId;
  final String? company;
  final String? categoryId;
  final String? businessArea;
  final String? locality;
  final String? material;
  final String? length;
  final String? grade;
  final String? micronaire;
  final String? moisture;
  final String? trash;
  final String? rd;
  final String? gpt;
  final String? apperance;
  final String? brand;
  final String? productYear;
  final String? origin;
  final String? cityState;
  final String? port;
  final String? lotNumber;
  final String? priceUnit;
  final String? unitCount;
  final String? deliveryPeriod;
  final String? available;
  final String? priceTerms;
  final String? minQuantity;
  final String? requiredQuantity;
  final String? description;
  final String? isOffering;
  final String? isFeatured;
  final String? isVerified;
  final List<Pictures>? pictures;
  final List<dynamic>? certifications;
  final String? certificationStr;
  final String? date;
  final int? sortOrder;

  BidSpecification({
    this.spcId,
    this.spcUserId,
    this.company,
    this.categoryId,
    this.businessArea,
    this.locality,
    this.material,
    this.length,
    this.grade,
    this.micronaire,
    this.moisture,
    this.trash,
    this.rd,
    this.gpt,
    this.apperance,
    this.brand,
    this.productYear,
    this.origin,
    this.cityState,
    this.port,
    this.lotNumber,
    this.priceUnit,
    this.unitCount,
    this.deliveryPeriod,
    this.available,
    this.priceTerms,
    this.minQuantity,
    this.requiredQuantity,
    this.description,
    this.isOffering,
    this.isFeatured,
    this.isVerified,
    this.pictures,
    this.certifications,
    this.certificationStr,
    this.date,
    this.sortOrder,
  });

  BidSpecification.fromJson(Map<String, dynamic> json)
      : spcId = json['spc_id'] as int?,
        spcUserId = json['spc_user_id'] as String?,
        company = json['company'] as String?,
        categoryId = json['category_id'] as String?,
        businessArea = json['business_area'] as String?,
        locality = json['locality'] as String?,
        material = json['material'] as String?,
        length = json['length'],
        grade = json['grade'] as String?,
        micronaire = json['micronaire'] as String?,
        moisture = json['moisture'] as String?,
        trash = json['trash'] as String?,
        rd = json['rd'] as String?,
        gpt = json['gpt'] as String?,
        apperance = json['apperance'],
        brand = json['brand'] as String?,
        productYear = json['product_year'] as String?,
        origin = json['origin'],
        cityState = json['city_state'],
        port = json['port'],
        lotNumber = json['lot_number'] as String?,
        priceUnit = json['price_unit'] as String?,
        unitCount = json['unit_count'],
        deliveryPeriod = json['delivery_period'] as String?,
        available = json['available'],
        priceTerms = json['price_terms'] as String?,
        minQuantity = json['min_quantity'] as String?,
        requiredQuantity = json['required_quantity'],
        description = json['description'] as String?,
        isOffering = json['is_offering'] as String?,
        isFeatured = json['is_featured'] as String?,
        isVerified = json['is_verified'] as String?,
        pictures = (json['pictures'] as List?)
            ?.map((dynamic e) => Pictures.fromJson(e as Map<String, dynamic>))
            .toList(),
        certifications = json['certifications'] as List?,
        certificationStr = json['certification_str'] as String?,
        date = json['date'] as String?,
        sortOrder = json['sort_order'] as int?;

  Map<String, dynamic> toJson() => {
        'spc_id': spcId,
        'spc_user_id': spcUserId,
        'company': company,
        'category_id': categoryId,
        'business_area': businessArea,
        'locality': locality,
        'material': material,
        'length': length,
        'grade': grade,
        'micronaire': micronaire,
        'moisture': moisture,
        'trash': trash,
        'rd': rd,
        'gpt': gpt,
        'apperance': apperance,
        'brand': brand,
        'product_year': productYear,
        'origin': origin,
        'city_state': cityState,
        'port': port,
        'lot_number': lotNumber,
        'price_unit': priceUnit,
        'unit_count': unitCount,
        'delivery_period': deliveryPeriod,
        'available': available,
        'price_terms': priceTerms,
        'min_quantity': minQuantity,
        'required_quantity': requiredQuantity,
        'description': description,
        'is_offering': isOffering,
        'is_featured': isFeatured,
        'is_verified': isVerified,
        'pictures': pictures?.map((e) => e.toJson()).toList(),
        'certifications': certifications,
        'certification_str': certificationStr,
        'date': date,
        'sort_order': sortOrder
      };
}

class Pictures {
  final String? picture;

  Pictures({
    this.picture,
  });

  Pictures.fromJson(Map<String, dynamic> json)
      : picture = json['picture'] as String?;

  Map<String, dynamic> toJson() => {'picture': picture};
}
