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

class ReceivedRequests extends ConsumerStatefulWidget {
  const ReceivedRequests({super.key});

  @override
  ConsumerState<ReceivedRequests> createState() => _ReceivedRequestsState();
}

class _ReceivedRequestsState extends ConsumerState<ReceivedRequests> {
  TextEditingController searchController = TextEditingController();
  final Debounce _debounce = Debounce();

  @override
  dipose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recievedConnections = ref.watch(getRecievedConnections);
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(
          onTap: () {
            ref.refresh(getConnections);
            Navigator.pop(context);
          },
        ),
        appbarTitle: "Received Requests",
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
          addVerticalSpacing(16),
          recievedConnections.when(
              data: (Either<CustomException, List<dynamic>> data) {
            return Expanded(
              child: data.fold(
                (left) => Text(left.message),
                (right) {
                  if (right.isEmpty && !searchController.text.isEmptyOrNull) {
                    return EmptySearchResultsWidget();
                  }
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      HapticFeedback.lightImpact();
                      ref.refresh(getRecievedConnections.future);
                    },
                    child: right.isEmpty
                        ? EmptyPage(
                            svgPath: VIcons.documentLike,
                            svgSize: 30,
                            subtitle: "No connection requests received",
                          )
                        : ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: right.length,
                            itemBuilder: (BuildContext context, int index) {
                              var connection = right[index];
                              var connectionUser = connection['user'];

                              return Padding(
                                padding: const VWidgetsPagePadding
                                    .horizontalSymmetric(18),
                                child: connection['accepted'] == false
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
                                                            .deleteConnection(int
                                                                .parse(connection[
                                                                        'id']
                                                                    .toString()
                                                                    .trim()));
                                                        ref.refresh(
                                                            getRecievedConnections);
                                                        Navigator.pop(context);
                                                      },
                                                      onPressedNo: () {
                                                        Navigator.pop(context);
                                                      })));
                                        },
                                        onPressedAccept: () {
                                          ref
                                              .read(connectionProvider)
                                              .updateConnection(true,
                                                  int.parse(connection['id']));
                                          ref.refresh(getRecievedConnections);
                                        },
                                        onPressedProfile: () {
                                          navigateToRoute(
                                              context,
                                              OtherUserProfile(
                                                username:
                                                    connectionUser['username'],
                                              ));
                                          // navigateToRoute(
                                          //     context,
                                          //     const ProfileMainView(
                                          //         profileTypeEnumConstructor:
                                          //             ProfileTypeEnum.personal));
                                        },
                                        // userImage: connection['user']
                                        //         ['profilePictureUrl'] ??
                                        //     "assets/images/models/listTile_3.png",
                                        userImage:
                                            connectionUser['profilePictureUrl'],
                                        userImageThumbnail:
                                            connectionUser['thumbnailUrl'],
                                        userImageStatus: connectionUser[
                                                    'profilePictureUrl'] ==
                                                null
                                            ? false
                                            : true,
                                        subTitle:
                                            '${connectionUser['label'] ?? VMString.noSubTalentErrorText}',
                                        displayName:
                                            '${connectionUser['displayName']}',
                                        title: '${connectionUser['username']}',
                                        // '${connection['user']['firstName']} ${connection['user']['lastName']}',
                                        isVerified:
                                            connectionUser['isVerified'],
                                        blueTickVerified:
                                            connectionUser['blueTickVerified'],
                                      )
                                    : const SizedBox.shrink(),
                              );
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
