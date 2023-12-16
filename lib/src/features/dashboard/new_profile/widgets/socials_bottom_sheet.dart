import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../core/routing/navigator_1.0.dart';
import '../../../../res/colors.dart';
import '../../../../res/gap.dart';
import '../../../../shared/buttons/text_button.dart';
import 'package:vmodel/src/core/models/user_socials.dart';

import '../../../../shared/modal_pill_widget.dart';
import '../../profile/view/webview_page.dart';

class SocialsBottomSheet extends ConsumerWidget {
  SocialsBottomSheet({
    super.key,
    required this.title,
    // required this.username,
    required this.userSocials,
  });

  final String title;
  // final String username;
  final UserSocials userSocials;

  final List<String> titles = [
    'Instagram',
    'Tiktok',
    'Youtube',
    'Twitter',
    'Facebook',
    'Pinterest',
    'snapchat',
    'reddit',
    'patreon',
    'linkedin',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String couponCode = 'Welcometonikediscount'.toUpperCase();

    // final requrestUsername = ref.watch(userNameForApiRequestProvider(username));
    // final appUser = requrestUsername == null
    //     ? ref.watch(appUserProvider)
    //     : ref.watch(profileProvider(requrestUsername));
    // final user = appUser.valueOrNull;
    // final userSocials = user?.socials;

    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.9,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      decoration: BoxDecoration(
        // color: VmodelColors.white,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(24),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addVerticalSpacing(16),
          Flexible(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: RawScrollbar(
                mainAxisMargin: 4,
                crossAxisMargin: -8,
                thumbVisibility: true,
                thumbColor: VmodelColors.primaryColor.withOpacity(0.3),
                thickness: 4,
                radius: const Radius.circular(10),
                child: ListView(
                  shrinkWrap: true,
                  children: List.generate(titles.length, (index) {
                    final item = _getIsSocialAvailable(index, userSocials);
                    if (item.key) {
                      return _itemTile(
                        context,
                        title: titles[index],
                        value: item.value,
                        url: userSocials.getSocialLink(social: titles[index]),
                      );
                    }
                    return const SizedBox.shrink();
                  }).toList(),
                ),
              ),
            ),
          ),
          addVerticalSpacing(16),
          VWidgetsTextButton(
            text: 'Close',
            onPressed: () => goBack(context),
          ),
          addVerticalSpacing(24),
        ],
      ),
    );
  }

  MapEntry<bool, String> _getIsSocialAvailable(
      int index, UserSocials userSocials) {
    switch (index) {
      case 0:
        return MapEntry(_isUsernameAvailable(userSocials.instagram),
            userSocials.instagram?.username ?? '');
      case 1:
        return MapEntry(_isUsernameAvailable(userSocials.tiktok),
            userSocials.tiktok?.username ?? '');
      case 2:
        return MapEntry(_isUsernameAvailable(userSocials.youtube),
            userSocials.youtube?.username ?? '');
      case 3:
        return MapEntry(_isUsernameAvailable(userSocials.twitter),
            userSocials.twitter?.username ?? '');
      case 4:
        return MapEntry(_isUsernameAvailable(userSocials.facebook),
            userSocials.facebook?.username ?? '');
      case 5:
        return MapEntry(_isUsernameAvailable(userSocials.pinterest),
            userSocials.pinterest?.username ?? '');
      case 6:
        return MapEntry(_isUsernameAvailable(userSocials.snapchat),
            userSocials.snapchat?.username ?? '');
      case 7:
        return MapEntry(_isUsernameAvailable(userSocials.reddit),
            userSocials.reddit?.username ?? '');
      case 8:
        return MapEntry(_isUsernameAvailable(userSocials.patreon),
            userSocials.patreon?.username ?? '');
      case 9:
        return MapEntry(_isUsernameAvailable(userSocials.linkedin),
            userSocials.linkedin?.username ?? '');
      default:
        return const MapEntry(false, '');
    }
  }

  bool _isUsernameAvailable(UserSocialInfo? social) {
    return social != null ? !social.username.isEmptyOrNull : false;
  }

  Widget _itemTile(BuildContext context,
      {required String title, required String value, required String url}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      // color: VmodelColors.primaryColor,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.maxFinite,
          child: TextButton(
            style: TextButton.styleFrom(
              // backgroundColor: VmodelColors.white,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              navigateToRoute(context, WebViewPage(url: url));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // snapshot.data[index]['code']
                      value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            // color: VmodelColors.primaryColor,
                          ),
                    ),
                    // const RenderSvgWithoutColor(
                    //   svgPath: VIcons.copyCouponIcon,
                    //   svgHeight: 14,
                    //   svgWidth: 14,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        addVerticalSpacing(8),
      ],
    );
  }
}
