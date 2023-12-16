import 'package:flutter/material.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../../../../shared/username_verification.dart';

class VWidgetsJobBookerApplicationsCard extends StatefulWidget {
  final String profileName;
  final String? profileImage;
  final String? profileType;
  final String? rating;
  final String? ratingCount;
  final String? offerPrice;
  final bool? isOfferAccepted;
  final String? profilePictureUrl;
  final String? profilePictureUrlThumbnail;
  final VoidCallback onPressedViewProfile;
  final Future<void> Function(String)? onPressedAcceptOffer;
  final bool isIDVerified;
  final bool isBlueTickVerified;
  final String? displayName;

  const VWidgetsJobBookerApplicationsCard({
    super.key,
    required this.profilePictureUrl,
    required this.profilePictureUrlThumbnail,
    required this.isOfferAccepted,
    required this.profileName,
    required this.profileImage,
    required this.profileType,
    required this.rating,
    required this.ratingCount,
    required this.offerPrice,
    required this.onPressedViewProfile,
    required this.displayName,
    this.onPressedAcceptOffer,
    this.isIDVerified = false,
    this.isBlueTickVerified = false,
  });

  @override
  State<VWidgetsJobBookerApplicationsCard> createState() =>
      _VWidgetsJobBookerApplicationsCardState();
}

class _VWidgetsJobBookerApplicationsCardState
    extends State<VWidgetsJobBookerApplicationsCard> {
  bool isOfferAccepted = false;

  @override
  void initState() {
    isOfferAccepted = widget.isOfferAccepted!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      // child: Card(
      //   elevation: 3,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Column(
          children: [
            ///Parent Row

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfilePicture(
                  url: widget.profilePictureUrl,
                  headshotThumbnail: widget.profilePictureUrlThumbnail,
                  displayName: widget.displayName,
                  size: 60,
                ),
                // if (widget.profilePictureUrl!.isEmpty ||
                //     widget.profilePictureUrl == "")
                //   Container(
                //     height: 60,
                //     width: 60,
                //     decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Theme.of(context).primaryColor,
                //         image: DecorationImage(
                //             fit: BoxFit.cover,
                //             image: AssetImage(widget.profileImage!))),
                //   ),
                addHorizontalSpacing(15),
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: VerifiedUsernameWidget(
                              username: widget.profileName,
                              // displayName: profileFullName,
                              isVerified: widget.isIDVerified,

                              blueTickVerified: widget.isBlueTickVerified,
                              rowMainAxisAlignment: MainAxisAlignment.start,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                              useFlexible: true,
                            ),
                            // Text(
                            //   widget.profileName! + "lslslxo",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .displayMedium!
                            //       .copyWith(
                            //         color: Theme.of(context).primaryColor,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const RenderSvg(
                                  svgPath: VIcons.star,
                                  svgHeight: 20,
                                  svgWidth: 20,
                                ),
                                addHorizontalSpacing(4),
                                Text(
                                  "${widget.rating} (${widget.ratingCount})",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpacing(6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.profileType!.toUpperCase(),
                              style: Theme.of(context).textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("£ ${widget.offerPrice}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith()),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpacing(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                addHorizontalSpacing(5),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor,
                          side: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: widget.onPressedViewProfile,
                        child: Text(
                          "View Profile",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      addHorizontalSpacing(5),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).primaryColor,
                          side: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          widget.onPressedAcceptOffer!(widget.profileName);
                          setState(() {
                            isOfferAccepted = true;
                          });
                        },
                        child: Text(
                          isOfferAccepted ? "Accepted" : "Accept",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///Profile type Row
          ],
        ),
        // ),
      ),
    );
  }
}
