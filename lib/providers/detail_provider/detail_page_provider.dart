import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/detail_tile_model.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_tab.dart';
import 'package:yg_app/pages/detail_pages/detail_page/history_bids_component/history_bids_page.dart';
import 'package:yg_app/pages/detail_pages/detail_page/list_bidder_components/bider_tab.dart';
import 'package:yg_app/pages/detail_pages/detail_page/matched_components/matched_tab_page.dart';
import 'package:intl/intl.dart';

class DetailPageProvider extends ChangeNotifier {
  late bool isFiber, isYarn, isFabric, isStockLot;

  Specification? fiberSpecification;
  YarnSpecification? yarnSpecification;
  FabricSpecification? fabricSpecification;
  StockLotSpecification? stockLotSpecification;

  final List<String> tabsListCreator = ['Details', "Matched", 'Bidder List'];
  final List<String> tabsListBidder = ['Details'];
  final List<String> tabsListBid = ['Details', "History"];

  List<String>? tabsList;
  List<Widget>? tabWidgetList;

  List<DetailTileModel> detailSpecification = [];
  List<DetailTileModel> labParameters = [];
  List<DetailTileModel> detailPackaging = [];
  Map<String, List<DetailTileModel>> stockLotItems = {};

  int? bidPrice = 0;
  int? bidPriceFixed;
  int? bidQuantity;
  int? bidQuantityFixed;
  int? minBidQuantity;
  int? tempBidQuantity;
  String bidRemarks = "";
  bool _isChanged = false;
  int? stockLotMin;
  int? stockLotMax;
  bool showBidContainer = false;


  checkSpecObject(dynamic specObj, bool sendProposal, bool isFromBid) {
    if (specObj is Specification) {
      isFiber = true;
      isYarn = false;
      isFabric = false;
      isStockLot = false;
      fiberSpecification = specObj;
      yarnSpecification = null;
      fabricSpecification = null;
      stockLotSpecification = null;
    } else if (specObj is YarnSpecification) {
      isFiber = false;
      isYarn = true;
      isFabric = false;
      isStockLot = false;
      fiberSpecification = null;
      yarnSpecification = specObj;
      fabricSpecification = null;
      stockLotSpecification = null;
    } else if (specObj is FabricSpecification) {
      isFiber = false;
      isYarn = false;
      isFabric = true;
      isStockLot = false;
      fiberSpecification = null;
      yarnSpecification = null;
      fabricSpecification = specObj;
      stockLotSpecification = null;
    } else if (specObj is StockLotSpecification) {
      isFiber = false;
      isYarn = false;
      isFabric = false;
      isStockLot = true;
      fiberSpecification = null;
      yarnSpecification = null;
      fabricSpecification = null;
      stockLotSpecification = specObj;
    }
    _isCreatorOrBidder(sendProposal, isFromBid);
  }

  _isCreatorOrBidder(bool sendProposal, bool isFromBid) async {
    var userId = await getUserId();
    if (isFiber) {
      userId != fiberSpecification!.spc_user_id
          ? _creatorOrBidderRender(false, sendProposal, isFromBid)
          : _creatorOrBidderRender(true, sendProposal, isFromBid);
    } else if (isYarn) {
      userId != yarnSpecification!.ys_user_id
          ? _creatorOrBidderRender(false, sendProposal, isFromBid)
          : _creatorOrBidderRender(true, sendProposal, isFromBid);
    } else if (isFabric) {
      userId != fabricSpecification!.fsUserId
          ? _creatorOrBidderRender(false, sendProposal, isFromBid)
          : _creatorOrBidderRender(true, sendProposal, isFromBid);
    } else if (isStockLot) {
      userId != stockLotSpecification!.userId
          ? _creatorOrBidderRender(false, sendProposal, isFromBid)
          : _creatorOrBidderRender(true, sendProposal, isFromBid);
    }
  }

  _creatorOrBidderRender(bool isCreator, bool? sendProposal, bool isFromBid) {
    if (isCreator) {
      tabsList = tabsListCreator;
      tabWidgetList = [
        DetailTabPage(
            // specification: fiberSpecification,
            // yarnSpecification: yarnSpecification,
            // specObject: isFabric ? fabricSpecification : stockLotSpecification,
          sendProposal: sendProposal,
            ),
        MatchedPage(
            catId: isFiber
                ? fiberSpecification!.categoryId!
                : isYarn
                    ? "2"
                    : isStockLot
                        ? stockLotSpecification!.stocklotCategoryId.toString()
                        : "3",
            specId: isFiber
                ? fiberSpecification!.spcId
                : isYarn
                    ? yarnSpecification!.ysId ?? 1
                    : isStockLot
                        ? stockLotSpecification!.id!
                        : fabricSpecification!.fsId!),
        BidderListPage(
            materialId: isFiber
                ? fiberSpecification!.categoryId!
                : isYarn
                    ? yarnSpecification!.category_id.toString()
                    : isStockLot
                        ? stockLotSpecification!.stocklotCategoryId.toString()
                        : "3",
            specId: isFiber
                ? fiberSpecification!.spcId
                : isYarn
                    ? yarnSpecification!.ysId ?? 1
                    : isStockLot
                        ? stockLotSpecification!.id!
                        : fabricSpecification!.fsId!)
      ];
    } else if (isFromBid) {
      tabsList = tabsListBid;
      tabWidgetList = [
        DetailTabPage(
            // specification: fiberSpecification,
            // yarnSpecification: yarnSpecification,
            // specObject: isFabric ? fabricSpecification : stockLotSpecification,
          sendProposal: sendProposal,
        ),
        HistoryOfBidsPage(
            catId: isFiber
                ? fiberSpecification!.categoryId!
                : isYarn
                    ? yarnSpecification!.category_id!.toString()
                    : isStockLot
                        ? stockLotSpecification!.stocklotCategoryId.toString()
                        : "3",
            specId: isFiber
                ? fiberSpecification!.spcId.toString()
                : isYarn
                    ? yarnSpecification!.ysId.toString()
                    : isStockLot
                        ? stockLotSpecification!.id.toString()
                        : fabricSpecification!.fsId!.toString())
      ];
    } else {
      tabsList = tabsListBidder;
      tabWidgetList = [
        DetailTabPage(
          // specification: fiberSpecification,
          // yarnSpecification: yarnSpecification,
          // specObject: isFabric ? fabricSpecification : stockLotSpecification,
          sendProposal: sendProposal,
        ),
      ];
    }

    notifyListeners();
  }

  String? setCompanyName() {
    if (isFiber) {
      return fiberSpecification!.company ?? "";
    } else if (isYarn) {
      return yarnSpecification!.company ?? "";
    } else if (isFabric) {
      return fabricSpecification!.company ?? "";
    } else if (isStockLot) {
      return stockLotSpecification!.company ?? "";
    }
    return null;
  }

  bool setVerifiedVisibility() {
    if (isFiber) {
      return Ui.showHide(fiberSpecification!.isVerified);
    } else if (isYarn) {
      return Ui.showHide(yarnSpecification!.is_verified);
    } else if (isFabric) {
      return Ui.showHide(fabricSpecification!.isVerified);
    } else if (isStockLot) {
      return Ui.showHide(stockLotSpecification!.isVerified);
    } else {
      return false;
    }
  }

  String setFamilyTitle() {
    if (isFiber) {
      return '${fiberSpecification!.formation!.isNotEmpty ? fiberSpecification!.formation!.first.blendName : ''}';
    } else if (isYarn) {
      return setFamilyData(yarnSpecification!);
    } else if (isFabric) {
      return Utils.setFabricFamilyData(fabricSpecification!);
    } else if (isStockLot) {
      return stockLotSpecification!.stocklotParentFamilyName ?? "";
    } else {
      return "";
    }
  }

  String setTitle() {
    if (isFiber) {
      return Utils.createStringFromList([
        fiberSpecification!.origin_fiber_spc,
        fiberSpecification!.productYear
      ]);
    } else if (isYarn) {
      return setTitleData(yarnSpecification!);
    } else if (isFabric) {
      return Utils.setFabricTitle(fabricSpecification!);
    } else if (isStockLot) {
      return stockLotSpecification!.availablity ?? "";
    } else {
      return "";
    }
  }

  String setDateTime() {
    if (isFiber) {
      return DateFormat("MMM dd, yyyy")
          .format(DateTime.parse(fiberSpecification!.date!));
    } else if (isYarn) {
      return DateFormat("MMM dd, yyyy")
          .format(DateTime.parse(yarnSpecification!.date!));
    } else if (isFabric) {
      return DateFormat("MMM dd, yyyy")
          .format(DateTime.parse(fabricSpecification!.date!));
    } else if (isStockLot) {
      return DateFormat("MMM dd, yyyy")
          .format(DateTime.parse(stockLotSpecification!.date!));
    } else {
      return "";
    }
  }

  stockLotPrice() {
    return Text.rich(
      TextSpan(
          children: stockLotSpecification!.specDetails!.length > 1
              ? Utils.stockLotPriceRange(stockLotSpecification!)
              : [
                  TextSpan(
                    text: stockLotSpecification!
                        .specDetails!.first.price /*'1000'*/,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        // /*fontFamily: 'Metropolis',*/,
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text:
                        "/${stockLotSpecification!.specDetails!.first.priceUnit != null ? stockLotSpecification!.specDetails!.first.priceUnit!.split(" ").first : ""}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        // /*fontFamily: 'Metropolis',*/,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
    );
  }

  bool? getPriceVisibility() {
    if (isFiber) {
      return fiberSpecification!.is_offering == offering_type;
    } else if (isYarn) {
      return yarnSpecification!.is_offering == offering_type;
    } else if (isFabric) {
      return fabricSpecification!.isOffering == offering_type;
    } else {
      return false;
    }
  }

  String setFamilyData(YarnSpecification specification) {
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
            '${specification.dtyFilament ?? ""} ${specification.fdyFilament != null ? "/${specification.fdyFilament}" : ""} ${specification.yarnFamily ?? ''}';
        break;
      case '5':
        familyData =
            '${specification.count ?? Utils.checkNullString(false)}${specification.yarnPly != null ? "/${specification.yarnPly!.substring(0, 1)}" : ""} ${specification.yarnFamily ?? ''}';
        break;
    }
    return familyData;
  }

  String setTitleData(YarnSpecification specification) {
    String titleData = "";
    switch (specification.yarnFamilyId) {
      case '1':
        titleData =
            '${specification.yarnQuality ?? Utils.checkNullString(false)} for ${specification.yarnUsage ?? Utils.checkNullString(false)}';
        break;
      case '2':
        titleData = specification.yarnBlend ?? Utils.checkNullString(false);
        break;
      case '3':
        titleData =
            specification.yarnOrientation ?? Utils.checkNullString(false);
        break;
      case '4':
        titleData = specification.yarnType ?? Utils.checkNullString(false);
        break;
      case '5':
        titleData = specification.yarnBlend ?? Utils.checkNullString(false);
        break;
    }
    return titleData;
  }

  Future<String?> getUserId() async {
    return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
  }

  List<TextSpan> setPriceText() {
    return [
      TextSpan(
        text: isFiber
            ? '${fiberSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.'
            : isYarn
                ? '${yarnSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.'
                : '${fabricSpecification!.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            /*fontFamily: 'Metropolis',*/
            fontWeight: FontWeight.w400),
      ),
      TextSpan(
        text: isFiber
            ? fiberSpecification!.priceUnit
                .toString()
                .replaceAll(RegExp(r'[^0-9]'), '')
            : isYarn
                ? yarnSpecification!.priceUnit
                    .toString()
                    .replaceAll(RegExp(r'[^0-9]'), '')
                : fabricSpecification!.priceUnit
                    .toString()
                    .replaceAll(RegExp(r'[^0-9]'), ''),
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            /*fontFamily: 'Metropolis',*/
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text:
            "/ ${isYarn ? yarnSpecification!.unitCount ?? "" : isFiber ? fiberSpecification!.unitCount ?? "" : fabricSpecification!.unitCount ?? ""}",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            /*fontFamily: 'Metropolis',*/
            fontWeight: FontWeight.w400),
      ),
    ];
  }

  setDeliveryPeriodText() {
    if (isYarn) {
      yarnSpecification!.deliveryPeriod ?? "";
    } else if (isFiber) {
      fiberSpecification!.deliveryPeriod ?? "";
    } else if (isFabric) {
      fabricSpecification!.deliveryPeriod ?? "";
    } else {
      return "";
    }
  }

  fiberDetails() {
    detailSpecification = [
      DetailTileModel('Fiber Material',
          fiberSpecification!.material ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Fiber Length',
          fiberSpecification!.length != null
              ? '${fiberSpecification!.length} mm'
              : Utils.checkNullString(false)),
      DetailTileModel(
          'Micronaire',
          fiberSpecification!.micronaire != null
              ? '${fiberSpecification!.micronaire!} mic'
              : Utils.checkNullString(false)),
      DetailTileModel(
          'Moisture',
          fiberSpecification!.moisture != null
              ? '${fiberSpecification!.moisture!} '
              : Utils.checkNullString(false)),
      DetailTileModel(
          'Trash',
          fiberSpecification!.trash != null
              ? fiberSpecification!.trash!
              : Utils.checkNullString(false)),
      DetailTileModel(
          'RD',
          fiberSpecification!.rd != null
              ? fiberSpecification!.rd!
              : Utils.checkNullString(false)),
      DetailTileModel(
          'GPT',
          fiberSpecification!.gpt != null
              ? fiberSpecification!.gpt!
              : Utils.checkNullString(false)),
      DetailTileModel(
          'Appearance',
          fiberSpecification!.apperance == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.apperance!),
      DetailTileModel(
          'Brand',
          fiberSpecification!.brand == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.brand!),
      DetailTileModel(
          'Production year',
          fiberSpecification!.productYear == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.productYear!),
      DetailTileModel(
          'Origin',
          fiberSpecification!.origin == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.origin!),
      DetailTileModel(
          'Certification',
          fiberSpecification!.certification == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.certification!),
    ];
    var newSpecifications = detailSpecification.toList();
    detailSpecification = newSpecifications
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();
    // labParameters = [
    //   GridTileModel(
    //       'Unit Of Count',
    //       _fiberSpecification!.unitCount == null
    //           ? Utils.checkNullString(false)
    //           : _fiberSpecification!.unitCount!),
    //   GridTileModel(
    //       'Price',
    //       _fiberSpecification!.priceUnit == null
    //           ? Utils.checkNullString(false)
    //           : _fiberSpecification!.priceUnit!),
    //   GridTileModel(
    //       'Packing',
    //       _fiberSpecification!.priceTerms == null
    //           ? Utils.checkNullString(false)
    //           : _fiberSpecification!.priceTerms!)
    // ];

    detailPackaging = [
      DetailTileModel(
          'Unit of Counting',
          fiberSpecification!.unitCount == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.unitCount!),
      // GridTileModel('Seller Location',
      //     _fiberSpecification!.locality ?? Utils.checkNullString(false)),
      /*GridTileModel(
          'Country',
          _fiberSpecification!.country == null
              ? Utils.checkNullString(false)
              : _fiberSpecification!.country!),*/
      DetailTileModel(
          'Price Terms',
          fiberSpecification!.priceTerms == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.priceTerms!),
      /*GridTileModel(
          'Payment Type',
          _fiberSpecification!.paymentType == null
              ? Utils.checkNullString(false)
              : _fiberSpecification!.paymentType!),*/
      /* GridTileModel(
          'LC Type',
          _fiberSpecification!.lcType == null
              ? Utils.checkNullString(false)
              : _fiberSpecification!.lcType!),*/
      DetailTileModel(
          'Price',
          fiberSpecification!.priceUnit == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.priceUnit!),
      DetailTileModel(
          'Available Quantity',
          fiberSpecification!.available == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.available!),
      DetailTileModel(
          'Delivery Period',
          fiberSpecification!.deliveryPeriod == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.deliveryPeriod!),
      DetailTileModel(
          'Minimum Quantity',
          fiberSpecification!.minQuantity == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.minQuantity!),
    ];
    if (fiberSpecification!.locality!.toUpperCase() == international) {
      detailPackaging.add(DetailTileModel(
          'Port',
          fiberSpecification!.port == null
              ? Utils.checkNullString(false)
              : fiberSpecification!.port!));
    }
    var newPackingDetails = detailPackaging.toList();
    detailPackaging = newPackingDetails
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();
  }

  fabricDetails() {
    detailSpecification = [
      DetailTileModel('Fabric Family',
          fabricSpecification!.fabricFamily ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Blends Formation',
          fabricSpecification!.formationDisplayText ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Count', fabricSpecification!.count ?? Utils.checkNullString(false)),
      DetailTileModel('Ply',
          fabricSpecification!.fabricPly ?? Utils.checkNullString(false)),
      DetailTileModel(
          'GSM', fabricSpecification!.gsmCount ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Once', fabricSpecification!.once ?? Utils.checkNullString(false)),
      DetailTileModel('Wrap Count',
          fabricSpecification!.warpCount ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Wrap Ply',
          fabricSpecification!.fabricWarpPlyName ??
              Utils.checkNullString(false)),
      DetailTileModel('No of Ends(Warp)',
          fabricSpecification!.noOfEndsWarp ?? Utils.checkNullString(false)),
      DetailTileModel('Weft Count',
          fabricSpecification!.weftCount ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Weft Ply',
          fabricSpecification!.fabricWeftPlyName ??
              Utils.checkNullString(false)),
      DetailTileModel('No of Picks(Weft)',
          fabricSpecification!.noOfPickWeft ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Type of Denim',
          fabricSpecification!.fabricDenimTypeName ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Knitting Type',
          fabricSpecification!.fabricKnittingTypeName ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Layyer',
          fabricSpecification!.fabricLayyerName ??
              Utils.checkNullString(false)),
      DetailTileModel('Loom',
          fabricSpecification!.fabricLoomName ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Width',
          fabricSpecification!.width == null
              ? Utils.checkNullString(false)
              : '${fabricSpecification!.width} ″'),
      DetailTileModel(
          'Salvedge',
          fabricSpecification!.fabricSalvedgeName ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Tucking Width',
          fabricSpecification!.tuckinWidth == null
              ? Utils.checkNullString(false)
              : '${fabricSpecification!.tuckinWidth} mm'),
      DetailTileModel('Weave',
          fabricSpecification!.fabricWeaveName ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Weave Pattern',
          fabricSpecification!.fabricWeavePatternName ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Color Treatment Method',
          fabricSpecification!.fabricColorTreatmentMethod ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Dying Technique',
          fabricSpecification!.fabricDyingTechnique ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Color', fabricSpecification!.color ?? Utils.checkNullString(false)),
      DetailTileModel('Appearance',
          fabricSpecification!.fabricApperance ?? Utils.checkNullString(false)),
      DetailTileModel('Quality',
          fabricSpecification!.fabricQuality ?? Utils.checkNullString(false)),
      DetailTileModel('Grade',
          fabricSpecification!.fabricGrade ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Certification',
          fabricSpecification!.certificationStr ??
              Utils.checkNullString(false)),
    ];
    /*_detailSpecification.add(formatFormations(_fabricSpecification!.formation!));*/
    var newSpecifications = detailSpecification.toList();
    detailSpecification = newSpecifications
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();

    /* _detailPackaging = [
      GridTileModel('Unit of Counting',
          _fabricSpecification!.unitCount ?? Utils.checkNullString(false)),
      // GridTileModel('Seller Location', _fabricSpecification!.locality ?? Utils.checkNullString(false)),
      GridTileModel(
          'Price Terms', _fabricSpecification!.priceTerms ?? Utils.checkNullString(false)),
      GridTileModel(
          'Price', _fabricSpecification!.priceUnit ?? Utils.checkNullString(false)),
      GridTileModel('Available Quantity',
          _fabricSpecification!.available ?? Utils.checkNullString(false)),
      GridTileModel('Delivery Period',
          _fabricSpecification!.deliveryPeriod ?? Utils.checkNullString(false)),
      GridTileModel('Minimum Quantity',
          _fabricSpecification!.minQuantity ?? Utils.checkNullString(false)),
    ];*/
    detailPackaging = [
      DetailTileModel(
          'Unit of Counting',
          fabricSpecification!.unitCount == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.unitCount ?? ""),
      DetailTileModel(
          'Packing',
          fabricSpecification!.fpb_cone_type_name ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Cones/Bags',
          fabricSpecification!.conesBag == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.conesBag!),
      DetailTileModel(
          'Weight/Bags',
          fabricSpecification!.weightBag == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.weightBag!),
      DetailTileModel(
          'Price Terms',
          fabricSpecification!.priceTerms == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.priceTerms!),
      DetailTileModel(
          'Price',
          fabricSpecification!.priceUnit == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.priceUnit!),
      DetailTileModel(
          'Delivery Period',
          fabricSpecification!.deliveryPeriod == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.deliveryPeriod!),
      DetailTileModel(
          'Available Quantity',
          fabricSpecification!.available == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.available!),
      DetailTileModel(
          'Minimum Quantity',
          fabricSpecification!.minQuantity == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.minQuantity!),
      DetailTileModel(
          'Country',
          fabricSpecification!.fabricCountry == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.fabricCountry!),
      DetailTileModel('Port',
          fabricSpecification!.portName ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Payment Type',
          fabricSpecification!.paymentType == null
              ? Utils.checkNullString(false)
              : fabricSpecification!.paymentType!),
      DetailTileModel('Description',
          fabricSpecification!.description ?? Utils.checkNullString(false)),
    ];
    if (fabricSpecification!.locality!.toUpperCase() == international) {
      detailPackaging
          .add(DetailTileModel('Port', '_fabricSpecification!.port'));
    }
    var newPackingDetails = detailPackaging.toList();
    detailPackaging = newPackingDetails
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();
  }

  yarnDetails() {
    detailSpecification = [
      DetailTileModel('Yarn Family',
          yarnSpecification!.yarnFamily ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Blends Formation',
          yarnSpecification!.formationDisplayText ??
              Utils.checkNullString(false)),
      DetailTileModel('Yarn Usage',
          yarnSpecification!.yarnUsage ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Count',
          yarnSpecification!.count != null
              ? '${yarnSpecification!.count}'
              : Utils.checkNullString(false)),
      DetailTileModel(
          'Ply',
          yarnSpecification!.yarnPly == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnPly!),
      DetailTileModel(
          'Doubling Method',
          yarnSpecification!.doublingMethod == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.doublingMethod!),
      DetailTileModel(
          'Orientation',
          yarnSpecification!.yarnOrientation == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnOrientation!),
      DetailTileModel(
          'Color Treatment Method',
          yarnSpecification!.yarnColorTreatmentMethod == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnColorTreatmentMethod!),
      DetailTileModel(
          'Dying Method',
          yarnSpecification!.yarnDyingMethod == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnDyingMethod!),
      DetailTileModel(
          'Color',
          yarnSpecification!.color == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.color!),
      DetailTileModel(
          'Spun Technique',
          yarnSpecification!.yarnSpunTechnique == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnSpunTechnique!),
      DetailTileModel(
          'Quality',
          yarnSpecification!.yarnQuality == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnQuality!),
      DetailTileModel('Yarn Appearance',
          yarnSpecification!.yarnApperance ?? Utils.checkNullString(false)),
      DetailTileModel('Yarn Grade',
          yarnSpecification!.yarnGrade ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Pattern',
          yarnSpecification!.yarnPattern == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnPattern!),
      DetailTileModel(
          'Pattern Characteristics',
          yarnSpecification!.yarnPatternCharectristic == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarnPatternCharectristic!),
      DetailTileModel(
          'Yarn Certification',
          yarnSpecification!.yarnCertificationStr ??
              Utils.checkNullString(false)),
    ];
    /*_detailSpecification
        .add(formatFormations(_yarnSpecification!.yarnFormation!));*/
    var newSpecifications = detailSpecification.toList();
    detailSpecification = newSpecifications
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();

    labParameters = [
      DetailTileModel(
          'Actual Yarn Count',
          yarnSpecification!.actualYarnCount == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.actualYarnCount!),
      DetailTileModel(
          'CLSP',
          yarnSpecification!.clsp == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.clsp!),
      DetailTileModel(
          'IPM/KM',
          yarnSpecification!.ys_ipm_km == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.ys_ipm_km!),
      DetailTileModel(
          'Thin Places',
          yarnSpecification!.thinPlaces == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.thinPlaces!),
      DetailTileModel(
          'Thick Places',
          yarnSpecification!.thickPlaces == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.thickPlaces!),
      DetailTileModel(
          'Naps',
          yarnSpecification!.naps == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.naps!),
      DetailTileModel(
          'Uniformity',
          yarnSpecification!.uniformity == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.uniformity!),
      DetailTileModel(
          'CV',
          yarnSpecification!.cv == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.cv!),
      DetailTileModel(
          'Hairness',
          yarnSpecification!.ys_hairness == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.ys_hairness!),
      DetailTileModel(
          'RKM',
          yarnSpecification!.ys_rkm == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.ys_rkm!),
      DetailTileModel(
          'Elongation',
          yarnSpecification!.ys_elongation == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.ys_elongation!),
      DetailTileModel(
          'TPI',
          yarnSpecification!.ys_tpi == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.ys_tpi!),
      DetailTileModel(
          'TM',
          yarnSpecification!.ys_tm == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.ys_tm!),
    ];
    var newLabParams = labParameters.toList();
    labParameters = newLabParams
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();

    detailPackaging = [
      DetailTileModel(
          'Unit of Counting',
          yarnSpecification!.unitCount == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.unitCount!),
      DetailTileModel(
          'Packing',
          yarnSpecification!.fpb_cone_type_name ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Cones/Bags',
          yarnSpecification!.conesBag == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.conesBag!),
      DetailTileModel(
          'Weight/Bags',
          yarnSpecification!.weightBag == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.weightBag!),
      DetailTileModel(
          'Price Terms',
          yarnSpecification!.priceTerms == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.priceTerms!),
      DetailTileModel(
          'Price',
          yarnSpecification!.priceUnit == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.priceUnit!),
      DetailTileModel(
          'Delivery Period',
          yarnSpecification!.deliveryPeriod == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.deliveryPeriod!),
      DetailTileModel(
          'Available Quantity',
          yarnSpecification!.available == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.available!),
      DetailTileModel(
          'Minimum Quantity',
          yarnSpecification!.minQuantity == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.minQuantity!),
      DetailTileModel(
          'Country',
          yarnSpecification!.yarn_country == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.yarn_country!),
      DetailTileModel(
          'Port', yarnSpecification!.port ?? Utils.checkNullString(false)),
      DetailTileModel(
          'Payment Type',
          yarnSpecification!.paymentType == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.paymentType!),
      DetailTileModel('Description',
          yarnSpecification!.description ?? Utils.checkNullString(false)),
    ];
    if (yarnSpecification!.locality!.toUpperCase() == international) {
      detailPackaging.add(DetailTileModel(
          'Port',
          yarnSpecification!.port == null
              ? Utils.checkNullString(false)
              : yarnSpecification!.port!));
    }
    var newPackingDetails = detailPackaging.toList();
    detailPackaging = newPackingDetails
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();
  }

  stockLotDetails() {
    detailSpecification = [
      DetailTileModel(
          'Waste',
          stockLotSpecification!.stocklotParentFamilyName ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Category',
          stockLotSpecification!.spc_category_name ??
              Utils.checkNullString(false)),
      DetailTileModel(
          'Price Terms',
          stockLotSpecification!.priceTerm != null
              ? '${stockLotSpecification!.priceTerm} '
              : Utils.checkNullString(false)),
      DetailTileModel(
          'Availability',
          stockLotSpecification!.availablity != null
              ? '${stockLotSpecification!.availablity}'
              : Utils.checkNullString(false)),
      DetailTileModel('Country',
          stockLotSpecification!.country_name ?? Utils.checkNullString(false)),
      DetailTileModel('Port',
          stockLotSpecification!.port_name ?? Utils.checkNullString(false)),
      DetailTileModel('Description',
          stockLotSpecification!.description ?? Utils.checkNullString(false)),
    ];
    var newSpecifications = detailSpecification.toList();
    detailSpecification = newSpecifications
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();

    for (var element in stockLotSpecification!.specDetails!) {
      detailPackaging = [];
      detailPackaging.add(DetailTileModel(
          'Quantity',
          element.quantity != null
              ? '${element.quantity} '
              : Utils.checkNullString(false)));

      detailPackaging.add(DetailTileModel(
          'Price',
          element.price != null
              ? '${element.price} '
              : Utils.checkNullString(false)));

      detailPackaging.add(DetailTileModel(
          'Price Unit',
          element.priceUnit != null
              ? '${element.priceUnit!.split(" ").first} '
              : Utils.checkNullString(false)));

      stockLotItems[element.subCategory.toString()] = detailPackaging;
    }

    var newPackingDetails = detailPackaging.toList();
    detailPackaging = newPackingDetails
        .where((element) =>
            element.detail.isNotEmpty && element.detail.toUpperCase() != "N/A")
        .toList();
  }

  bool getOfferingVisibility() {
    if (isFiber) {
      return fiberSpecification!.is_offering == offering_type;
    } else if (isYarn) {
      return yarnSpecification!.is_offering == offering_type;
    } else if (isFabric) {
      return fabricSpecification!.isOffering == offering_type;
    } else {
      return true;
    }
  }

  bool getDescriptionVisibility() {
    bool visible = true;
    if (isYarn) {
      if (yarnSpecification!.description == null) {
        visible = false;
      } else if (yarnSpecification!.description!.isEmpty) {
        visible = false;
      }
    } else if (isFiber) {
      if (fiberSpecification!.description == null) {
        visible = false;
      } else if (fiberSpecification!.description!.isEmpty) {
        visible = false;
      }
    } else if (isFabric) {
      if (fabricSpecification!.description == null) {
        visible = false;
      } else if (fabricSpecification!.description!.isEmpty) {
        visible = false;
      }
    } else if (isStockLot) {
      if (stockLotSpecification!.description == null) {
        visible = false;
      } else if (stockLotSpecification!.description!.isEmpty) {
        visible = false;
      }
    } else {
      visible = false;
    }
    return visible;
  }

  void setDetailData() {
    isFiber
        ? fiberDetails()
        : isYarn
            ? yarnDetails()
            : isStockLot
                ? stockLotDetails()
                : fabricDetails();
    notifyListeners();
  }

  void setBidPriceQty() {
    if (isFiber) {
      bidPrice = int.tryParse(fiberSpecification!.priceUnit!.split(" ").last);
      bidPriceFixed = bidPrice ?? 0;
      bidQuantity = int.tryParse(fiberSpecification!.minQuantity ?? "0");

      bidQuantityFixed = int.tryParse(fiberSpecification!.minQuantity ?? "0");

      minBidQuantity = int.tryParse(fiberSpecification!.minQuantity ?? "0");

      if (!_isChanged) {
        tempBidQuantity = int.tryParse(fiberSpecification!.minQuantity ?? "0");
        _isChanged = true;
      }
    } else if (isYarn) {
      bidPrice = int.tryParse(
          yarnSpecification!.priceUnit!.replaceAll(RegExp(r'[^0-9]'), ''));
      bidPriceFixed = bidPrice ?? 0;

      bidQuantity = int.tryParse(yarnSpecification!.minQuantity ?? "0");

      bidQuantityFixed = int.tryParse(yarnSpecification!.minQuantity ?? "0");

      minBidQuantity = int.tryParse(yarnSpecification!.minQuantity ?? "0");

      if (!_isChanged) {
        tempBidQuantity = int.tryParse(yarnSpecification!.minQuantity ?? "0");
        _isChanged = true;
      }
    } else if (isFabric) {
      bidPrice = int.tryParse(
          fabricSpecification!.priceUnit!.replaceAll(RegExp(r'[^0-9]'), ''));
      bidPriceFixed = bidPrice ?? 0;

      bidQuantity = int.tryParse(fabricSpecification!.minQuantity ?? "0");

      bidQuantityFixed = int.tryParse(fabricSpecification!.minQuantity ?? "0");

      minBidQuantity = int.tryParse(fabricSpecification!.minQuantity ?? "0");

      if (!_isChanged) {
        tempBidQuantity = int.tryParse(fabricSpecification!.minQuantity ?? "0");
        _isChanged = true;
      }
    } else {
      stockLotMin = Utils.stockLotPriceMin(stockLotSpecification!);

      bidPrice = stockLotMin;
      bidPriceFixed = bidPrice ?? 0;
      stockLotMax = Utils.stockLotPriceMax(stockLotSpecification!);
    }

    notifyListeners();
  }

  void notifyUI() {
    notifyListeners();
  }
}
