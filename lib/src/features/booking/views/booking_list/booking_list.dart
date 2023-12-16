
import 'package:vmodel/src/features/booking/widgets/booking_list_homepage_card.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';

import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  bool noBookingData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        backgroundColor: VmodelColors.white,
        appbarTitle: "Bookings",
        appBarHeight: 50,
        leadingIcon: const  VWidgetsBackButton(),
        
        trailingIcon: [
          IconButton(
              // padding: const EdgeInsets.only(top: 12),
              onPressed: () {
                print('nothing here');
                //openVModelMenu(context, isNotTabScreen: true);
              },
              icon: listSortingIcon),
        ],
      ),
      body: noBookingData == true ? Center(child: Text('No Booking Yet!', style: VModelTypography1.normalTextStyle.copyWith(
        color: VmodelColors.primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 11.sp,
      ),),) : Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [

            Text('This Month', style: VModelTypography1.normalTextStyle.copyWith(
              color: VmodelColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
            ),),
            const BookingListHomeCards(
              titleText: 'Tilly’s Bakery Services',
              date: '7th May',
              bookingImage: '',
              location: 'Lagos State',
              amount: '10',
              rating: ' 4.5',
            ),
            const BookingListHomeCards(
              titleText: 'Tilly’s Bakery Services',
              date: '7th May',
              bookingImage: '',
              location: 'Lagos State',
              amount: '10',
              rating: ' 4.5',
            ),
            addVerticalSpacing(10),
            Text('April', style: VModelTypography1.normalTextStyle.copyWith(
              color: VmodelColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
            ),),
            const BookingListHomeCards(
              titleText: 'Tilly’s Bakery Services',
              date: '7th May',
              bookingImage: '',
              location: 'Lagos State',
              amount: '10',
              rating: ' 4.5',
            ),
            const BookingListHomeCards(
              titleText: 'Tilly’s Bakery Services',
              date: '7th May',
              bookingImage: '',
              location: 'Lagos State',
              amount: '10',
              rating: ' 4.5',
            ),
            const BookingListHomeCards(
              titleText: 'Tilly’s Bakery Services',
              date: '7th May',
              bookingImage: '',
              location: 'Lagos State',
              amount: '10',
              rating: ' 4.5',
            ),
          ],
        ),
      ),
    );
  }
}
