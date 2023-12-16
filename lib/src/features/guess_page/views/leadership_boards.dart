import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../core/utils/shared.dart';
import '../widgets/leadershipboards_card.dart';

class LeadershipBoards extends StatefulWidget {
  const LeadershipBoards({super.key});

  @override
  State<LeadershipBoards> createState() => _LeadershipBoardsState();
}

class _LeadershipBoardsState extends State<LeadershipBoards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Leadershipboards",
        leadingIcon: VWidgetsBackButton(),
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Player",
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
                itemCount: 20,
                itemBuilder: (context, index) {
                  return VWidgetsLeadershipboards(
                    profileImageUrl: VMString.testImageUrl,
                    displayName: 'Jane Doe',
                    points: 25.toString(),
                    onUserTapped: () {},
                  );
                }),
          ),
        ],
      ),
    );
  }
}
