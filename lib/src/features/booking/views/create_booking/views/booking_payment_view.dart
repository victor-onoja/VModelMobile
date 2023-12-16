import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/features/booking/views/create_booking/views/booking_payment_completetd.dart';
import 'package:vmodel/src/features/dashboard/profile/widget/user_profile/payment_checkout_info.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field_with_logos.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class BookingCheckoutPaymentView extends StatefulWidget {
  const BookingCheckoutPaymentView({Key? key}) : super(key: key);

  @override
  _BookingCheckoutPaymentViewState createState() =>
      _BookingCheckoutPaymentViewState();
}

class _BookingCheckoutPaymentViewState
    extends State<BookingCheckoutPaymentView> {
  LogoDropDownObject? val = LogoDropDownObject(
    logo: SvgPicture.asset(
      VIcons.card,
      width: 30,
      height: 20,
    ),
    logoValue: "Personal ****3456",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Checkout",
        appBarHeight: 50,
        leadingIcon: const  VWidgetsBackButton(),
        
        backgroundColor: VmodelColors.background,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                addVerticalSpacing(20),
                const CheckOutInfo(),
                addVerticalSpacing(30),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: VWidgetsDropDownTextFieldWithLogos(
                    fieldLabel: "Payment method",
                    hintText: "",
                    options: [
                      LogoDropDownObject(
                        logo: SvgPicture.asset(
                          VIcons.card,
                          width: 30,
                          height: 20,
                        ),
                        logoValue: "Personal ****3456",
                      ),
                      LogoDropDownObject(
                        logo: SvgPicture.asset(
                          VIcons.paypal,
                          width: 30,
                          height: 20,
                        ),
                        logoValue: "Paypal",
                      ),
                      LogoDropDownObject(
                        logo: const Text(""),
                        logoValue: "New payment card",
                      ),
                    ],
                    value: val!.logoValue,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        val!.logoValue = value;
                      });
                    },
                  ),
                ),
                addVerticalSpacing(20),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: VWidgetsPrimaryTextFieldWithTitle(
                    label: "Card Number",
                    hintText: "Ex. 1234 5678 1234 5678",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: VmodelColors.unselectedText),
                    hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.boldGreyText),
                  ),
                ),
                addVerticalSpacing(20),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: VWidgetsPrimaryTextFieldWithTitle(
                    label: "Card holder name",
                    hintText: "Ex. Jane Cooper",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: VmodelColors.unselectedText),
                    hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.boldGreyText),
                  ),
                ),
                addVerticalSpacing(20),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: VWidgetsPrimaryTextFieldWithTitle(
                          label: "Expiration date",
                          hintText: "MM/YY",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: VmodelColors.unselectedText),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: VmodelColors.boldGreyText),
                        ),
                      ),
                      addHorizontalSpacing(10),
                      Flexible(
                        child: VWidgetsPrimaryTextFieldWithTitle(
                          label: "Security code",
                          hintText: "CVC",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: VmodelColors.unselectedText),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: VmodelColors.boldGreyText),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpacing(20),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: VWidgetsPrimaryButton(
                    onPressed: () {
                      navigateToRoute(context, const PaymentCompletedView());
                    },
                    buttonTitle: 'Confirm payment · £155.00',
                    enableButton: true,
                    buttonTitleTextStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                  ),
                ),
                addVerticalSpacing(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
