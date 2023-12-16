import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/helper_functions.dart';
import '../controllers/hash_tag_search_controller.dart';
import '../views/discover_user_search.dart/views/discover_hashtag_search_grid.dart';
import '../views/explore.dart';

class UserTypesWidget extends ConsumerStatefulWidget {
  const UserTypesWidget({
    super.key,
    required this.mockImages,
    required this.title,
    required this.scrollBack,
    this.itemSize,
  });

  final Size? itemSize;
  final List mockImages;
  final String title;
  final VoidCallback scrollBack;

  @override
  ConsumerState<UserTypesWidget> createState() => _UserTypesWidgetState();
}

class _UserTypesWidgetState extends ConsumerState<UserTypesWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      key: Key("value"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 1,
            runSpacing: 1,
            children: [
              if (isExpanded)
                for (var index = 0;
                    index < VConstants.tempCategories.length;
                    index++)
                  GestureDetector(
                    onTap: () {
                      ref.read(hashTagSearchProvider.notifier).state =
                          formatAsHashtag(VConstants.tempCategories[index]);
                      navigateToRoute(context, Explore());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:
                            widget.itemSize?.height ?? SizerUtil.height * 0.22,
                        width:
                            widget.itemSize?.width ?? SizerUtil.height * .203,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.secondary,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              widget.mockImages[index],
                            ),
                          ),
                        ),
                        child: Container(
                          height: SizerUtil.height,
                          width: SizerUtil.width,
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.6,
                                    1
                                  ],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black87
                                  ])),
                          child: Text(
                            VConstants.tempCategories[index],
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
              if (!isExpanded)
                for (var index = 0; index < 2; index++)
                  GestureDetector(
                    onTap: () {
                      ref.read(hashTagSearchProvider.notifier).state =
                          formatAsHashtag(VConstants.tempCategories[index]);
                      navigateToRoute(context, Explore());
                      // navigateToRoute(context,
                      //      HashtagSearchGridPage(
                      //       posts: data,
                      //       title: ref.watch(hashTagSearchProvider)!
                      //     );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:
                            widget.itemSize?.height ?? SizerUtil.height * 0.22,
                        width:
                            widget.itemSize?.width ?? SizerUtil.height * .203,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              widget.mockImages[index],
                            ),
                          ),
                        ),
                        child: Container(
                          height: SizerUtil.height,
                          width: SizerUtil.width,
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.6,
                                    1
                                  ],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black87
                                  ])),
                          child: Text(
                            VConstants.tempCategories[index],
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        addVerticalSpacing(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: VWidgetsPrimaryButton(
            buttonColor: Theme.of(context).buttonTheme.colorScheme!.secondary,
            onPressed: () {
              setState(() => isExpanded = !isExpanded);
              if (!isExpanded) {
                widget.scrollBack();
              }
            },
            buttonTitle: isExpanded ? "Collapse" : "Expand",
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
}
