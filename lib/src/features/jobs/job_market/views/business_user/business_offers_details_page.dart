import 'package:vmodel/src/features/dashboard/menu_settings/menu_sheet.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/business_user/business_offers_details_page_card.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/vmodel.dart';

class BusinessOfferDetailsPage extends StatelessWidget {
  const BusinessOfferDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Offers",
        trailingIcon: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  useRootNavigator: true,
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  anchorPoint: const Offset(0, 200),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  builder: ((context) => const MenuSheet()),
                );
              },
              icon: circleIcon),
        ],
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(children: [
          addVerticalSpacing(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VWidgetsTextButton(
                text: "Previous",
                onPressed: () {},
              ),
              VWidgetsTextButton(
                text: "Next",
                onPressed: () {},
              ),
            ],
          ),
          addVerticalSpacing(10),
           const Expanded(
            child: SingleChildScrollView(
              child:  Column(
                children: [
                  VWidgetsBusinessOfferDetailsCard(
                    profileImage: VmodelAssets2.imageContainer,
                    profileName: "Tilly's Bakery Services",
                    jobDescription:
                        "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models, 2 female models and one camera man. Interested parties should apply below, thanks!",
                    jobRating: "4.5",
                    jobTotalFee: "450",
                    aboutDescription:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    contratLength: '3 hours',
                    gender: 'Male',
                    jobLocation: 'London, UK',
                    jobPricePerTime: '150/hr',
                    jobStartDate: 'Tue, 13th December 2022',
                    profileType: 'Photographer',
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: VWidgetsPrimaryButton(
                    buttonTitle: "Decline",
                    enableButton: true,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => VWidgetsConfirmationPopUp(
                              popupTitle: "Decline Offer",
                              popupDescription:
                                  "Are you sure you want to decline this offer?",
                              onPressedYes: () {},
                              onPressedNo: () {
                                Navigator.pop(context);
                              })));
                    }),
              ),
              addHorizontalSpacing(8),
              Flexible(
                child: VWidgetsPrimaryButton(
                    buttonTitle: "Accept",
                    enableButton: true,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => VWidgetsConfirmationPopUp(
                              popupTitle: "Accept Offer",
                              popupDescription:
                                  "Are you sure you want to accept this offer?",
                              onPressedYes: () {},
                              onPressedNo: () {
                                Navigator.pop(context);
                              })));
                    }),
              ),
            ],
          ),
          addVerticalSpacing(20),
        ]),
      ),
    );
  }
}
