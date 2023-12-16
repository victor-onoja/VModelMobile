import 'package:vmodel/src/features/jobs/job_market/views/business_user/business_offers_details_page.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/business_user/business_offers_homepage_card.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class BusinessOffersPage extends StatelessWidget {
  const BusinessOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Offers",
      ),
      body: SingleChildScrollView(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(children: [
          addVerticalSpacing(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Today", // e.msg.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: VmodelColors.primaryColor.withOpacity(1),
                    ),
              ),
            ],
          ),
          addVerticalSpacing(5),
          VWidgetsBusinessOffersHomePageCard(
              senderProfileImage: VmodelAssets2.imageContainer,
              jobSender: "Jimmy",
              viewOnPressed: () {
                navigateToRoute(context, const BusinessOfferDetailsPage());
              },
              acceptedOnPressed: () {},
              receivedJobTime: "5 min"),
              VWidgetsBusinessOffersHomePageCard(
              senderProfileImage: VmodelAssets2.imageContainer,
              jobSender: "Jimmy",
              viewOnPressed: () {
                    navigateToRoute(context, const BusinessOfferDetailsPage());
              },
              acceptedOnPressed: () {},
              receivedJobTime: "10 min"),
              VWidgetsBusinessOffersHomePageCard(
              senderProfileImage: VmodelAssets2.imageContainer,
              jobSender: "Jimmy",
              viewOnPressed: () {
                    navigateToRoute(context, const BusinessOfferDetailsPage());
              },
              acceptedOnPressed: () {},
              receivedJobTime: "15 min"),

          const Divider(
            thickness: 1,
          ),
          addVerticalSpacing(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "This Week", // e.msg.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: VmodelColors.primaryColor,
                    ),
              ),
            ],
          ),
          addVerticalSpacing(5),
          VWidgetsBusinessOffersHomePageCard(
              senderProfileImage: VmodelAssets2.imageContainer,
              jobSender: "Jimmy",
              viewOnPressed: () {
                    navigateToRoute(context, const BusinessOfferDetailsPage());
              },
              acceptedOnPressed: () {},
              receivedJobTime: "3d"),
              VWidgetsBusinessOffersHomePageCard(
              senderProfileImage: VmodelAssets2.imageContainer,
              jobSender: "Jimmy",
              viewOnPressed: () {
                    navigateToRoute(context, const BusinessOfferDetailsPage());
              },
              acceptedOnPressed: () {},
              receivedJobTime: "3d"),
              VWidgetsBusinessOffersHomePageCard(
              senderProfileImage: VmodelAssets2.imageContainer,
              jobSender: "Jimmy",
              viewOnPressed: () {
                    navigateToRoute(context, const BusinessOfferDetailsPage());
              },
              acceptedOnPressed: () {},
              receivedJobTime: "3d"),
        ]),
      ),
    );
  }
}
