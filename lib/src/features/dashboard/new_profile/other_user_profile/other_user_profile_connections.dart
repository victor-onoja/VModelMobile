import 'package:either_option/either_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/other_user_connection_card.dart';
import 'package:vmodel/src/features/dashboard/profile/widget/connection_shimmer.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class OtherUserProfileConnect extends ConsumerStatefulWidget {
  final String? username;
  const OtherUserProfileConnect({super.key, required this.username});

  @override
  ConsumerState<OtherUserProfileConnect> createState() =>
      _OtherUserProfileConnectState();
}

class _OtherUserProfileConnectState
    extends ConsumerState<OtherUserProfileConnect> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final connections = ref.watch(getUserConnections(widget.username!));
    return Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          appbarTitle: "${widget.username}",
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
                        child: VWidgetsPrimaryTextFieldWithTitle(
                      hintText: "Search",
                      controller: searchController,
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: const RenderSvg(
                            svgPath: VIcons.roundedCloseIcon,
                            svgHeight: 20,
                            svgWidth: 20,
                          )),
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
              Expanded(
                child: data.fold(
                  (p0) => Text(p0.message),
                  (p0) {
                    return ListView.builder(
                      itemCount: p0.length,
                      itemBuilder: (BuildContext context, int index) {
                        var connection = p0[index];
                        return Padding(
                          padding:
                              const VWidgetsPagePadding.horizontalSymmetric(18),
                          child: VWidgetsOtherUserNetworkPageCard(
                            onPressedProfile: () {
                              navigateToRoute(
                                  context,
                                  OtherUserProfile(
                                    username: connection['username'],
                                  ));
                            },
                            userImage: connection['profilePictureUrl'] ??
                                "assets/images/models/listTile_3.png",
                            userImageStatus:
                                connection['profilePictureUrl'] == null
                                    ? false
                                    : true,
                            userName: '${connection['username']}',
                            userNickName:
                                '${connection['firstName']} ${connection['lastName']}',
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }, loading: () {
          return const ConnectionShimmerPage();
        }, error: (Object error, StackTrace stackTrace) {
          return Text(stackTrace.toString());
        }));
  }
}
