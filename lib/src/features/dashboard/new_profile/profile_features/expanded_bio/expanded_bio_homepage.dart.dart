import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/expanded_bio/expanded_bio_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../profile/controller/profile_controller.dart';

class ExpandedBioHomepage extends ConsumerStatefulWidget {
  const ExpandedBioHomepage({super.key, required this.username});
  final String username;
  @override
  ConsumerState<ExpandedBioHomepage> createState() =>
      _ExpandedBioHomepageState();
}

class _ExpandedBioHomepageState extends ConsumerState<ExpandedBioHomepage> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(profileProvider(widget.username));
    final appUser = ref.watch(appUserProvider);
    final currentUser = appUser.valueOrNull;

    final user = currentUser?.username == widget.username
        ? currentUser
        : userState.valueOrNull;

    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "About You",
      ),
      body: ExpandedBioWidget(
        profileUrl: '${user?.profilePictureUrl}',
        thumbnailUrl: '${user?.thumbnailUrl}',
        firstName: user!.firstName,
        lastName: user.lastName,
        userType: user.userType,
        location: user.location?.locationName ?? '',
        height: user.height?.value,
        size: "Small",
        minimumFee: "1000/Service",
        bio: user.bio,
      ),
    );
  }
}
