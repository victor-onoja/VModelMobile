import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/settings/widgets/my_network_card.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../../shared/modal_pill_widget.dart';
import '../../../../shared/shimmer/connections_shimmer.dart';
import '../../../connection/controller/provider/my_connections_controller.dart';
import '../../new_profile/views/other_profile_router.dart';
import 'network_connections_search.dart';
import 'network_received_requests_page.dart';
import 'network_sent_requests_page.dart';

class Connections extends ConsumerStatefulWidget {
  const Connections({super.key});

  @override
  ConsumerState<Connections> createState() => _NetworkPageState();
}

class _NetworkPageState extends ConsumerState<Connections> {
  TextEditingController searchController = TextEditingController();
  late final Debounce _debounce;
  // FocusNode myFocusNode = FocusNode();
  @override
  initState() {
    super.initState();
    _debounce = Debounce(delay: Duration(milliseconds: 300));
  }

  @override
  dispose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connections = ref.watch(getConnections);
    final sortByLatestFirst = ref.watch(myConnectionsSortTypeProvider);
    return Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          appbarTitle: "Connections",
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
                              bottom: VConstants.bottomPaddingForBottomSheets,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                addVerticalSpacing(15),
                                const Align(
                                    alignment: Alignment.center,
                                    child: VWidgetsModalPill()),
                                addVerticalSpacing(25),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      print(
                                          '[dff] Eariliest value is $sortByLatestFirst');
                                      ref
                                          .read(myConnectionsSortTypeProvider
                                              .notifier)
                                          .state = true;
                                      // ref.invalidate(getConnections);
                                      if (context.mounted) goBack(context);
                                    },
                                    child: Text('Most Recent',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ),
                                ),
                                const Divider(thickness: 0.5),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // sortByLatestFirst = false;
                                      ref
                                          .read(myConnectionsSortTypeProvider
                                              .notifier)
                                          .state = false;
                                      print(
                                          '[dff] Eariliest value is $sortByLatestFirst');
                                      // ref.invalidate(getConnections);
                                      if (context.mounted) goBack(context);
                                    },
                                    child: Text('Earliest',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
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
        ),
        body: connections.when(
            data: (Either<CustomException, List<dynamic>> data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SearchTextFieldWidget(
                        hintText: "Search...",
                        autofocus: false,
                        // focusNode: myFocusNode,
                        controller: searchController,
                        onTap: () {
                          ref.read(activateSearchProvider.notifier).state =
                              true;
                          // searchController.clear();
                        },
                        onTapOutside: (value) {
                          // myFocusNode.unfocus();
                          ref.read(activateSearchProvider.notifier).state =
                              false;
                        },
                        onCancel: () {
                          // myFocusNode.unfocus();
                          ref.read(activateSearchProvider.notifier).state =
                              false;
                          searchController.clear();
                          // setState(() {});
                          // ref.invalidate(getConnections);
                        },
                        onChanged: (value) {
                          print('[vcc] new sarch term: $value');
                          _debounce(() => ref
                              .read(myConnectionsSearchProvider.notifier)
                              .state = value);
                        },
                      ),
                      // child: GestureDetector(
                      //   onTap: () {
                      //     navigateToRoute(context, NetworkPageSearch());
                      //   },
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      //     width: double.maxFinite,
                      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      //       color: Theme.of(context)
                      //           .buttonTheme
                      //           .colorScheme!
                      //           .secondary,
                      //     ),
                      //     child: Text(
                      //       'Search...',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .displayMedium!
                      //           .copyWith(
                      //               color: Theme.of(context)
                      //                   .primaryColor
                      //                   .withOpacity(0.5),
                      //               fontSize: 11.sp,
                      //               overflow: TextOverflow.clip),
                      //     ),
                      //   ),
                      // ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15.0),
                    //   child: VWidgetsTextButton(
                    //     onPressed: () {},
                    //     text: "Cancel",
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                child: Row(
                  children: [
                    VWidgetsTextButton(
                      text: "Received requests",
                      onPressed: () {
                        ref.refresh(getRecievedConnections);
                        navigateToRoute(context, const ReceivedRequests());
                      },
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                              fontSize: 10.sp),
                    ),
                    const Spacer(),
                    VWidgetsTextButton(
                      text: "Sent requests",
                      onPressed: () {
                        ref.refresh(getSentConnections);
                        navigateToRoute(context, const SentRequests());
                      },
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                              fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              addVerticalSpacing(8),
              if (ref.watch(activateSearchProvider)) NetworkPageSearch(),
              if (!ref.watch(activateSearchProvider))
                Expanded(
                  child: data.fold(
                    (p0) => Text(p0.message),
                    (p0) {
                      return RefreshIndicator.adaptive(
                        onRefresh: () async {
                          HapticFeedback.lightImpact();
                          ref.refresh(getConnections.future);
                        },
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: p0.length,
                          itemBuilder: (BuildContext context, int index) {
                            var connection = p0[index];
                            return Padding(
                                padding: const VWidgetsPagePadding
                                    .horizontalSymmetric(18),
                                child: VWidgetsNetworkPageCard(
                                  onPressedRemove: () {
                                    showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              bottom: VConstants
                                                  .bottomPaddingForBottomSheets,
                                            ),
                                            decoration: BoxDecoration(
                                              // color: VmodelColors
                                              //     .appBarBackgroundColor,
                                              color: context.theme
                                                  .scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                              ),
                                            ),
                                            child:
                                                VWidgetsConfirmationBottomSheet(
                                              dialogMessage:
                                                  "Are you sure you want to remove this connection?",
                                              actions: [
                                                VWidgetsBottomSheetTile(
                                                  message: "Yes",
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                            connectionProvider)
                                                        .deleteConnection(
                                                            int.parse(
                                                                connection[
                                                                    'id']));
                                                    ref.refresh(
                                                        getRecievedConnections);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                const Divider(
                                                  thickness: 0.5,
                                                ),
                                                VWidgetsBottomSheetTile(
                                                  message: "No",
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  onPressedProfile: () {
                                    navigateToRoute(
                                        context,
                                        OtherProfileRouter(
                                          username: connection['username'],
                                        ));
                                    // navigateToRoute(
                                    //     context,
                                    //     const ProfileMainView(
                                    //         profileTypeEnumConstructor:
                                    //             ProfileTypeEnum.personal));
                                  },
                                  userImage: connection['profilePictureUrl'] ??
                                      "assets/images/models/listTile_3.png",
                                  userImageThumbnail:
                                      connection['thumbnailUrl'] ??
                                          "assets/images/models/listTile_3.png",
                                  userImageStatus:
                                      connection['profilePictureUrl'] == null
                                          ? false
                                          : true,
                                  displayName: '${connection['displayName']}',
                                  title:
                                      // '${connection['firstName']} ${connection['lastName']}',
                                      '${connection['username']}',
                                  subTitle:
                                      '${connection['label'] ?? VMString.noSubTalentErrorText}',
                                  isVerified: connection['isVerified'],
                                  blueTickVerified:
                                      connection['blueTickVerified'],
                                ));
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        }, loading: () {
          // return const ConnectionShimmerPage();
          return const ConnectionsShimmerPage();
        }, error: (Object error, StackTrace stackTrace) {
          return Text(stackTrace.toString());
        }));
  }
}
