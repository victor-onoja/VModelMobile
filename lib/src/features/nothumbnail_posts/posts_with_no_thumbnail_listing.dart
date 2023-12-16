import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../core/controller/app_user_controller.dart';
import '../../core/utils/enum/upload_ratio_enum.dart';
import '../../res/icons.dart';
import '../../shared/buttons/text_button.dart';
import '../../shared/empty_page/empty_page.dart';
import '../../shared/picture_styles/rounded_square_avatar.dart';
import '../create_posts/controller/create_post_controller.dart';
import 'posts_with_no_thumbnail_controller.dart';

class PostsWithoutThumbnails extends ConsumerStatefulWidget {
  const PostsWithoutThumbnails({super.key});

  @override
  ConsumerState<PostsWithoutThumbnails> createState() =>
      _PostsWithoutThumbnailsState();
}

class _PostsWithoutThumbnailsState
    extends ConsumerState<PostsWithoutThumbnails> {
  final isReposting = ValueNotifier<bool>(false);
  final processingPostId = ValueNotifier<int>(-100);
  final itemsCount = 50;

  @override
  Widget build(BuildContext context) {
    final appUser = ref
        .watch(appUserProvider.select((value) => value.valueOrNull?.username));
    final posts = ref.watch(postsWithoutThumbnailProvider);
    final totalCount =
        ref.read(postsWithoutThumbnailProvider.notifier).totalPostCount;

    final captionStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
          color: Theme.of(context).textTheme.displayMedium?.color,
          fontSize: 10.sp,
        );
    final greyedStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
          color: Theme.of(context)
              .textTheme
              .displayMedium
              ?.color
              ?.withOpacity(0.5),
          fontSize: 10.sp,
        );
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Reuploads",
        trailingIcon: [
          posts.maybeWhen(data: (items) {
            return ValueListenableBuilder(
                valueListenable: isReposting,
                builder: (context, value, _) {
                  return VWidgetsTextButton(
                    showLoadingIndicator: value,
                    text: "Repost",
                    onPressed: () async {
                      if (items == null || items.isEmpty) {
                        return;
                      }
                      isReposting.value = true;
                      for (int i = 0;
                          i < math.min(items.length, itemsCount);
                          i++) {
                        processingPostId.value = items[i].id;
                        await Future.delayed(Duration(seconds: 3));
                        await ref
                            .read(createPostProvider(null).notifier)
                            .createPostThumbnailOnly(
                                invalidateGallery:
                                    appUser == items[i].postedBy.username,
                                postId: items[i].id.toString(),
                                photos: items[i].photos);
                        ref
                            .read(postsWithoutThumbnailProvider.notifier)
                            .removePostWithThumbnail(items[i].id);
                      }
                      processingPostId.value = -100;
                      isReposting.value = false;
                    },
                    textStyle: context.textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                });
          }, orElse: () {
            return SizedBox.shrink();
          })
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await ref.refresh(postsWithoutThumbnailProvider.future);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: posts.when(data: (items) {
            if (items == null || items.isEmpty) {
              return const EmptyPage(
                svgSize: 30,
                svgPath: VIcons.gridIcon,
                // title: 'No Galleries',
                subtitle: 'No posts found',
              );
            }
            return ListView.separated(
              itemCount: itemsCount + 1,
              itemBuilder: ((context, index) {
                if (index == 0) {
                  return Text(
                    'Showing $itemsCount out of $totalCount posts (${items.length})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: greyedStyle,
                  );
                }
                final item = items[index - 1];
                return ListTile(
                  title: Text(
                    item.caption.isEmptyOrNull
                        ? 'No caption'
                        : '${item.caption}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: captionStyle,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '@${item.postedBy.displayName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: greyedStyle,
                        ),
                      ),
                      // addHorizontalSpacing(16),
                      Text(
                        '${item.photos.length} photos',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: greyedStyle,
                      ),
                      // addHorizontalSpacing(16),
                      // Text(
                      //   '',
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: greyedStyle,
                      // ),
                    ],
                  ),
                  leading: SizedBox.fromSize(
                    size: UploadAspectRatio.portrait.sizeFromX(30),
                    child: Stack(
                      children: [
                        RoundedSquareAvatar(
                          url: item.photos.first.url,
                          thumbnail: '',
                          radius: 3,
                          size: UploadAspectRatio.portrait.sizeFromX(30),
                          errorWidget: ColoredBox(color: Colors.grey.shade400),
                        ),
                        ValueListenableBuilder(
                            valueListenable: processingPostId,
                            builder: (context, value, _) {
                              if (value != item.id) return SizedBox.fromSize();
                              return Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                    child: SizedBox.square(
                                  dimension: 14,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.white,
                                  ),
                                )),
                              );
                            })
                      ],
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) => const Divider(),
            );
          }, error: (err, st) {
            print('$err $st');

            return const EmptyPage(
              svgSize: 30,
              svgPath: VIcons.gridIcon,
              // title: 'No Galleries',
              subtitle: 'Error fetching posts',
            );
          }, loading: () {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }),
        ),
      ),
    );
  }
}
