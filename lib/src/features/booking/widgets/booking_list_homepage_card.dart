import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';

class BookingListHomeCards extends StatelessWidget {

  final String? titleText;
  final String? date;
  final String? bookingImage;
  final String? location;
  final String? amount;
  final String? rating;
  final VoidCallback? onPressedLike;
  final VoidCallback? onTapCard;

  const BookingListHomeCards({super.key,
    this.titleText,
    this.date,
    this.bookingImage,
    this.location,
    this.amount,
    this.rating,
    this.onPressedLike,
    this.onTapCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: 80,
      width:double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), //border corner radius
        boxShadow:[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), //color of shadow
            spreadRadius: 3, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: ListTile(
        leading:  Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/backgrounds/bg.jpeg"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange),
          height: 100,
          width: 60,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titleText!, style: VModelTypography1.normalTextStyle.copyWith(
                  color: VmodelColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),),
                Text(date!, style: VModelTypography1.normalTextStyle.copyWith(
                  color: VmodelColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                ),),
              ],
            ),
            addVerticalSpacing(15),
            SizedBox(
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row( // For location
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: VmodelColors.primaryColor, size: 14.sp,),
                    Text(location!, style: VModelTypography1.normalTextStyle.copyWith(
                      color: VmodelColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),),
                  ],
                ),
                Row( // For Amount
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    walletIcon,
                    addHorizontalSpacing(5),
                    Text('\$$amount', style: VModelTypography1.normalTextStyle.copyWith(
                      color: VmodelColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),),
                  ],),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,                  children: [
                    starRatingIcon,
                    Text(rating!, style: VModelTypography1.normalTextStyle.copyWith(
                      color: VmodelColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),),

                  ],
                )
              ],
            ),
          ),
        ],),
        //trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
