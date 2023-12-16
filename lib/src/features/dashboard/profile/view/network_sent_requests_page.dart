import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/features/settings/widgets/my_network_card.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../shared/empty_page/empty_page.dart';
import '../../../../shared/modal_pill_widget.dart';
import '../../../../shared/shimmer/connections_shimmer.dart';
import '../widget/network_search_empty_widget.dart';

class SentRequests extends ConsumerStatefulWidget {
  const SentRequests({super.key});

  @override
  ConsumerState<SentRequests> createState() => _SentRequestsState();
}

class _SentRequestsState extends ConsumerState<SentRequests> {
  TextEditingController searchController = TextEditingController();
  final Debounce _debounce = Debounce();
  bool sortByRecent = true;

  @override
  dipose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sentConnections = ref.watch(getSentConnections);

    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(
          onTap: () {
            ref.refresh(getConnections);
            Navigator.pop(context);
          },
        ),
        appbarTitle: "Sent Requests",
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
                                    sortByRecent = true;
                                    if (mounted) setState(() {});
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
                                    sortByRecent = false;
                                    if (mounted) setState(() {});
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
      body: Column(
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
                  hintText: "Search",
                  controller: searchController,
                  onChanged: (value) {
                    _debounce(
                      () {
                        ref
                            .read(connectionGeneralSearchProvider.notifier)
                            .state = value;
                      },
                    );
                  },
                  // suffixIcon: IconButton(
                  //     onPressed: () {
                  //       searchController.clear();
                  //     },
                  //     icon: const RenderSvg(
                  //       svgPath: VIcons.roundedCloseIcon,
                  //       svgHeight: 20,
                  //       svgWidth: 20,
                  //     )),
                )),
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
          addVerticalSpacing(8),
          sentConnections.when(
              data: (Either<CustomException, List<dynamic>> data) {
            return Expanded(
              child: data.fold(
                (left) => Text(left.message),
                (right) {
                  if (right.isEmpty && !searchController.text.isEmptyOrNull) {
                    return EmptySearchResultsWidget();
                  }
                  right.sort((a, b) {
                    var first = a['createdAt'];
                    var last = b['createdAt'];
                    if (!sortByRecent) return first.compareTo(last);
                    return last.compareTo(first);
                  });
                  return RefreshIndicator.adaptive(
                    onRefresh: () async{
                      HapticFeedback.lightImpact();
                      ref.refresh(getSentConnections.future);
                    },
                    child: right.isEmpty
                        ? EmptyPage(
                            svgPath: VIcons.documentLike,
                            svgSize: 30,
                            subtitle: "No connection requests sent",
                          )
                        : ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: right.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = right[index];
                              var connection = item['connection'];
                              print(connection['id']);

                              return Padding(
                                  padding: const VWidgetsPagePadding
                                      .horizontalSymmetric(18),
                                  child: item['accepted'] == false
                                      ? VWidgetsNetworkPageCard(
                                          onPressedRemove: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) =>
                                                    VWidgetsConfirmationPopUp(
                                                        popupTitle:
                                                            "Remove Connection",
                                                        popupDescription:
                                                            'Are you sure you want to withdraw your sent connection request?',
                                                        onPressedYes: () {
                                                          ref
                                                              .read(
                                                                  connectionProvider)
                                                              .deleteConnection(
                                                                  int.parse(item[
                                                                      'id']));
                                                          ref.refresh(
                                                              getSentConnections);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        onPressedNo: () {
                                                          Navigator.pop(
                                                              context);
                                                        })));
                                          },
                                          onPressedProfile: () {
                                            navigateToRoute(
                                                context,
                                                OtherUserProfile(
                                                  username:
                                                      connection['username'],
                                                ));
                                            // navigateToRoute(
                                            //     context,
                                            //     const ProfileMainView(
                                            //         profileTypeEnumConstructor:
                                            //             ProfileTypeEnum.personal));
                                          },
                                          userImage:
                                              connection['profilePictureUrl'],
                                          userImageThumbnail:
                                              connection['thumbnailUrl'],
                                          userImageStatus:
                                              connection['profilePictureUrl'] ==
                                                      null
                                                  ? false
                                                  : true,
                                          subTitle:
                                              '${connection['label'] ?? VMString.noSubTalentErrorText}',
                                          // userNickName:
                                          //     '${connection['firstName']} ${connection['lastName']}',
                                          displayName:
                                              '${connection['displayName']}',
                                          title: '${connection['username']}',
                                          isVerified: connection['isVerified'],
                                          blueTickVerified:
                                              connection['blueTickVerified'],
                                        )
                                      : const SizedBox.shrink());
                            },
                          ),
                  );
                },
              ),
            );
          }, loading: () {
            // return const ConnectionsShimmerPage();

            return Expanded(child: ConnectionsShimmerPage());
            // return Expanded(
            //   child: ListView.separated(
            //       itemCount: 4,
            //       padding: EdgeInsets.symmetric(horizontal: 18),
            //       shrinkWrap: true,
            //       separatorBuilder: (context, index) {
            //         return addVerticalSpacing(16);
            //       },
            //       itemBuilder: (context, index) {
            //         return CircleAvatarTwoLineTileShimmer();
            //       }),
            // );
          }, error: (Object error, StackTrace stackTrace) {
            return const Text("");
          }),
        ],
      ),
    );
  }
}
