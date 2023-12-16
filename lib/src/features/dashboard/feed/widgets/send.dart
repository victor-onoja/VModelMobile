import 'package:either_option/either_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/connection/controller/provider/my_connections_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/shimmer/widgets/circle_avatar_two_line_tile.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';

class SendWidget extends ConsumerStatefulWidget {
  const SendWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<SendWidget> createState() => _SendWidgetState();
}

class _SendWidgetState extends ConsumerState<SendWidget> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> mockData = [];
  bool loaded = false;
  List selectedList = [];
  int shimmerLength = 15;

  late final Debounce _debounce;

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
    final connections = ref.watch(searchConnections);

    if (!loaded) {
      connections.when(
          data: (Either<CustomException, List<dynamic>> data) {
            return data.fold((p0) => const SizedBox.shrink(), (p0) {
              mockData =
                  List.generate(p0.length, (index) => {"selected": false});
              loaded = true;
            });
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {});
    }
    // }
    return SafeArea(
      child: Container(
        // height: 600,
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: VConstants.bottomPaddingForBottomSheets,
        ),
        decoration: BoxDecoration(
            // color: Colors.white,
            // color: Theme.of(context).colorScheme.surface,
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: VmodelColors.primaryColor.withOpacity(0.15),
                ),
              ),
            ),
            addVerticalSpacing(20),
            Text(
              "Send to",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  // color: VmodelColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            addVerticalSpacing(15),
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (String? val) {
                if (val != null) {
                  _debounce(() => ref
                      .read(myConnectionsSearchProvider.notifier)
                      .state = val);
                } else {
                  ref.watch(searchConnections);
                }
              },
              hintText: "Search...",
            ),
            // TextFormField(
            //   controller: searchController,
            //   onChanged: (String? val) {
            //     if (val != null) {
            //       _debounce(() => ref
            //           .read(myConnectionsSearchProvider.notifier)
            //           .state = val);
            //     } else {
            //       ref.watch(searchConnections);
            //     }
            //   },
            //   decoration: InputDecoration(
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //           color: Theme.of(context).primaryColor, width: 1.5),
            //     ),
            //     border: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //           color: Theme.of(context).primaryColor, width: 1.5),
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //           color: Theme.of(context).primaryColor, width: 1.5),
            //     ),
            //     hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            //         color: Theme.of(context).primaryColor.withOpacity(0.5),
            //         fontSize: 11.sp,
            //         overflow: TextOverflow.clip),
            //     hintText: "Search...",
            //     constraints: const BoxConstraints(maxHeight: 50),
            //     contentPadding: VWidgetsPagePadding.only(2, 2, 17),
            //   ),
            // ),

            addVerticalSpacing(10),
            Flexible(
                child: connections.when(
                    data: (Either<CustomException, List<dynamic>> data) {
                      return data.fold((p0) => const SizedBox.shrink(), (p0) {
                        shimmerLength = p0.length;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: p0.length,
                          itemBuilder: (context, index) {
                            var connection = p0[index];
                            return Column(
                              children: [
                                SendOption(
                                  imagePath: connection['profilePictureUrl'],
                                  title: '${connection['username']}',
                                  subtitle: connection['userType'],
                                  selected: mockData[index]["selected"],
                                  onTap: () {
                                    setState(() {
                                      mockData[index]["selected"] =
                                          !mockData[index]["selected"];
                                      if (mockData[index]["selected"] == true) {
                                        selectedList
                                            .add(mockData[index]["selected"]);
                                      } else {
                                        selectedList.removeAt(0);
                                      }
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    error: (Object error, StackTrace stackTrace) =>
                        const SizedBox.shrink(),
                    loading: () {
                      return ListView.separated(
                          itemCount: shimmerLength,
                          padding: EdgeInsets.symmetric(vertical: 25),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return addVerticalSpacing(16);
                          },
                          itemBuilder: (context, index) {
                            return CircleAvatarTwoLineTileShimmer();
                          });
                    })),
            addVerticalSpacing(15),
            VWidgetsPrimaryButton(
              buttonTitle: "Send",
              enableButton: selectedList.isNotEmpty ? true : false,
              onPressed: () {},
            ),
            addVerticalSpacing(20)
          ],
        ),
      ),
    );
  }
}

class SendOption extends StatelessWidget {
  const SendOption({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.selected,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String imagePath;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePicture(
                    url: imagePath,
                    headshotThumbnail: imagePath,
                    size: 35,
                    showBorder: false,
                  ),
                  addHorizontalSpacing(8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  // color: VmodelColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        addVerticalSpacing(4),
                        Text(
                          subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  // color: const Color.fromRGBO(80, 60, 59, 0.35),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.35),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: selected
                  ? const Icon(
                      Icons.radio_button_checked_rounded,
                      // color: VmodelColors.primaryColor,
                    )
                  : Icon(
                      Icons.radio_button_off_rounded,
                      // color: VmodelColors.primaryColor.withOpacity(0.5),
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
            ),
          ],
        ));
  }
}
