import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/saved/controller/provider/saved_provider.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../dashboard/discover/views/explore.dart';
import '../controller/provider/board_posts_controller.dart';
import '../controller/provider/current_selected_board_provider.dart';
import '../controller/provider/user_boards_controller.dart';
import '../model/user_post_board_model.dart';
import '../widgets/text_overlayed_image.dart';
import 'explore_v2.dart';

class UserCreatedBoardsWidget extends ConsumerStatefulWidget {
  const UserCreatedBoardsWidget(
      {super.key,
      required this.boards,
      required this.mockImages,
      required this.scrollBack,
      this.title,
      this.itemSize,
      this.buttonPadding = EdgeInsets.zero,
      this.mainAxisSpacing = 12,
      this.crossAxisSpacing = 12});

  final Size? itemSize;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List mockImages;
  final List<UserPostBoard> boards;
  final String? title;
  final VoidCallback scrollBack;
  final EdgeInsetsGeometry buttonPadding;

  @override
  ConsumerState<UserCreatedBoardsWidget> createState() =>
      UserCreatedBoardsWidgetState();
}

class UserCreatedBoardsWidgetState
    extends ConsumerState<UserCreatedBoardsWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final totalBoardsNumber = ref.watch(userBoardsTotalNumberProvider);

    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      key: Key("value"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        Wrap(
          spacing: widget.mainAxisSpacing,
          runSpacing: widget.crossAxisSpacing,
          children: [
            for (var index = 0;
                !isExpanded
                    ? index > 2
                        ? index < 2
                        : index < widget.boards.length
                    : index < widget.boards.length;
                index++)
              Padding(
                  // padding: const EdgeInsets.all(8.0),
                  padding: EdgeInsets.zero,
                  child: TextOverlayedImage(
                    size: widget.itemSize,
                    imageUrl: '${widget.boards[index].coverImageUrl}',
                    title: widget.boards[index].title,
                    // imageProvider: AssetImage(
                    //     widget.mockImages[index % widget.mockImages.length]),
                    gradientStops: [0.75, 1],
                    onTap: () {
                      print(
                          '[lsox ${widget.boards[index].title} tapped navigating');

                      ref
                          .read(currentSelectedBoardProvider.notifier)
                          .setOrUpdateBoard(
                            SelectedBoard(
                              board: widget.boards[index],
                              source: SelectedBoardSource.userCreatd,
                            ),
                          );
                      navigateToRoute(
                          context,
                          ExploreV2(
                            title: widget.boards[index].title,
                            providerType: BoardProvider.userCreated,
                            // userPostBoard: widget.boards[index],
                          ));
                    },
                    onLongPress: () {},
                  )),
          ],
        ),
        addVerticalSpacing(10),
        if (widget.boards.length > 3)
          Padding(
            padding: widget.buttonPadding,
            child: VWidgetsPrimaryButton(
              buttonColor: Theme.of(context).buttonTheme.colorScheme!.secondary,
              onPressed: () {
                // setState(() => isExpanded = !isExpanded);
                // if (!isExpanded) {
                //   widget.scrollBack();
                // }
                _buttonPressed();
              },
              // buttonTitle: isExpanded ? "Collapse" : "Expand",
              buttonTitle: _buttonText,
              buttonTitleTextStyle:
                  Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.w600,
                        // fontSize: 12.sp,
                      ),
            ),
          )
      ],
    );
  }

  void _buttonPressed() {
    final totalBoardsNumber = ref.watch(userBoardsTotalNumberProvider);
    if (!isExpanded) {
      isExpanded = true;
      setState(() {});
    } else if (totalBoardsNumber > widget.boards.length) {
      //loadMore
      ref.read(userPostBoardsProvider.notifier).fetchMoreData();
      isExpanded = true;
      setState(() {});
    } else {
      setState(() => isExpanded = !isExpanded);
      if (!isExpanded) {
        widget.scrollBack();
      }
    }
  }

  String get _buttonText {
    final totalBoardsNumber = ref.watch(userBoardsTotalNumberProvider);
    if (isExpanded && totalBoardsNumber == widget.boards.length) {
      return "Collapse";
    }
    return "Expand";
  }
}
