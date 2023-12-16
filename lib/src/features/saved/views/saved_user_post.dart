import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/core/utils/share.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/data/field_mock_data.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/add_to_boards_sheet.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/feed_row_icons.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/send.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/saved/controller/provider/saved_provider.dart'
    as Saved;
import 'package:vmodel/src/features/saved/views/saved_feed_carousel.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/typography/textstyle.dart';
import 'package:vmodel/src/shared/cupertino_modal_pop_up/cupertino_action_sheet.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../dashboard/feed/widgets/add_to_boards_sheet_v2.dart';

final showSavedProvider = StateProvider((ref) => false);

class SavedUserPost extends ConsumerStatefulWidget {
  const SavedUserPost({
    Key? key,
    required this.username,
    this.postId = -1,
    this.isLiked = false,
    required this.isSaved,
    this.likesCount = 0,
    required this.aspectRatio,
    required this.homeCtrl,
    required this.imageList,
    required this.smallImageAsset,
    required this.smallImageAssetThumbnail,
  }) : super(key: key);

  final int postId;
  final String username;
  final int likesCount;
  final bool isLiked;
  final bool isSaved;
  final UploadAspectRatio aspectRatio;
  final HomeController homeCtrl;
  // final List imageList;
  final List imageList;
  final String smallImageAsset;
  final String? smallImageAssetThumbnail;

  @override
  _SavedUserPostState createState() => _SavedUserPostState();
}

class _SavedUserPostState extends ConsumerState<SavedUserPost> {
  bool readMore = false;
  final showLoader = ValueNotifier(false);
  void showMore() {
    setState(() {
      readMore = !readMore;
    });
  }

  bool likeBool = false;
  void likePost() {
    setState(() {
      likeBool = !likeBool;
    });
  }

  bool saveBool = false;
  void savePost() {
    setState(() {
      saveBool = !saveBool;
    });
  }

  int tapCount = 0;

  int currentIndex = 0;
  bool _isExpanded = false;
  int lastTap = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    likeBool = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final futureWatch = ref.watch(mainFeedProvider);
    //! Below Scaffold is temporarily added on to column for testing purpose
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 20,
            right: 20,
            bottom: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // UserSmallImage(imageUrl: widget.smallImageAsset),
                  GestureDetector(
                      onTap: () {
                        navigateToRoute(
                            context,
                            OtherUserProfile(
                              username: widget.username,
                            ));
                      },
                      child: ProfilePicture(
                          showBorder: false,
                          url: widget.smallImageAsset,
                          headshotThumbnail: widget.smallImageAssetThumbnail,
                          size: 35)),
                  addHorizontalSpacing(8),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        navigateToRoute(
                            context,
                            OtherUserProfile(
                              username: widget.username,
                            ));
                      },
                      child: Text(
                        widget.username,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {
                  _modalBuilder(context, widget.username);
                },
                icon: const RenderSvg(
                  svgPath: VIcons.threeDotsIconVertical,
                  svgWidth: 4,
                  svgHeight: 4,
                ),
              ),
            ],
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return RawGestureDetector(
              gestures: {
                SerialTapGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<
                            SerialTapGestureRecognizer>(
                        () => SerialTapGestureRecognizer(),
                        (SerialTapGestureRecognizer instance) {
                  instance.onSerialTapDown = (SerialTapDownDetails details) {
                    tapCount = details.count;

                    if (details.count == 3) {
                      savePost();
                    } else if (details.count == 2) {
                      Future.delayed(const Duration(milliseconds: 150),
                          () async {
                        if (tapCount == 2) {
                          setState(() {
                            likeBool = true;
                          });
                          ref
                              .read(mainFeedProvider.notifier)
                              .onLikePost(postId: widget.postId)
                              .then((value) {
                            print("AAAAAAA value is Success $value");
                            setState(() {
                              likeBool = value;
                            });
                          });
                        }
                      });
                    }
                  };
                })
              },
              child: GestureDetector(
                onLongPress: () {
                  VUtilsShare.onShare(
                      context,
                      imagesList,
                      "VModel \nMy first shoot with Afrogarm. I’m so excited for the future to come! I never actually believed I would be picked when I applied, but I got in! I’m sooooooooo happy!",
                      "My first shoot with Afrogarm. I’m so excited for the future to come! I never actually believed I would be picked when I applied, but I got in! I’m sooooooooo happy!t");
                },
                child: SavedFeedCarousel(
                  aspectRatio: widget.aspectRatio,
                  imageList: widget.imageList,
                  onPageChanged: (value, reason) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  onTapImage: () {},
                ),
                // CarouselSlider(
                //   items: List.generate(
                //     widget.imageList.length,
                //     (index) => CachedNetworkImage(
                //       imageUrl: widget.imageList[index].url,
                //       width: double.infinity,
                //       height: double.infinity,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   options: CarouselOptions(
                //     viewportFraction: 1,
                //     aspectRatio: 0,
                //     initialPage: 0,
                //     enableInfiniteScroll: true,
                //     onPageChanged: (value, reason) {
                //       setState(() {
                //         currentIndex = value;
                //       });
                //     },
                //     height: 470,
                //   ),
                // ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Consumer(builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return FeedFirstRowIcons(
                      imageList: imagesList,
                      savedBool: widget.isSaved,
                      postUsername: widget.username,
                      postCaption: widget.imageList.first['description'],
                      saved: () {
                        HapticFeedback.lightImpact();
                        ref
                            .read(Saved.savepostProvider)
                            .savePost(widget.postId, saveBool);
                        savePost();
                        ref.read(showSavedProvider.notifier).state =
                            !ref.read(showSavedProvider.notifier).state;
                      },
                      like: () {
                        HapticFeedback.lightImpact();
                        likePost();
                        ref
                            .read(mainFeedProvider.notifier)
                            .onLikePost(postId: widget.postId);
                      },
                      likeCount: -83,
                      likedBool: likeBool,
                      onLongPressed: () {},
                      //new
                    );
                  })),
              if (widget.imageList.length > 1)
                Expanded(
                  flex: 2,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Theme.of(context).primaryColor,
                          Colors.transparent,
                          Colors.transparent,
                          Theme.of(context).primaryColor,
                        ],
                        stops: const [0.0, 1.0, 0.0, 1.0],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstOut,
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      alignment: WrapAlignment.center,
                      children: widget.imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          child: Container(
                            width: 5.92,
                            height: 5.95,
                            margin: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 2.525),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor.withOpacity(
                                  currentIndex == entry.key ? 1 : 0.2),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              FeedSecondRowIcons(
                send: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .85,
                          // minHeight: MediaQuery.of(context).size.height * .10,
                        ),
                        child: const SendWidget()),
                  );
                },
                shareFunction: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ShareWidget(
                      shareLabel: 'Share Post',
                      shareTitle: 'Samantha\'s Post',
                      shareImage: 'assets/images/doc/main-model.png',
                      shareURL: 'Vmodel.app/post/samantha-post',
                    ),
                  );
                },
                saveAmount: "",
              )
            ],
          ),
        ),

        addVerticalSpacing(15),
        Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _formatCaption('${widget.imageList.first['description']}'),
            // child: Text('slfjajfjdsajj'),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 18),
        //   child: ReadMoreText(
        //       'My first shoot with Jd Official. I’m so excited for the future to come! I never actually believed I would be picked when I applied, but I got in! I’m sooooooooo happy!',
        //       trimLines: 2,
        //       // colorClickableText: Colors.pink,
        //       trimMode: TrimMode.Line,
        //       trimCollapsedText: 'more',
        //       trimExpandedText: '',
        //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //           color: VmodelColors.text,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 14),
        //       lessStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
        //           color: VmodelColors.text2,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 14),
        //       moreStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
        //           color: VmodelColors.text2,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 14)),
        // ),
      ],
    );
  }

  void _modalBuilder(BuildContext context, String text) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              // title: Text(''),
              // message: Text(''),
              actions: <Widget>[
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                      color: VmodelColors.white,
                      text: 'Edit',
                      onPressed: () {
                        popSheet(context);
                        _showActionSheet(context, "Samanths");
                      }),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Share',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Save',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Send',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Copy Link',
                ),
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                    color: VmodelColors.white,
                    text: 'Archive',
                  ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Add to favourites',
                ),
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                    color: VmodelColors.white,
                    text: 'Make portfolio main photo',
                  ),
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                    color: VmodelColors.white,
                    text: 'Delete photo',
                    style: VmodelTypography2.kTitleRedStyle,
                  ),
              ],

              cancelButton: const VCupertinoActionSheet(
                text: 'Cancel',
              ),
            ));
  }

  void _showActionSheet(BuildContext context, String text) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <Widget>[
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'follow user',
                  onPressed: () {
                    popSheet(context);
                    _showActionSheet2(context);
                  },
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Share',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Save',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Send',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Message model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Book model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Report photo',
                  style: VmodelTypography2.kTitleRedStyle,
                ),
              ],
              cancelButton: const VCupertinoActionSheet(
                text: 'Cancel',
              ),
            ));
  }

  void _showActionSheet2(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <Widget>[
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'unfollow user',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Share',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Save',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Send',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Message model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Book model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Report photo',
                  style: VmodelTypography2.kTitleRedStyle,
                ),
              ],
              cancelButton: const VCupertinoActionSheet(
                text: 'cancel',
              ),
            ));
  }

  Widget _formatCaption(String caption) {
    if (caption.isEmpty) {
      return const SizedBox.shrink();
    }

    final tokens = caption.split(' ');

    final children = <InlineSpan>[
      TextSpan(
        text: "${widget.username} ",
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: VmodelColors.text,
              fontWeight: FontWeight.w600,
            ),
      ),
    ];
    final parent = AutoSizeText.rich(
      TextSpan(
        children: children,
      ),
      overflow: TextOverflow.visible,
      // maxLines: 3,
      maxLines: _isExpanded ? null : 3,

      // overflowReplacement: Text('hello'),
    );
    for (String token in tokens) {
      if (token.startsWith('@')) {
        final mentionedUsername = token.substring(1);
        //blue it
        children.add(
          TextSpan(
            text: "$mentionedUsername ",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigateToRoute(
                    context, OtherUserProfile(username: mentionedUsername));
              },
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: VmodelColors.text2,
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      } else if (token.startsWith('*')) {
        String textToBold = token.replaceAll('*', '');

        children.add(
          TextSpan(
            text: "$textToBold ",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // navigateToRoute(
                //     context, OtherUserProfile(username: mentionedUsername));
              },
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  // color: VmodelColors.text2,
                  fontWeight: FontWeight.w700,
                ),
          ),
        );
      } else {
        children.add(
          TextSpan(
            text: "$token ",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: VmodelColors.text,
                  fontWeight: FontWeight.w500,
                ),
          ),
        );
      }
    }

    // children.insert(0,
    //
    //   TextSpan(
    //     text: _isExpanded ? ' Less ' : "..more ",
    //     recognizer: TapGestureRecognizer()..onTap = () {
    //       setState(() {
    //         _isExpanded = !_isExpanded;
    //       });
    //   },
    //     style: Theme.of(context).textTheme.displaySmall!.copyWith(
    //       color: VmodelColors.text,
    //       fontWeight: FontWeight.w600,
    //     ),
    //   )
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        parent,
        if (caption.length > 148)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _isExpanded == false ? '...more' : 'Less',
                style: const TextStyle(
                  fontSize: 12,
                ),
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
    // return
    //   ExpandableText(maxLines: 4, text: caption);
  }
}
