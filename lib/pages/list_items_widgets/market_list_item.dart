import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yg_app/utils/colors.dart';

Widget buildWidget() {
  return Padding(
    padding: EdgeInsets.only(left: 16.0, right: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/ic_list.png',
              width: 48,
              height: 48,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          'Brand/Company',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textColorGreyLight,
                              fontWeight: FontWeight.w400),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: RatingBarIndicator(
                            rating: 4.2,
                            itemCount: 5,
                            itemSize: 16.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        color: AppColors.pintFeatureClr,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 4, right: 4, top: 1, bottom: 1),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Featured',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Icon(
                                Icons.info_rounded,
                                size: 16,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '100% Cotton Combed Yarn for Weaving',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileGreyClr,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          child: Center(
                            child: Text(
                              '20/S',
                              style: TextStyle(
                                  fontSize: 9, color: AppColors.textColorGrey),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileGreyClr,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          child: Center(
                            child: Text(
                              'CLSP 2600',
                              style: TextStyle(
                                  fontSize: 9, color: AppColors.textColorGrey),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileGreyClr,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          child: Center(
                            child: Text(
                              'IPI 300',
                              style: TextStyle(
                                  fontSize: 9, color: AppColors.textColorGrey),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileSeaGreen,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Center(
                          child: Image.asset(
                            'images/ic_verified_supplier.png',
                            width: 52,
                            height: 20,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12,
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Weight per Bag',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                AppColors.textColorGreyLight),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    width: 0.5,
                                    height: 30,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12,
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Weight per Bag',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                AppColors.textColorGreyLight),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    width: 0.5,
                                    height: 30,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12,
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Weight per Bag',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                AppColors.textColorGreyLight),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    width: 0.5,
                                    height: 30,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12,
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Weight per Bag',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                AppColors.textColorGreyLight),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    width: 0.5,
                                    height: 30,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12,
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Weight per Bag',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                AppColors.textColorGreyLight),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    width: 0.5,
                                    height: 30,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Image.asset(
                              'images/ic_list.png',
                              height: 32,
                              width: 32,
                            )),
                        Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Image.asset(
                              'images/ic_list.png',
                              height: 32,
                              width: 32,
                            )),
                        Image.asset(
                          'images/ic_list.png',
                          height: 32,
                          width: 32,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'PKR 22,000',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.black87),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.btnGreen,
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 8),
                              child: Center(
                                child: Text(
                                  'Bid Now',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          flex: 9,
        ),
      ],
    ),
  );
}
