import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class ExpandedBioWidget extends StatelessWidget {
  final String? profileUrl;
  final String? thumbnailUrl;
  final String? firstName;
  final String? lastName;
  final String? userType;
  final String? location;
  final String? height;
  final String? size;
  final String? minimumFee;
  final String? bio;

  const ExpandedBioWidget({
    super.key,
    required this.profileUrl,
    required this.thumbnailUrl,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.location,
    required this.height,
    required this.size,
    required this.minimumFee,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const VWidgetsPagePadding.horizontalSymmetric(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Flexible(
                //         child: VWidgetsPrimaryButton(
                //       enableButton: true,
                //       buttonTitle: "New Business Profile",
                //       onPressed: () {
                //         navigateToRoute(context, const BusinessProfileBaseScreen() );
                //       },
                //     )
                //     ),
                //
                //   ],
                // ),
                addVerticalSpacing(20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfilePicture(
                        url: profileUrl!,
                        headshotThumbnail: thumbnailUrl,
                        showBorder: false,
                      ),
                      addHorizontalSpacing(30),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            addVerticalSpacing(10),
                            Text(
                              '$firstName $lastName',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                            ),
                            addVerticalSpacing(6),
                            Text(
                              userType!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                  ),
                            ),
                            addVerticalSpacing(6),
                            Text(
                              location!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: VmodelColors.primaryColor
                                        .withOpacity(0.5),
                                    // color: VmodelColors.primaryColor,
                                    // fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                addVerticalSpacing(20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addVerticalSpacing(10),
                          Text(
                            height!,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                          ),
                          addVerticalSpacing(6),
                          Text(
                            "Height",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                          ),
                        ],
                      ),
                      addHorizontalSpacing(4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addVerticalSpacing(10),
                          Text(
                            size!,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                          ),
                          addVerticalSpacing(6),
                          Text(
                            "Size(UK)",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                          ),
                        ],
                      ),
                      addHorizontalSpacing(4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addVerticalSpacing(10),
                          Text(
                            minimumFee!,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                          ),
                          addVerticalSpacing(6),
                          Text(
                            "Minimum Fee",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                          ),
                        ],
                      )
                    ]),
                addVerticalSpacing(30),
                Text(
                  "Full Description",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(6),
                Text(
                  bio!,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                addVerticalSpacing(20),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 16.0,
        //   ),
        //   child: VWidgetsPrimaryButton(
        //     onPressed: () {},
        //     enableButton: true,
        //     buttonTitle: "Book Now",
        //   ),
        // ),
        addVerticalSpacing(40),
      ],
    );
  }
}
