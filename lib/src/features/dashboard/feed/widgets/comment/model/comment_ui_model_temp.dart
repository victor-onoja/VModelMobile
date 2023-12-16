// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/create_posts/models/photo_post_model.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/models/app_user.dart';

//Temporal class to handle consolidating the data needed for the comment page
// since different models are used for a user's gallery feed and for the
// main feed.

@immutable
class CommentModelForUI {
  final int postId;
  final String username;
  final String postTime;
  final UploadAspectRatio aspectRatio;
  final List<PhotoPostModel> imageList;
  final List<VAppUser> userTagList;
  final String smallImageAsset;
  final String smallImageThumbnail;
  final bool isVerified;
  final bool blueTickVerified;
  final bool isOwnPost;
  final bool isPostLiked;
  final bool isPostSaved;
  final String caption;
  final int likesCount;

  CommentModelForUI({
    required this.postId,
    required this.username,
    required this.postTime,
    required this.aspectRatio,
    required this.imageList,
    required this.userTagList,
    required this.smallImageAsset,
    required this.smallImageThumbnail,
    required this.isVerified,
    required this.blueTickVerified,
    required this.isOwnPost,
    required this.isPostLiked,
    required this.isPostSaved,
    required this.caption,
    required this.likesCount,
  });
}
