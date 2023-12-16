import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../features/dashboard/feed/controller/new_feed_provider.dart';
import '../models/user_prefs_config.dart';

final userPrefsProvider =
    AsyncNotifierProvider<UserPrefsNotifier, UserPrefsConfig>(
        UserPrefsNotifier.new);

class UserPrefsNotifier extends AsyncNotifier<UserPrefsConfig> {
  late final Box prefsBox;
  @override
  Future<UserPrefsConfig> build() async {
    try {
      prefsBox = await Hive.openBox('user_prefs');
      final hiveConfigs = Map<String, dynamic>.from(prefsBox.toMap());
      final config = UserPrefsConfig.defaultConfig();

      final myconfig = UserPrefsConfig.fromMap(hiveConfigs);

      ref.read(isProViewProvider.notifier).state =
          myconfig.isDefaultFeedViewSlides;

      // final isDefaultViewSlides = await ref.watch(userPrefsProvider
      //     .selectAsync((value) => value.isDefaultFeedViewSlides));

      // ref
      //     .read(authenticationStatusProvider.notifier)
      //     .update((p0) => myconfig.savedAuthStatus);
      print('[mm] $myconfig');

      return myconfig;
    } catch (err, st) {
      print('[mm] $err \n $st');
    }
    return UserPrefsConfig.defaultConfig();
  }

  void addOrUpdatePrefsEntry(UserPrefsConfig newConfig) {
    print('[lol] new update $newConfig');
    state = AsyncData(newConfig);
    prefsBox.putAll(newConfig.toMap());
    ref.read(isProViewProvider.notifier).state =
        newConfig.isDefaultFeedViewSlides;
  }

  void updateEntry(String key, dynamic value) {
    prefsBox.put(key, value);
  }
}
