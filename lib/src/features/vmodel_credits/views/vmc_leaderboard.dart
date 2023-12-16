import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile.dart';
import 'package:vmodel/src/features/vmodel_credits/controller/vmc_controller.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/response_widgets/error_dialogue.dart';
import '../widgets/leadershipboards_card.dart';

class VMCLeaderboard extends ConsumerStatefulWidget {
  const VMCLeaderboard({super.key});

  @override
  ConsumerState<VMCLeaderboard> createState() => _VMCLeaderboardState();
}

class _VMCLeaderboardState extends ConsumerState<VMCLeaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboard = ref.watch(vmcLeaderboardProvider);
    return leaderboard.when(
        data: (data) {
          return Scaffold(
            appBar: VWidgetsAppBar(
              leadingIcon: VWidgetsBackButton(),
              appbarTitle: "VMC Leaderboard",
              elevation: 0,
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Points",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return VMCLeaderboardsCard(
                          profileImageUrl: data[index].thumbnailUrl,
                          username: data[index].username!,
                          userType: data[index].userType!,
                          points: data[index].totalPoints!.toInt().toString(),
                          onUserTapped: () => navigateToRoute(context, OtherUserProfile(username: data[index].username!)),
                        );
                      }),
                ),
              ],
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          print("$error $stackTrace");
          return CustomErrorDialogWithScaffold(
            title: "VMC Leaderboard",
            onTryAgain: () async => await ref.refresh(vmcLeaderboardProvider),
          );
        },
        loading: () => Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive())));
  }
}
