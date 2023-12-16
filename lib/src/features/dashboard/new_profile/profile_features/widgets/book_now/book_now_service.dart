import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/features/booking/views/create_booking/views/create_booking_view.dart';
import 'package:vmodel/src/features/create_contract/views/create_contract_view.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

bookNowFunction(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => Container(
      margin: const EdgeInsets.only(
        bottom: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...createBookingOptions(context).map((e) {
            return Container(
              decoration: BoxDecoration(
                color: VmodelColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: double.infinity,
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
              height: 50,
              child: MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: e.onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      e.label.toString(),
                      style: e.label == 'Cancel'
                          ? Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: VmodelColors.primaryColor)
                          : Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}

List<UploadOptions> createBookingOptions(BuildContext context) {
  return [
    UploadOptions(
        label: "Create a booking",
        onTap: () {
          navigateToRoute(context, const BookingViewOld());
        }),
    UploadOptions(
        label: "Create a smart contract",
        onTap: () {
          navigateToRoute(context, const CreateContractView());
        }),
    UploadOptions(
        label: "Cancel",
        onTap: () {
          Navigator.pop(context);
        }),
  ];
}
