import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/models/user_service_modal.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/views/new_service_detail.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/service_sub_item.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/user_service_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/response_widgets/toast_dialogue.dart';
import 'package:vmodel/src/vmodel.dart';

class ServiceSubList extends ConsumerStatefulWidget {
  final String title;
  final List<ServicePackageModel> items;
  final bool? eachUserHasProfile;
  final Widget? route;
  final ValueChanged onTap;
  final VoidCallback? onViewAllTap;
  final bool isCurrentUser;
  final String username;
  const ServiceSubList({
    Key? key,
    required this.isCurrentUser,
    required this.username,
    required this.title,
    required this.items,
    required this.onTap,
    this.onViewAllTap,
    this.eachUserHasProfile = false,
    this.route,
  }) : super(key: key);

  @override
  ConsumerState<ServiceSubList> createState() => _ServiceSubListState();
}

class _ServiceSubListState extends ConsumerState<ServiceSubList> {
  bool? isSaved;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final _currentUser = ref.watch(appUserProvider).valueOrNull;
    final _iscurrentUser = ref
        .read(appUserProvider.notifier)
        .isCurrentUser(_currentUser?.username);
    return Column(
      children: [
        addVerticalSpacing(10),
        GestureDetector(
          onTap: () {
            widget.onViewAllTap?.call();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "View all".toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                ),
              ],
            ),
          ),
        ),
        addVerticalSpacing(9),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "No data for ${widget.title}",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(),
            ),
          ),
        if (widget.items.isNotEmpty)
          SizedBox(
            height: SizerUtil.height * 0.35,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ServiceSubItem(
                      user: _currentUser!,
                      item: widget.items[index],
                      onTap: () => navigateToRoute(
                        context,
                        ServicePackageDetail(
                          service: widget.items[index],
                          isCurrentUser: _iscurrentUser,
                          username: widget.username,
                        ),
                      ),
                      onLongPress: () async {},
                    ),
                  );
                }),
          ),
        addVerticalSpacing(5),
      ],
    );
  }
}
