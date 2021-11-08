import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

Widget buildWidget() {
  return Padding(
    padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
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
              width: 48.w,
              height: 48.h,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          'Brand/Company',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textColorGreyLight,
                              fontWeight: FontWeight.w400),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: RatingBarIndicator(
                            rating: 4.2,
                            itemCount: 5,
                            itemSize: 16.0.w,
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
                              left: 4.w, right: 4.w, top: 1.w, bottom: 1.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Featured',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Icon(
                                Icons.info_rounded,
                                size: 16.sp,
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
                    padding: EdgeInsets.only(bottom: 4.0.w),
                    child: Text(
                      '100% Cotton Combed Yarn for Weaving',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
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
                              left: 8.w, right: 8.w, top: 4.w, bottom: 4.w),
                          child: Center(
                            child: Text(
                              '20/S',
                              style: TextStyle(
                                  fontSize: 9.sp, color: AppColors.textColorGrey),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileGreyClr,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8.w, right: 8.w, top: 4.w, bottom: 4.w),
                          child: Center(
                            child: Text(
                              'CLSP 2600',
                              style: TextStyle(
                                  fontSize: 9.sp, color: AppColors.textColorGrey),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileGreyClr,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8.w, right: 8.w, top: 4.w, bottom: 4.w),
                          child: Center(
                            child: Text(
                              'IPI 300',
                              style: TextStyle(
                                  fontSize: 9.sp, color: AppColors.textColorGrey),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.tileSeaGreen,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.w),
                                bottomRight: Radius.circular(8.w))),
                        child: Center(
                          child: Image.asset(
                            'images/ic_verified_supplier.png',
                            width: 52.w,
                            height: 16.h,
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
                            padding: EdgeInsets.only(top: 8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        child: Text(
                                          'Weight per Bag',
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  AppColors.textColorGreyLight),
                                        ),
                                        visible: true,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: Container(
                                    width: 0.5.w,
                                    height: 30.h,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        child: Text(
                                          'Weight per Bag',
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  AppColors.textColorGreyLight),
                                        ),
                                        visible: true,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: Container(
                                    width: 0.5.w,
                                    height: 30.h,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        child: Text(
                                          'Weight per Bag',
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  AppColors.textColorGreyLight),
                                        ),
                                        visible: true,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: Container(
                                    width: 0.5.w,
                                    height: 30.h,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        child: Text(
                                          'Weight per Bag',
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  AppColors.textColorGreyLight),
                                        ),
                                        visible: true,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: Container(
                                    width: 0.5.w,
                                    height: 30.h,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/ic_weight.png',
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Weight per Bag',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                AppColors.textColorGreyLight),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '78 KG',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: Container(
                                    width: 0.5.w,
                                    height: 30.h,
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
                            padding: EdgeInsets.only(right: 4.w),
                            child: Image.asset(
                              'images/ic_list.png',
                              height: 32.w,
                              width: 32.h,
                            )),
                        Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: Image.asset(
                              'images/ic_list.png',
                              height: 32.h,
                              width: 32.w,
                            )),
                        Image.asset(
                          'images/ic_list.png',
                          height: 32.h,
                          width: 32.w,
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
                              fontSize: 13.sp,
                              color: Colors.black87),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.w),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.btnGreen,
                                borderRadius: BorderRadius.all(Radius.circular(4.w))),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Center(
                                child: Text(
                                  'Bid Now',
                                  style: TextStyle(
                                      fontSize: 9.sp, color: Colors.white),
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
