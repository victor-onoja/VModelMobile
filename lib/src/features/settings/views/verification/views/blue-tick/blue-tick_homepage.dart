import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/blue-tick_business_page.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../blue_tick_talent_form.dart';
import 'blue-tick_onboarding.dart';

// must move to better place
class SocialMediaInfo {
  String? platform;
  String? username;
  SocialMediaInfo({this.platform, this.username});
}

class ArticleInfo {
  String? articleLink;
  ArticleInfo({this.articleLink});
}

class BlueTickHomepage extends ConsumerStatefulWidget {
  const BlueTickHomepage({super.key});

  @override
  ConsumerState<BlueTickHomepage> createState() => _BlueTickHomepageState();
}

class _BlueTickHomepageState extends ConsumerState<BlueTickHomepage> {
  final pageIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(appUserProvider).valueOrNull;
    return ValueListenableBuilder(
      valueListenable: pageIndex,
      builder: (context, value, child) {
        if (user == null || value == 0) {
          return BlueTickOnboarding(pageIndex: pageIndex);
        }
        if (user.isBusinessAccount ?? false) {
          return const BlueTickBusinessPage();
        }
        return const BlueTickCreative();
      },
    );
  }
}
