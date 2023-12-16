import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/coupons_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/models/app_user.dart';
import '../../../core/utils/costants.dart';
import '../../../shared/appbar/appbar.dart';
import '../../../shared/modal_pill_widget.dart';
import '../../create_coupons/controller/create_coupon_controller.dart';
import '../../dashboard/profile/controller/profile_controller.dart';

class UserCoupons extends ConsumerStatefulWidget {
  const UserCoupons({
    super.key,
    required this.username,
    this.showAppBar = true,
  });
  final String? username;
  final bool showAppBar;

  @override
  ConsumerState<UserCoupons> createState() => _UserCouponsState();
}

class _UserCouponsState extends ConsumerState<UserCoupons> {
  // final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
    VAppUser? user;
    if (isCurrentUser) {
      final appUser = ref.watch(appUserProvider);
      user = appUser.valueOrNull;
    } else {
      final appUser = ref.watch(profileProvider(widget.username));
      user = appUser.valueOrNull;
    }
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    final userCoupons = ref.watch(userCouponsProvider(requestUsername));
    // final userCoupons = ref.watch(userCouponsProvider());
    // final userState = ref.watch(appUserProvider);
    // final user = userState.valueOrNull;
    return Scaffold(
        appBar: !widget.showAppBar
            ? null
            : VWidgetsAppBar(
                leadingIcon: const VWidgetsBackButton(),
                appbarTitle: "Your Coupons",
                trailingIcon: [
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom:
                                        VConstants.bottomPaddingForBottomSheets,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(13),
                                      topRight: Radius.circular(13),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      addVerticalSpacing(15),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: VWidgetsModalPill()),
                                      addVerticalSpacing(25),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: GestureDetector(
                                          child: Text('Most Recent',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                        ),
                                      ),
                                      const Divider(thickness: 0.5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: GestureDetector(
                                          child: Text('Earliest',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                        ),
                                      ),
                                      addVerticalSpacing(40),
                                    ],
                                  ));
                            });
                      },
                      icon: const RenderSvg(
                        svgPath: VIcons.sort,
                      ))
                ],
                // trailingIcon: [
                // if (isCurrentUser)
                //   IconButton(
                //       onPressed: () {
                //         navigateToRoute(context, const UserJobsPage());
                //       },
                //       icon: const RenderSvg(svgPath: VIcons.addServiceOutline))
                // ],
              ),
        body: userCoupons.when(data: (items) {
          if (items.isEmpty) {
            return SingleChildScrollView(
              padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              child: Column(
                children: [
                  addVerticalSpacing(20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.5, // Expand to fill available space
                    child: Center(
                      child: Text(
                        'No coupons created',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.5),
                                  // fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              );
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CouponsWidget(
                  thumbnail: user?.thumbnailUrl ?? "",
                  couponId: items[index].id,
                  couponTitle: items[index].title.capitalizeFirstVExt,
                  couponCode: items[index].code.toUpperCase(),

                  // couponTitle: "40% Off Nike",
                  // couponCode: "NIKEWELCOME40",
                ),
              );
            },
          );
        }, error: ((error, stackTrace) {
          return Center(child: Text("Error getting coupons"));
        }), loading: () {
          return Center(child: CircularProgressIndicator.adaptive());
        }));
  }
}
